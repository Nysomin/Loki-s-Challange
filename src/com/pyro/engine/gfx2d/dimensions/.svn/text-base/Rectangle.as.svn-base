package com.pyro.engine.gfx2d.dimensions 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	public class Rectangle 
	{
		private var _size:Size;
		private var _location:Location;
		
		public function Rectangle(loc:Location, sz:Size) 
		{
			location = loc;
			size = sz;
		}
		
		public function Rectangle(sz:Size)
		{
			location = Location.Origin;
			size = zs;
		}
		
		public function Rectange(x:int, y:int, width:int, height:int)
		{
			location = new Location(x, y);
			size = new Size(width, height);
		}
		
		public function Rectange(rect:Rectangle)
		{
			location = rect.location;
			size = rect.size;
		}
		
		public function contains(loc:Location):Boolean
		{
			var retVal:Boolean = false;
			if (location.x >= loc.x && location.y >= loc.y
				&& location.x < loc.x + size.width
				&& location.y < loc.y + size.height)
			{
				retVal = true;
			}
			
			return retVal;
		}// End method contains
		
		public function set size(sz:Size):void
		{
			_size = sz;
		}
		
		public function set location(loc:Location):void
		{
			_location = loc;
		}
		
		public function get location():Location
		{
			return _location;
		}
		
		public function get size():Size
		{
			return _size;
		}
		
		public function toString():String
		{
			return location.toString() + " - " + size.toString();
		}
		
	}

}