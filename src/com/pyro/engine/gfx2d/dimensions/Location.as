package com.pyro.engine.gfx2d.dimensions 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	public class Location 
	{
		private static const s_origin:Location = new Location(0, 0);
		
		private var _x:int;
		private var _y:int;
		
		public function Location(ix:int, iy:int) 
		{
			x = ix;
			y = iy;
		}// End method constructor
		
		public function set x(ix:int):Boolean
		{
			var retVal:Boolean = false;
			if (ix > 0)
			{
				_x = ix;
				retVal = true;
			}
			return retVal;
		}//  End method set x
		
		public function set y(iy:int):Boolean
		{
			var retVal:Boolean = false;
			if (iy > 0)
			{
				_y = iy;
				retVal = true;
			}
			return retVal;
		}// End method set y
		
		public function get x():int
		{
			return _x;
		}// End method get x
		
		public function get y():int
		{
			return _y;
		}// End method get y

		public static function get Origin():Location
		{
			return s_origin;
		}
		
		public function toString():String
		{
			return "[" + _x + ", " + _y + "]";
		}// End method toString
		
	}

}