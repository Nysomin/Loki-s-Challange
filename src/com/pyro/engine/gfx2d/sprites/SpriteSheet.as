package com.pyro.engine.gfx2d.sprites 
{
	
	/**
	 * Class Sprite Sheet used to store the image data in an onject we can get
	 * break down into individual sprites.
	 * 
	 * @author Leland Ede
	 */
	import com.pyro.engine.gfx2d.tiles.Tile;
	import com.pyro.engine.gfx2d.dimensions.Size;
	import com.pyro.engine.objects.PeBitmap;
	import com.pyro.engine.debug.PeLogger;
	import com.pyro.engine.objects.PePoint;
	
	public class SpriteSheet 
	{
		// Class data strucutres
		private var image:PeBitmap;
		private var imgSize:Size;
		private var sheetName:String;
		private var _debug:Boolean = false;
		
		public function SpriteSheet(imgData:Class, name:String = null) 
		{
			// Create a new bitmap based on data passed into class
			image = new PeBitmap(imgData);
			// Store sheet name
			sheetName = name;
		}// End method constructor
		
		 public function getTile(pos1:PePoint, pos2:PePoint):Tile 
		{
			if (_debug)
			{
				PeLogger.getInstance.log(pos1.toString() + " - " + pos2.toString());
			}
			return new Tile(image.getPosRect(pos1, pos2));
		}// End method getTile
		
		public function set debug(bug:Boolean):void
		{
			_debug = bug;
		}// End method set debug
		
	}

}