package com.pyro.engine.core 
{
	/**
	 * Class to handle game cameras
	 * 
	 * @author Leland Ede
	 */
	import com.pyro.engine.objects.PePoint;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	public class PeCamera extends DisplayObjectContainer
	{
		private var camera:Array;
		private var current:int;
		
		public function PeCamera() 
		{
			camera = [];
			current = 0;
		}
		
		public function addCamera(pos:PePoint):void
		{
			
		}
		
	}

}