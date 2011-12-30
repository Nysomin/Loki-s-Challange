package com.pyro.engine.gfx2d.tiles 
{
	/**
	 * Class TileArray
	 * @author Leland Ede
	 */
	
	 // TODO: Look at SpriteArray and use it to base tile arrays off that class
	public class TileArray 
	{
		private var _sheets:Array;
		
		public function TileArray() 
		{
			_sheets = [];
		}
		
		public function setupSheet(sheet:TileSheet, idx:String):void
		{
			if (_sheets[idx] == null)
			{
				_sheets[idx] = sheet;
			}
		}
		
		public function getSheet(idx:String):TileSheet
		{
			var retTileSheet:TileSheet = null;
			if (_sheets[idx] is TileSheet)
			{
				retTileSheet = _sheets[idx];
			}
			return retTileSheet;
		}
	}

}