package com.pyro.engine.ai 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;

	import com.pyro.engine.character.PeCharacterTracker;
	import com.pyro.engine.core.IPeTicked;
	import com.pyro.engine.core.IPeController;
	import com.pyro.engine.core.PeFPS;
	import com.pyro.engine.objects.PePoint;
	import com.pyro.engine.core.PeKeyedEvent;
	import com.pyro.engine.debug.PeLogger;

	public class PeMonsterAI implements IPeTicked, IPeController
	{
		public static const IN_SIGHT_RANGE:int = 300;	// Is player in sight of characer
		
		private var _plPos:PePoint;
		private var _myPos:PePoint;
		private var canMove:Boolean;
		private var _stats:PeCharacterTracker;
		private var _virtKeys:Array;					// Viurtual list of keys pressed
		private var _keyEventsArray:Array;
		private var _keyUpArray:Array;
		private var _keyPressUp:Array;
		private var processKeyUp:Boolean;
		private var keyCount:int;
		private var keyWasPressed:Boolean;
		private var lastThrow:uint;
		private var _hitByPlayer:Boolean;
		private var _inSightRange:int;
		private var _setDir:Boolean;
		private var _layer:int;
		private var _nextAttack:int;
		private var _attackRate:int;
		
		private var _tickID:int;
		
		public function PeMonsterAI(pos:PePoint) 
		{
			_myPos = pos;
			_plPos = null;
			canMove = true;
			_virtKeys = [];
			for (var i:int = 0; i < 256; i++)
			{
				_virtKeys[i] = false;
			}
			_keyEventsArray = [];
			_keyUpArray = [];
			_keyPressUp = [];
			keyWasPressed = false;
			_hitByPlayer = false;
			_inSightRange = IN_SIGHT_RANGE;
			_setDir = true;
			_nextAttack = 0;
			_attackRate = 50;
		}
		
		public function set player(pos:PePoint):void
		{
			var chkPos:PePoint = PePoint.ZERO;
			chkPos.x = Math.abs(_myPos.x) - Math.abs(pos.x);
			chkPos.y = Math.abs(_myPos.y) - Math.abs(pos.y);
			if (chkPos.x < _inSightRange || _hitByPlayer)
			{
				_plPos = pos;
			}else
			{
				// Clear plPos if they are not in sight
				_plPos = null;
			}
		}
		
		public function get stats():PeCharacterTracker 
		{
			return _stats;
		}
		
		public function set stats(value:PeCharacterTracker):void 
		{
			_stats = value;
		}
		
		public function onTick(deltaTime:Number):void
		{
			//PeLogger.getInstance.debugState = true;
			processKeyUp = true;
			if (_plPos != null)
			{
				setDirection();
				if (attackRanged && lastThrow < getTimer()-200) 
				{
					_virtKeys[Keyboard.R] = true;
					lastThrow = getTimer();
					processKeyUp = false;
					keyWasPressed = true;
				}else
				{
					move();
				}// Endif attack ranged is true
				
				if (processKeyUp && keyWasPressed && _keyUpArray.length > 0)
				{
					var e:Event = new Event("Process AI");
					for each(var func:Function in _keyUpArray)
					{
						func(e);
					}
					e = null;
					keyWasPressed = false;
				}			
			}else
			{
				if (_keyUpArray.length > 0)
				{
					var ie:Event = new Event("Process AI");
					for each(var ieFunc:Function in _keyUpArray)
					{
						ieFunc(ie);
					}
					ie = null;
				}// Endif keyUpArray length greater than zero
				keyWasPressed = false;
			}// Endif plPos does not equal null
			canMove = false;
			//PeLogger.getInstance.debugState = false;
		}// End method onTick
		
		public function move():void
		{
			var processKeyUp:Boolean = true;
			// We know where the player is located so let's move
			var minPos:PePoint = new PePoint(0, 0, 0, true);
			var maxPos:PePoint = new PePoint(0, 0, 0, true);
			minPos.x = _myPos.x - 65;
			minPos.y = _myPos.y - 5;
			maxPos.x = _myPos.x + 65;
			maxPos.y = _myPos.y + 5;
			_nextAttack++;
			
			if (_plPos.x > maxPos.x)
			{
				_virtKeys[Keyboard.D] = true;
				processKeyUp = false;
				keyWasPressed = true;
				setDir = false;
				//myPos.x += stats.speed * PeFPS.getInstance.deltaTime;
			}else if (_plPos.x < minPos.x)
			{
				_virtKeys[Keyboard.A] = true;
				processKeyUp = false;
				keyWasPressed = true;
				setDir = false;
			}// Endif player position calculations
			
			PeLogger.getInstance.log("Min: " + minPos.y + " Max: " + maxPos.y + " Player: " + plPos.y);
			//PeLogger.getInstance.log("Monster Pos: " + myPos.toString());
			
			if (_plPos.y < minPos.y)
			{
				processKeyUp = false;
				keyWasPressed = true;
				_virtKeys[Keyboard.W] = true;
				PeKeyedEvent(_keyPressUp[Keyboard.S]).process = true;
				setDir = false;
			}else if (_plPos.y > maxPos.y)
			{
				processKeyUp = false;
				keyWasPressed = true;
				_virtKeys[Keyboard.S] = true;
				PeKeyedEvent(_keyPressUp[Keyboard.W]).process = true;
				setDir = false;
			}
			
			if (keyWasPressed == false && processKeyUp == true)
			{
				if (_nextAttack > _attackRate)
				{
					_virtKeys[Keyboard.E] = true;
					processKeyUp = true;
					keyWasPressed = true;
					_nextAttack = 0;
				}
			}
		}// End method move
		
		public function onFrame(e:Event):void
		{
			canMove = true;
			//PeLogger.getInstance.debugState = true;
			for each(var keyEvt:PeKeyedEvent in _keyEventsArray)
			{
				if (_virtKeys[keyEvt.keyCode])
				{
					for each(var evt:Function in keyEvt.functionArray)
					{
						evt(e);
					}
					// Clear virtual key
					_virtKeys[keyEvt.keyCode] = false;
				}// Endif virtual key is pressed check
			}// End for each keyboard event
			
			if (_keyPressUp.length > 0)
			{
				for each(var key:PeKeyedEvent in _keyPressUp)
				{
					if (key.process)
					{
						for each(var kFunc:Function in key.functionArray)
						{
							kFunc(e);
						}
						key.process = false;
					}
				}
			}
			//PeLogger.getInstance.debugState = false;
		}
		
		public function get tickReady():Boolean
		{
			return canMove;
		}
		
		public function onKeyUpEvent(func:Function):void
		{
		}
		
		/**
		 * Since this is a virtual controller it is going to process all key commands a key presses
		 * 
		 * @param	code
		 * @param	func
		 */
		public function addKeyEvent(code:int, func:Function):void
		{
			addKeyPress(code, func);
		}
		
		/**
		 * Virtual controller key press utility
		 * 
		 * @param	code
		 * @param	func
		 */
		public function addKeyPress(code:int, func:Function):void
		{
			if (!(_keyEventsArray[code] is Array))
			{
				_keyEventsArray[code] = new PeKeyedEvent(code);
			}
			
			PeKeyedEvent(_keyEventsArray[code]).functionArray.push(func);
		}
		
		public function addKeyUpEvent(func:Function):void
		{
			if (_keyUpArray.indexOf(func) == -1)
			{
				_keyUpArray.push(func);
			}
		}
		
		public function addKeyPressUp(code:int, func:Function):void
		{
			if (_keyPressUp[code] == null)
			{
				_keyPressUp[code] = new PeKeyedEvent(code);
			}
			PeKeyedEvent(_keyPressUp[code]).functionArray.push(func);
		}
		
		public function set gamePos(inPos:PePoint):void
		{
			_myPos = inPos;
		}
		
		public function setDirection():void
		{
			if (_setDir)
			{
				if (_myPos.x > _plPos.x)
				{
					_virtKeys[200] = true;
				}else
				{
					_virtKeys[201] = true;
				}//Endif check x position
			}// Endif set direction
			_setDir = true;
		}
		
		public function get attackRanged():Boolean
		{
			return false;
		}
		
		public function get distance():PePoint
		{
			return new PePoint(
				Math.abs(_myPos.x - _plPos.x),
				Math.abs(_myPos.y - _plPos.y),
				Math.abs(_myPos.z - _plPos.z));
		}
		
		public function get plPos():PePoint 
		{
			return _plPos;
		}
		
		public function get myPos():PePoint 
		{
			return _myPos;
		}
		
		public function set hitByPlayer(value:Boolean):void 
		{
			_hitByPlayer = value;
		}
		
		public function get virtKeys():Array 
		{
			return _virtKeys;
		}
		
		public function set virtKeys(value:Array):void 
		{
			_virtKeys = value;
		}
		
		public function set inSightRange(sight:int):void 
		{
			_inSightRange = sight;
		}
		
		public function set setDir(dir:Boolean):void 
		{
			_setDir = dir;
		}
		
		public function get layer():int 
		{
			return _layer;
		}
		
		public function set layer(idx:int):void 
		{
			_layer = idx;
		}
		
		public function get nextAttack():int 
		{
			return _nextAttack;
		}
		
		public function set nextAttack(value:int):void 
		{
			_nextAttack = value;
		}
		
		public function get attackRate():int 
		{
			return _attackRate;
		}
		
		public function set attackRate(value:int):void 
		{
			_attackRate = value;
		}
		
		public function get tickID():int 
		{
			return _tickID;
		}
		
		public function set tickID(value:int):void 
		{
			_tickID = value;
		}
	}

}