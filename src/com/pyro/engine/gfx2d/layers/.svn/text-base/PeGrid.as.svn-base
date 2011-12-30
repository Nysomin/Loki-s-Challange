package com.pyro.engine.gfx2d.layers 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	import com.pyro.engine.gfx2d.dimensions.NumSize;
	import com.pyro.engine.gfx2d.dimensions.Size;
	import com.pyro.engine.debug.PeLogger;

	public class PeGrid 
	{
		public static const BUFFER:Number = 3.0;
		private var _start:Size;				// Start of map coords
		private var _end:Size;					// End of map coords
		private var _resStart:Size;				// Start of map resolution size
		private var _resEnd:Size;				// End of map resolution size
		private var _worldSize:Size;			// Layer full size
		private var _resSize:Size;				// Layer full resolution size
		private var _tileSize:Size;				// Layer tile size
		
		public function PeGrid() 
		{
			start = Size.ZERO;
			end = Size.ZERO;
			_resSize = Size.ZERO;
			_worldSize = Size.ZERO;
			_resStart = Size.ZERO;
			_resEnd = Size.ZERO;
		}
		
		public function calcPosition(newPos:Size):void
		{
			var pixelWorldSize:Size = Size.ZERO;
			var buffSize:Size = Size.ZERO;
			
			// Calculate the pixel size
			pixelWorldSize.width = worldSize.width * tileSize.width;
			pixelWorldSize.height = worldSize.height * tileSize.height;
			
			// Calculate the buffer size
			buffSize.height = resSize.height * BUFFER;
			buffSize.width = resSize.width * BUFFER;
			
			// Calculate height
			if (resSize.height == pixelWorldSize.height)
			{
				_resEnd.height = resSize.height;
				_resStart.height = 0;
			}else if (buffSize.height < pixelWorldSize.height)
			{
				_resStart.height = newPos.height - (buffSize.height / 2);
				_resEnd.height = newPos.height + (buffSize.height / 2);
			}// Endif resSize == worldSize
			
			// Calculate width
			
			if (pixelWorldSize.width == resSize.width)
			{
				_resStart.width = 0;
				_resEnd.width = resSize.width;
			}else if (buffSize.width < pixelWorldSize.width)
			{
				if (newPos.width - (buffSize.width / 2) < 0 || newPos.width - worldSize.width < 0)
				{
					_resStart.width = 0;
					_resEnd.width = newPos.width + (buffSize.width - newPos.width);
				}else
				{
					_resStart.width = newPos.width - (buffSize.width / 2);
					_resEnd.width = newPos.width + (buffSize.width / 2);
				}
			}else
			{
				_resStart.width = 0;
				_resEnd.width = pixelWorldSize.width;
			}
			
			// Convert resolution to tiles
			//start.width = _resStart.width / tileSize.width;
			//end.width = _resEnd.width / tileSize.width;
			//start.height = _resStart.height / tileSize.height;
			//end.height = _resEnd.height / tileSize.height;

			// Remnove code when ready to test layer optimization
			start.width = 0;
			start.height = 0; 
			end.width = worldSize.width;
			end.height = worldSize.height;
			_resStart.width = 0
			_resStart.height = 0
			_resEnd.width = worldSize.width * tileSize.width;
			_resEnd.height = worldSize.height * tileSize.height;
		}
		
		public function get start():Size 
		{
			return _start;
		}
		
		public function set start(value:Size):void 
		{
			_start = value;
		}
		
		public function get end():Size 
		{
			return _end;
		}
		
		public function set end(value:Size):void 
		{
			_end = value;
		}
		
		public function get worldSize():Size 
		{
			return _worldSize;
		}
		
		public function set worldSize(value:Size):void 
		{
			_worldSize = value;
		}
		
		public function get resSize():Size 
		{
			return _resSize;
		}
		
		public function set resSize(value:Size):void 
		{
			_resSize = value;
		}
		
		public function get tileSize():Size 
		{
			return _tileSize;
		}
		
		public function set tileSize(value:Size):void 
		{
			_tileSize = value;
		}
		
		public function get resStart():Size 
		{
			return _resStart;
		}
		
		public function get resEnd():Size 
		{
			return _resEnd;
		}
		
		public function toString():String
		{
			var buf:String = new String;
			buf = "Start: " + start.toString() + "\n";
			buf += "End: " + end.toString() + "\n";
			buf += "World: " + worldSize.toString() + "\n";
			buf += "Reselution: " + resSize.toString() + "\n";
			buf += "TileSize: " + tileSize.toString();
			return buf;
		}
				
	}

}