package com.pyro.engine.core 
{
	import flash.system.System;
	/**
	 * ...
	 * @author Leland Ede
	 */
	public class PeGarbage implements IPeTicked 
	{
		private var tickCnt:int;
		private var _tickID:int;
	
		
		public function PeGarbage() 
		{
			tickCnt = 0;
		}
		
		public function onTick(deltaTime:Number):void
		{
			System.gc();
		}
		
		public function get tickReady():Boolean
		{
			if (tickCnt++ > 100)
			{
				tickCnt = 0;
				return true;
			}
			return false;
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