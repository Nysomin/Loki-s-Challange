package com.pyro.engine.gfx2d.sprites 
{
	/**
	 * Class SpriteArray which stores the animatable sprite sheet items
	 * 
	 * @author Leland Ede
	 */
	import com.pyro.engine.gfx2d.tiles.Tile;
	import com.pyro.engine.objects.PeBitmap;
	
	public class SpriteArray 
	{
		// Class data sctructures
		private var speed:int;
		private var frames:Array;
		
		public function SpriteArray() 
		{
			// Create an array to store all our frames in
			frames = new Array();
		}
		
		public function addFrame(indx:int, frame:Tile):void
		{
			// Add frame to the data array
			frames.push(frame);
		}
		
		public function getFrame(indx:int):Tile
		{
			// Create a base tile to return
			var retTile:Tile;
			// Check to see if index is a tile
			if (frames[indx] is Tile)
			{
				// Set return tile to frame
				retTile = frames[indx];
			}else
			{
				// Create a blank tile
				retTile = new Tile(new PeBitmap());
			}// Endif frame is tile
			return retTile;
		}// End method getFrame
		
		public function get length():int
		{
			return frames.length;
		}// End method get length
	}

}