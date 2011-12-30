package com.pyro.engine.resource 
{
	import flash.geom.Rectangle;
	import com.pyro.engine.PE;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author Jesse James Lord
	 */
	public class PeImageResource extends PeResource
	{
		
		//There are two types of images we will be working with jpg and png
		[EditorData(extensions="jpg,png,gif")]
		
		//Lets create the bitmap Object that this class is going to handle
		protected var _bitmapObject:BitmapData = null;
		
		public function get image():Bitmap
		{
			if (_bitmapObject != null)
			{
				return new Bitmap(_bitmapObject);
			}
			else
				return null; //If we don't have anything loaded return null
		}
		
		public function dispose():void
		{
			if (_bitmapObject != null )
			{
				//run its method to clear it out
				_bitmapObject.dispose();
				//Set the variable object for the class to null
				_bitmapObject = null;
			}
		}
		
		override public function initialize(value:*):void
		{
			//If the data is a bitmap image
			if ( value is Bitmap )
			{
				//We have a bitmap so just use it
				onContentReady(value.bitmapObject);
				//Call the on Load Complete so we know its done
				onLoadComplete();
				return;
			}
			else if ( value is BitmapData )
			{
				//If we have just a bitmapData
				onContentReady(value as BitmapData)
				onLoadComplete();
				return;
			}
			else if ( value is DisplayObject )
			{
				//If we have a display object then we need to make a change
				var fObject:DisplayObject = value as DisplayObject;
				
				//Get the display objects spacial and parental information
				var spacial:DisplayObject;
				if (fObject.parent)
					spacial = fObject.parent;
				else
					spacial = PE.stage();
				
				//Get the new Display Object's Bounds
				var fObjectBounds:Rectangle = fObject.getBounds(spacial);
				
				var fMatrix:Matrix = new Matrix();
				//Flip the loaded data by the x and y
				fMatrix.translate(fObjectBounds.x * -1, fObjectBounds.y * -1);
				
				//We want to draw the new data Display Object onto a new alpha bitmap and then return that bitmap
				var fBitmap:BitmapData = new BitmapData(fObjectBounds.width, fObjectBounds.height, true, 0x000000);
				//Do the copy command with the matrix;
				fBitmap.draw(fObject, fMatrix);
				
				//Now we have a new bitmap image to return
				onContentReady(fBitmap);
				onLoadComplete();
				return;
			}
			
			//If it is just data then process it as a byteArray
			super.initialize(value);
		}
		
		override protected function onContentReady(pObject:*):Boolean
		{
			//If the object is a bitmapData then we need to store it in the _bitmapObject
			if ( pObject is BitmapData)
				_bitmapObject = pObject as BitmapData;
			else if ( pObject is Bitmap ) //If it is a Bitmap then we just need to grab the BitmapData from it and store it and set the Bitmap to null; Since we already made a copy of it.
			{
				_bitmapObject = (pObject as Bitmap).bitmapData;
				pObject = null;
			}
			return _bitmapObject != null;
		}
	}
}