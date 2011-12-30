package com.pyro.engine.core 
{
	import com.pyro.engine.debug.PeLogger;
	import com.pyro.engine.objects.PePoint;
	/**
	 * This class will keep track of variables x, y, and z, also has a constant gravity variable 9.8
	 * @author Erik Morrow
	 */
	public class PeWorld 
	{
		
		private var _x:int;
		private var _y:int;
		private var _z:Number;
		
		// constant for gravity
		public static const GRAVITY:Number = 9.8;
		public static const TICK:int = 10;
		
		private var _playerPosition:PePoint;
		private var _playerWorldPosition:PePoint;
		private var _mapPosition:PePoint;
		
		public function PeWorld() 
		{
			_x = 0;
			_y = 0;
			_z = 0;
			_playerPosition = PePoint.ZERO;
			_mapPosition = PePoint.ZERO;
			_playerWorldPosition = PePoint.ZERO;
		}
		
		// Getters
		public function get x():int
		{
			return _x;
		}
		
		public function get y():int
		{
			return _y;
		}
		
		public function get z():Number
		{
			return _z;
		}
		
		// Setters
		public function set x(value:int):void
		{
			_x = value;
		}
		
		public function set y(value:int):void
		{
			_y = value;
		}
		
		public function set z(value:Number):void
		{
			/*
				ZDM Can be any value between 1 and 0, but no greater than 1 and no less than 0 because it will be used a percentage multiplier.
			*/
			if (value > 1)			//ZDM cannot be greater than 1
			{
				_z = 1;
			}else if (value < 0)	//ZDM cannot be less than 0
			{
				_z = 0;
			}else
			{
				_z = value;
			}//Endif ZDM value range check
		}
		
		public function get playerPosition():PePoint 
		{
			return _playerWorldPosition;
		}
		
		public function set playerPosition(pos:PePoint):void 
		{
			_playerPosition = pos;
			calcWorldPosition();
		}
		
		public function setPlPos(pos:PePoint):void
		{
			playerPosition = pos;
		}
		
		public function calcWorldPosition():void
		{
			var newPos:PePoint = PePoint.ZERO;
			newPos.x = _mapPosition.x + _playerPosition.x;
			newPos.y = _playerPosition.y;
			newPos.z = _playerPosition.z;
			_playerWorldPosition = newPos;
			
			newPos = null;
		}
		
		public function calcMyWorldPos(pos:PePoint):PePoint
		{
			var wPos:PePoint = PePoint.ZERO;
			wPos.x = _mapPosition.x + pos.x;
			wPos.y = _mapPosition.y + pos.y;
			wPos.x = _mapPosition.x + pos.x;
			return wPos;
		}
		
		public function get mapPosition():PePoint 
		{
			return _mapPosition;
		}
		
		public function set mapPosition(pos:PePoint):void 
		{
			var newPos:PePoint = PePoint.ZERO;
			newPos.x = Math.abs(pos.x);
			newPos.y = Math.abs(pos.y);
			newPos.z = Math.abs(pos.z);
			_mapPosition = newPos;
			newPos = null;
			calcWorldPosition();
		}
		
		
	}

}