package com.pyro.engine.core 
{
	/**
	 * PyroCore input controller
	 * 
	 * @author Robbie Carrington Jr.
	 * @author Leland Ede
	 */
	//import com.pblabs.animation.PointAnimator;
	import com.pyro.engine.character.PeCharacter;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import com.pyro.engine.objects.PePoint;
	import flash.geom.Point;
	import com.pyro.engine.debug.PeLogger;
	
	import com.pyro.engine.PE;

	public class InputController extends EventDispatcher implements IPeController
	{
		private static var _clickPoint:Array;
		private static var _isClicked:Boolean = false;
		private static var _keyboardController:InKey;
		
		private var _keyEventsArray:Array;
		private var _keyUpArray:Array;
		private var processKeyUp:Boolean;
		private var stage:Stage;
		private var Play:PeCharacter;
		private var myPos:PePoint;
		private var _layer:int;
		
		public function InputController(inStage:Stage)
		{
			_keyboardController = new InKey(); // intialize the keyboard controller
			// Initialize event array
			_keyEventsArray = [];
			_keyUpArray = [];
			
			// Setup stage and events
			stage = inStage;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyboardController.onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyboardController.onKeyUp);
			processKeyUp = false;
		}
		
		public function onClick(e:MouseEvent):void
		{
			_isClicked = true;
			_clickPoint.push(new Point(e.stageX, e.stageY));
		}
		
		public static function get clickPoint():Point
		{
			var point:Point = null;
			if (_isClicked)
			{
				point = _clickPoint.shift();
				if (_clickPoint.length() == 0)
				{
					_isClicked = false;
				}
			}
			return point;
		}
		
		public function addKeyEvent(code:int, func:Function):void
		{
			if (!(_keyEventsArray[code] is PeKeyedEvent))
			{
				_keyEventsArray[code] = new PeKeyedEvent(code);
			}
			
			PeKeyedEvent(_keyEventsArray[code]).functionArray.push(func);
		}
		
		public function addKeyPressUp(code:int, func:Function):void
		{
			_keyboardController.addKeyPressUp(code, func);
		}
		
		/**
		 * Add a key event that will only run once
		 * @param	code
		 * @param	func
		 */
		public function addKeyPress(code:int, func:Function):void
		{
			keyboardController.addKeyPressDown(code, func);
		}
		
		/**
		 * Add a key up event
		 * 
		 * @param	function
		 */
		public function addKeyUpEvent(func:Function):void
		{
			if (_keyUpArray.indexOf(func) == -1)
			{
				_keyUpArray.push(func);
			}
		}
		
		public static function get isPointWaiting():Boolean
		{
			return _isClicked;
		}
		
		public static function get keyboardController():InKey // return the private instance of the keyboard controller
		{
			return _keyboardController;
		}
		
		/**
		 * Check to see if the key is being pressed down on the keyboard
		 * @param	code
		 * @return	Boolean
		 */
		public function keyDown(code:int):Boolean
		{
			return keyboardController.isKeyDown(code);
		}
		
		/**
		 * Check to see if a key is up
		 * @param	code
		 * @return	Boolean
		 */
		
		public function keyUp(code:int):Boolean
		{
			return !keyboardController.isKeyDown(code);
		}
		
		/**
		 * Frame event to run all key fuinctions that have been defined when they are
		 * in the down state.
		 * 
		 * @param	event
		 */
		public function onFrame(e:Event):void
		{
			// Check to see if there are any registered key functions
			if (_keyEventsArray.length > 0)
			{
				for each(var keyEvt:PeKeyedEvent in _keyEventsArray)
				{
					// Check first to see if the key is down before running key events
					if (keyDown(keyEvt.keyCode))
					{
						// Key is down so process keys functions
						if (keyEvt.functionArray.length > 0)
						{
							for each(var evt:Function in keyEvt.functionArray)
							{
								evt(e);
							}
						}// Endif functionArray length greater than 0
						processKeyUp = true;
					}// Endif keyDown for event code
				}// End for PeKeyedEvent loop
			}// Endif Key Events length greater than 0
			
			if (_keyboardController.keyCount <= 0 && _keyUpArray.length > 0 && processKeyUp)
			{
				for each(var keyUp:Function in _keyUpArray)
				{
					keyUp(e);
					processKeyUp = false;
				}
			}
			
			// Process all key up events
			_keyboardController.processKeyUp(e);
		}// End method onFrame

		public function set gamePos(inPos:PePoint):void
		{
			myPos = inPos;
		}
		
		public function get layer():int 
		{
			return _layer;
		}
		
		public function set layer(value:int):void 
		{
			_layer = value;
		}
	}
	
}