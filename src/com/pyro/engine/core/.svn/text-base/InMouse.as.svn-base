package com.pyro.engine.core 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Leland Ede
	 */
	public class InMouse extends Input 
	{
		
		public static const MOUSE_BUTTON:InMouse	= new InMouse(253);
		public static const MOUSE_X:InMouse			= new InMouse(254);
		public static const MOUSE_Y:InMouse			= new InMouse(255);
		public static const MOUSE_WHEEL:InMouse		= new InMouse(256);
		public static const MOUSE_OVER:InMouse		= new InMouse(257);
		
		private var _typeMap:Dictionary;
		
		public function InMouse(mCode:int):void
		{
			code = mCode;
		}
		
		public function get mouseCode():int
		{
			return code;
		}
		
		public function get typeMap():Dictionary
		{
			if (!_typeMap)
			{
				_typeMap = new Dictionary();
				_typeMap["MOUSE_BUTTON"]	= MOUSE_BUTTON;
				_typeMap["MOUSE_X"]			= MOUSE_X;
				_typeMap["MOUSE_Y"]			= MOUSE_Y;
				_typeMap["MOUSE_WHEEL"]		= MOUSE_WHEEL;
				_typeMap["MOUSE_OVER"]		= MOUSE_OVER;
			}// Endif typeMap
			return _typeMap
		}// End function get typeMap
	}

}