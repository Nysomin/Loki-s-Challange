package com.pyro.engine.objects 
{
	/**
	 * PeBitmap class stores the raw image data from a class
	 * resource.  Methods are include to extract section of
	 * the image as a new image.
	 * 
	 * @author Leland Ede
	 */
	import com.pyro.engine.core.IPeObject;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	import com.pyro.engine.debug.PeLogger;

	// TODO: Implement interface for object
	//public class PeBitmap extends Bitmap implements IPeObject
	public class PeBitmap extends Bitmap
	{
		private var imageData:BitmapData;
		
		public function PeBitmap(...args) 
		{
			var smoothing:Boolean = true;
			
			if (args.length > 0 )
			{
				if (args[0] is Class)
				{
					// Convert image class into bitmap
					var bitData:Bitmap = new args[0]();
					imageData = bitData.bitmapData;
					bitData = null;
					//PeLogger.getInstance.log("Image Data: " + imageData.width + " x " + imageData.height);
				}else if (args[0] is Bitmap)
				{
					//imageData = args[0].bitmapData.clone();
					imageData = args[0].bitmapData;
					args[0] = null;
				}else if(args[0] is BitmapData)
				{
					imageData = BitmapData(args[0]);
				}// Endif args[0] object checks
				if (args[1] is Boolean)
				{
					smoothing = args[1];
				}// Endif args[1] is Boolean
			}// Endif args.length > 0
			// Instantiate super class
			super(imageData, "auto", smoothing);
		}// end method constructor
		
		public function getPERect(x1:int, y1:int, x2:int, y2:int):PeBitmap
		{
			// Create new sub-image of bitmap
			var subImage:Bitmap = new Bitmap();
			// Create bitmapData based in new image size
			subImage.bitmapData = new BitmapData(x2 - x1, y2 - y1, true, 0x000000ff);
			var rect:Rectangle = new Rectangle(x1, y1, x2, y2);
			var stPos:Point = new Point(0, 0);
			subImage.bitmapData.copyPixels(bitmapData, rect, stPos);
			var retImage:PeBitmap = new PeBitmap(subImage, true);

			subImage = null;
			rect = null;
			stPos = null;
			return retImage;
		}// End method getPERect
		
		public function getPosRect(pos1:PePoint, pos2:PePoint):PeBitmap
		{
			// Call the getPERect method and return its results
			return getPERect(pos1.x, pos1.y, pos2.x, pos2.y);
		}// End method getPosRect
		
		public function get image():BitmapData
		{
			return imageData;
		}
		
	}
}