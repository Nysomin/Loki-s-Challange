package com.pyro.engine.gfx2d.layers 
{
	
	/**
	 * ...
	 * @author Leland Ede
	 */
	
	import com.pyro.engine.character.PePlayer;
	import com.pyro.engine.objects.PePoint;
	import flash.events.Event;
	
	public class LayerEvents extends Event
	{
		public static const DRAW_COMPLETE:String			= "DrawComplete";
		public static const ENTER_FRAME:String				= "EnterFrame";
		public static const DRAW_LAYER:String				= "DrawLayer";
		
		private var _data:Object;
		
		public function LayerEvents(type:String, obj:Object) 
		{
			_data = obj;
			super(type);
		}
		
		public function get data():Object
		{
			return _data;
		}
	}

}