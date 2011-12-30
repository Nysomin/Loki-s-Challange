package com.pyro.engine.core 
{
	/**
	 * ...
	 * @author Leland Ede
	 * @author Robbie Carrington Jr.
	 */
	import com.pyro.engine.PE;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import com.pyro.engine.debug.PeLogger;
	import com.pyro.engine.core.PeKeyBinding;
	
	public class InKey
	{
		//private static var _keyBinder:PeKeyBinding;
		private var _keyCodes:Array;
		private var _keyDown:String;
		private var _keyCount:int;
		private var _keyPressDown:Array;
		private var _keyPressUp:Array;
		
		public function InKey() 
		{
			_keyCodes = [];
			_keyPressDown = [];
			_keyPressUp = [];
			// Initial key codes array
			clearKeys();
			_keyDown = "idle"; // This should be moved to a static constant variable -LE
			_keyCount = 0;
		}
		
		public function clearKeys():void
		{
			for (var i:int = 0; i < 256; i++) _keyCodes[i] = false;
		}
		
		public function isKeyDown(code:int):Boolean // use the name of the action (ex. "jump") to return if the key is down
		{
			return _keyCodes[code];
		}
		
		public function onKeyDown(e:KeyboardEvent):void // set to true if key is down
		{
			if (true == _keyCodes[e.keyCode]) return;
			_keyCount++;
			_keyCodes[e.keyCode] = true;
			if (_keyPressDown[e.keyCode] is InKeyArray)
			{
				for each(var func:Function in InKeyArray(_keyPressDown[e.keyCode]).funcArray)
					func(e);
			}// Endif keyPressDown has any events
	
		}
		
		public function onKeyUp(e:KeyboardEvent):void // set to false if it is up
		{
			_keyCount--;
			_keyCodes[e.keyCode] = false;
			if (_keyPressUp[e.keyCode] is InKeyArray)
			{
				InKeyArray(_keyPressUp[e.keyCode]).process = true;
			}
		}
		
		public function addKeyPressDown(code:int, func:Function):void
		{
			if (!(_keyPressDown[code] is InKeyArray))
			{
				_keyPressDown[code] = new InKeyArray(code);
			}
			InKeyArray(_keyPressDown[code]).funcArray.push(func);
		}
		
		public function addKeyPressUp(code:int, func:Function):void
		{
			if (!(_keyPressUp[code] is InKeyArray))
			{
				_keyPressUp[code] = new InKeyArray(code);
				InKeyArray(_keyPressUp[code]).process = false;
			}
			InKeyArray(_keyPressUp[code]).funcArray.push(func);
		}
		
		public function get keyUpLength():int
		{
			return _keyPressUp.length();
		}
		
		public function processKeyUp(e:Event):void
		{
			if (_keyPressUp.length > 0)
			{
				for each(var proc:InKeyArray in _keyPressUp)
				{
					if (proc.process)
					{
						proc.process = false;
						for each(var func:Function in proc.funcArray)
						{
							func(e);
						}// End for loop to process each function in array
					}// Endif process key up command
				}// End for each registered key
			}// Endif keyPressUp is a valid array element
		}// End method processKeyUp
		
		public function get keyCount():int
		{
			return _keyCount;
		}
		
		public function get keyDown():String 
		{
			return _keyDown;
		}
		
		public function set keyDown(value:String):void
		{
			_keyDown = value;
		}
	}

}