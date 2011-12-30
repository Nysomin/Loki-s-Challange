package com.pyro.engine.gfx2d.tiles 
{
	
	/**
	 * TileSheet class stores the tilesheet data and provides quick access to the
	 * different parts of the image.
	 * 
	 * @author Leland Ede
	 */
	import com.pyro.engine.objects.PeBitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	import com.pyro.engine.gfx2d.dimensions.Size;
	import com.pyro.engine.objects.PePoint;
	import com.pyro.engine.debug.PeLogger;

	public class TileSheet 
	{
		// Class data structures
		private var image:PeBitmap;
		private var imgStruct:Size;
		private var _tileSize:Size
		private var tileSpace:Size;
		private var sheetName:String;
		private var _debug:Boolean = false;
		private var splice:Array;
		
		public function TileSheet(imgData:Class, img:Size, tile:Size, spacing:Size, name:String = null) 
		{
			image = new PeBitmap(imgData);
			imgStruct = img;
			_tileSize = tile;
			sheetName = name;
			tileSpace = spacing;
			if (_debug || true)
			{
				PeLogger.getInstance.log("<<-- Tile size: " + tile.toString() + " -->>");
				PeLogger.getInstance.log(imgStruct.toString());
			}
			splice = [];
		}// End method constructor
		
		public function getTile(x:int, y:int):Tile
		{
			var tile:Tile;
			if (x < imgStruct.width && x >= 0
					&& y < imgStruct.height && y >= 0)
			{
				// Create methods point data
				var calcPos:PePoint = new PePoint(0, 0,0);
				var space:PePoint = new PePoint(0, 0,0);
				
				// Calculate the amount of space between cells
				space.x = x * tileSpace.width;
				space.y = y * tileSpace.height;
				
				// Calculate starting rectangle corner
				calcPos.x = x * tileSize.width + space.x;
				calcPos.y = y * tileSize.height + space.y;
				// Set first point
				var pos1:PePoint = new PePoint(calcPos.x, calcPos.y,0);
				
				// Calculate bottom corner of rectangle
				calcPos.x = ((x + 1) * tileSize.width) + space.x;
				calcPos.y = ((y + 1) * tileSize.height) + space.y;
				var pos2:PePoint = new PePoint(calcPos.x, calcPos.y,0);
				
				// Create new tile with graphics
				tile = new Tile(image.getPosRect(pos1, pos2));
				if (_debug)
				{
					PeLogger.getInstance.log("<<-- Image Size: " + pos1.toString() + " - " + pos2.toString() + " -->>");
				}
				calcPos = null;
				space = null;
				pos1 = null;
				pos2 = null;
			}else
			{
				// Create a blank tile
				PeLogger.getInstance.log("Create blank tile " + x + " ," + y );
				tile = new Tile(new PeBitmap());
			}
			
			// Return new tile
			return tile;
		}// End method getTile
		
		public function getNumTile(idx:int):Tile
		{
			if (splice[idx] == null)
			{
				var y:int = 0;
				var x:int = idx;
				if (idx > (imgStruct.width -1))
				{
					y = idx / imgStruct.width;
					x = x - (y * imgStruct.width);
				}
				splice[idx] =  getTile(x, y);
			}
			return splice[idx].clone();
		}// End method getNumTile
		
		public function toString():String 
		{
			return sheetName;
		}// End method toString
		
		public function get mapSize():Size
		{
			return imgStruct;
		}// End method get mapSize
		
		public function get tileSize():Size
		{
			return _tileSize;
		}// End method get tileSize
		
		public function set debug(deb:Boolean):void
		{
			_debug = deb;
		}// End method debug
	}

}