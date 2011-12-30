package data.items 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class GamePotion extends Sprite
	{
		private var blitData:Array;
		private var blitImage:BitmapData;
		private var canvas:Bitmap;
		private var canvasBD:BitmapData;
		private var pos:Point;
		private var _dir:String;
		private var maxFrame:int;
		private var frame:int;
		
		public function GamePotion(data:Array, image:BitmapData) 
		{
			blitImage = image;
			blitData = data;
			_dir = "left";
			maxFrame = 10
			frame = 0;
			pos = new Point(0, 0);
		}

		public function init():void
		{
			/*
			 *  Once the animation has been sent to the character, the character must call this function in order for the proper sprite dimensions to  be used
			 */
			var rec:Rectangle = blitData["life"][_dir][frame];
			var x:int = rec.width;
			var y:int = rec.height;
			canvasBD = new BitmapData(x, y, true, 0x000000ff);
			canvas = new Bitmap(canvasBD);
			addChild(canvas);
		}
		
		public function onFrame():void
		{
			var rect:Rectangle = blitData["life"][_dir][frame];
			if(rect != null)
			{
				canvasBD.copyPixels(blitImage, rect, pos);
			}
			if (frame++ >= maxFrame)
			{
				frame = 0;
			}
		}
		
	}

}