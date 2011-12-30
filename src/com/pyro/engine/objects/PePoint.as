package com.pyro.engine.objects 
{
	/**
	 * PePoint is a very important data structure that contains mostly
	 * x and y coordinates for the game engine.
	 * 
	 * @author Leland Ede
	 * 
	 * Added that all important Z cooridnate - Mark Petro
	 * 
	 */
	public class PePoint 
	{
		private var _x:int;
		private var _y:int;
		private var _z:Number;
		private var _neg:Boolean;
		
		public function PePoint(inX:int, inY:int, inZ:Number, setNeg:Boolean = false) 
		{
			neg = setNeg;
			setXYZ(inX, inY, inZ);
		}// End method constructor
		
		public function get x():int
		{
			return _x;
		}// End method get x
		
		public function set x(inX:int):void
		{
			if (_neg)
			{
				_x = inX;
			}else{
				if(inX >= 0)
					_x = inX;
				else _x = 0;
			}
		}// End method set x
		
		public function get y():int
		{
			return _y;
		}// End method get y
		
		public function set y(inY:int):void
		{
			if (_neg)
			{
				_y = inY;
			}else
			{
				if (inY >= 0)
					_y = inY;
				else _y = 0;
			}
		}// End method set y
		
		public function set neg(val:Boolean):void
		{
			_neg = val;
		}
		
		public function get z():Number 
		{
			return _z;
		}
		
		public function set z(value:Number):void 
		{
			if (value > 1)
				_z = 1;
			else if (value < 0)
				_z = 0;
			else
				_z = value;
		}
		
		public function setXYZ(inX:int, inY:int, inZ:Number):void
		{
			_x = inX;
			_y = inY;
			_z = inZ;
		}// End method setXY
		
		public function toString():String
		{
			return _x + ", " + _y +", " + _z;
		}// End method toString
		
		public static function get ZERO():PePoint
		{
			return new PePoint(0, 0, 0, false);
		}
		
	}

}