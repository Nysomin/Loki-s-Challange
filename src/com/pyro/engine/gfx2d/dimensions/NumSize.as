package com.pyro.engine.gfx2d.dimensions 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	public class NumSize
	{
		// Define dimentsions
		private var _height:Number;
		private var _width:Number;
		private var _neg:Boolean;
		
		public function NumSize(...args) 
		{
			neg = false;
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
		
		public function get width():Number
		{
			return _width;
		}
		
		public function get height():Number
		{
			return _height;
		}
		
		public function set width(w:Number):void
		{
			if (w >= 0 || _neg)
			{
				_width = w;
			}
		}
		
		public function set height(h:Number):void
		{
			if (h >= 0 || _neg)
			{
				_height = h;
			}
		}
		
		public function getArea():Number
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
		
		public function set neg(val:Boolean):void
		{
			_neg = val;
		}
	}

}