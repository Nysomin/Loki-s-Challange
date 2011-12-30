package com.pyro.engine.gfx2d 
{
	
	/**
	 * This code is based on a lot of concepts found from xTilePC code
	 * and converted to flash based maps
	 * @link  http://tide.codeplex.com
	 * 
	 * @author Leland Ede
	 * 
	 */
	import flash.display.Sprite;

	import com.pyro.engine.gfx2d.layers.Layer;
	import com.pyro.engine.objects.PePoint;

	public class Map extends Sprite 
	{
		private var layers:Array;
		
		public function Map() 
		{
			layers = new Array();
			
		}
		
		public function addLayer(layer:Layer, pos:int):void
		{
			layers[pos] = layer;
		}
	}

}