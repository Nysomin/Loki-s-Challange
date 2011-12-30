package com.pyro.engine.core 
{
	/**
	 * ...
	 * @author Mark Petro
	 * @author Robbie Carrington Jr.
	 * 		Yes Leland, I ripped off some of your code again.  Please look this over and see if it will work they way we want.
	 * 		I think it won't though because it is always creating a new instance of itself, but I could be wrong, and I am still not sure if this is what you want or not.
	 * 
	 * 		Planned usage:  call using PeKeyBinding.keyBinder.setKey(string, boolean);
	 * 						test using PeKeyBinding.keyBinder.getKey(string);  <- this returns a boolean value.
	 * 
	 * 			This allows us to set the value of the array to true or false for a specific
	 * 		action depending on if the key is up(false, nothing should happen) and down(true, things should happen).
	 * 	
	 * 
	 */
	public class PeKeyBinding 
	{
		private static var instance:PeKeyBinding;
		private static var allow:Boolean = false;
		private static var keyList:Array;
		private static var key:Boolean = false;
		
		public function PeKeyBinding() 
		{
			if (!allow)
			{
				throw("ERROR: Not allowed to instantiate class directly use the keyBinder method.");
			}
				keyList = new Array;
				clearAll();
		}
		
		//public function get keyBinder():PeKeyBinding 
		//{
			//if (_keyBinder == null)
			//{
				//allow = true;
				//_keyBinder = new PeKeyBinding();
				//allow = false;
				
			//}
			//return _keyBinder;
		//}
		
		public static function get getInstance():PeKeyBinding
		{
			if (instance == null)
			{
				allow = true;
				instance = new PeKeyBinding();
				allow = false;
			}
			return instance;
		}
		
		public function setKey(value:String, state:Boolean):void 
		{
			keyList[value] = state;
			//keyList["idle"] = false;
			//var test:Boolean = allFalse();
			//if (test == true)
			//{
				//clearAll();
				//return;
			//}
			//keyList[value] = state;
		}
		
		public function getKey(value:String):Boolean
		{
			var send:Boolean = keyList[value];
			return send;
		}
		
		public function clearAll():void
		{
			keyList["up"] = key;
			keyList["down"] = key;
			keyList["left"] = key;
			keyList["right"] = key;
			keyList["jump"] = key;
			keyList["pause"] = key;
			//keyList["idle"] = true;
		}
		
		public function allFalse():Boolean
		{
			if (!keyList["up"] && !keyList["down"] && !keyList["left"] && !keyList["right"] && !keyList["jump"] && !keyList["pause"])
			{
				return true;
			}
			return false;
		}
	}

}