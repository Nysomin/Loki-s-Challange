package com.pyro.gui 
{
	import com.pyro.engine.PE;
	import com.pyro.engine.resource.PeImageResource;
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author Jesse James Lord
	 */
	public class PeImageScreen extends PeBaseScreen
	{
		//We want to recieve the path to an image on construction of the class
		public function PeImageScreen(fImage:String) 
		{
			//Load the image.
			if(fImage)
			PE.resourceManager.load(fImage, PeImageResource, onLoad, onFail); 
		}
		
		private function onLoad(imgObject:PeImageResource):void
		{
			//lets load the image as normal.
			cacheAsBitmap = true;
			graphics.clear();
			graphics.beginBitmapFill( imgObject.image.bitmapData);
			graphics.drawRect(0, 0, imgObject.image.bitmapData.width, imgObject.image.bitmapData.height);
			graphics.endFill();
		}
		
		private function onImageFail(imgObject:PeImageResource):void
		{
			//If we don't have a bitmap beacuse it failed lets make it hot pink!
			var fBitmap:BitmapData = new BitmapData(fObjectBounds.width, fObjectBounds.height, true, 0xFF00FF);
			graphics.clear();
			graphics.beginBitmapFill(fBitmap as BitmapData);
			graphics.drawRect(0, 0, stage.width, stage.height);
			graphics.endFill();
			return;
		}
	}
}