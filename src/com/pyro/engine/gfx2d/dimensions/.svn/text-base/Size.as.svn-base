package com.pyro.engine.gfx2d.dimensions 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	public class Size 
	{
		// Define dimentsions
		private var _height:int;
		private var _width:int;
		
		public function Size(...args) 
		{
			var tmp:Array;
			if (args.length == 2)
			{
				width = args[0];
				height = args[1];
			}
			if (args.length == 1)
			{
				if (args[0] is XMLList)
				{
					var tmpStr:String = new String(args[0]);
					tmp = tmpStr.split('x');
					width = tmp[0]
					height = tmp[1];
				}
				if (args[0] is String)
				{
					tmp = tmpStr.split("x");
					width = tmp[0];
					height = tmp[0];
				}
			}
		}
		
		public function get width():int
		{
			return _width;
		}
		
		public function get height():int
		{
			return _height;
		}
		
		public function set width(w:int):void
		{
			if (w > 0)
			{
				_width = w;
			}
		}
		
		public function set height(h:int):void
		{
			if (h > 0)
			{
				_height = h;
			}
		}
		
		public function getArea():int
		{
			return height * width;
		}
		
		public function square():Boolean
		{
			return height == width;
		}
		
		public function toString():String
		{
			return _width + " x " + _height;
		}
		
		public static function get ZERO():Size
		{
			return new Size(0, 0);
		}
	}

}