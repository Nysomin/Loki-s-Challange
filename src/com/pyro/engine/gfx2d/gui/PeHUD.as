package com.pyro.engine.gfx2d.gui 
{
	/*
	 * 
	 * ...
	 * @author Mark Petro
	 * 
	 * This contains the "animation" file for the player's stats HUD
	 * 
	 */
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Point;
	 
	public class PeHUD extends Sprite
	{
		private var blitData:Array;
		private var blitImage:BitmapData;
		private var canvas:Bitmap;
		private var canvasBD:BitmapData;
		private var pos:Point;
		
		public function PeHUD(data:Array, image:BitmapData) 
		{
			blitImage = image;
			blitData = data;
			pos = new Point(0, 0);
		}
		
		public function init():void
		{
			/*
			 *  Once the animation has been sent to the character, the character must call this function in order for the proper sprite dimensions to  be used
			 */
			var rec:Rectangle = blitData["hud"]["player"][0];
			var x:int = rec.width;
			var y:int = rec.height;
			canvasBD = new BitmapData(x, y, true, 0x000000ff);
			canvas = new Bitmap(canvasBD);
			addChild(canvas);
		}
		
		public function change(perc:Number):void
		{
			var frame:int = 100 - (99 * perc);
			frame--;
			if (frame < 0)
			{
				frame = 0;
			}
			var rect:Rectangle = blitData["hud"]["player"][frame];
			canvasBD.copyPixels(blitImage, rect, pos);
		}
		
	}

}