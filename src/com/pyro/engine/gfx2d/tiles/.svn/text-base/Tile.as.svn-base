package com.pyro.engine.gfx2d.tiles 
{
	
	/**
	 * Tile class is just a tile holder that will allow us to change individual tiles
	 * in a tilesheet for animation.
	 * 
	 * @author Leland Ede
	 */
	import com.pyro.engine.objects.PePoint;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;

	import com.pyro.engine.objects.PeBitmap;
	import com.pyro.engine.debug.PeLogger;
	import com.pyro.engine.core.IPeObject;
	import com.pyro.engine.core.PeObject;
	import com.pyro.engine.core.PeGroup;
	
	public class Tile extends Sprite implements IPeObject
	{
		// Tile image data
		private var _tileImg:PeBitmap;
		
		// IPeObject implamentation
		private var _group:PeGroup;
		private var _parent:DisplayObjectContainer;
		
		public function Tile(img:PeBitmap) 
		{
			// Store image for class use
			tileImg = img;
			// Add image to sprite
			addChild(tileImg);
		}// End method constructor
		
		/**
		 * Change the tile image so that you don't have to replace tile on stage
		 * 
		 * @param	img
		 */
		public function changeTile(img:PeBitmap):void
		{
			// Swap image data for animation
			tileImg.bitmapData = img.bitmapData;
		}// End method changeTile
		
		/**
		 * Get tile image
		 */
		public function get image():PeBitmap
		{
			// Return image data for tile
			return tileImg;
		}// End method get image
		
		//It needs to hold only a unique name
		override public function get name():String 
		{
			return super.name;
		}
		
		public function get layer():int
		{
			return _group.layer;
		}
		
		public function set layer(layerId:int):void
		{
			_group.layer = layerId;
		}
		
		//Setting and getting a group associated with this object
		public function set owningGroup(grp:PeGroup):void
		{
			_group = grp;
		}
		
		public function get owningGroup():PeGroup
		{
			return _group;
		}
		
		//Initialization of the object
		public function init(name:String):Boolean
		{
			var retValue:Boolean = true;
			
			return retValue;
		}
		
		public function onFrame(e:Event):void
		{
			
		}
		
		/**
		 * Convert object to sprite so it can be put on the game stage
		 */
		public function get sprite():Sprite
		{
			return this;
		}
		
		//Destruction of the object
		public function destroy():void
		{
			//tileImg.parent.removeChild(tileImg);
			if (_parent.contains(sprite))
			{
				// Remove tile from parent object
				_parent.removeChild(sprite);
			}// Endif check to see if it is in parent object
			_tileImg = null;
		}// End method destroy
		
		public function move(pos:PePoint):void
		{
			
		}
		
		public function set parent(inParent:DisplayObjectContainer):void
		{
			_parent = inParent;
		}
		
		public function get tileImg():PeBitmap 
		{
			return _tileImg;
		}
		
		public function set tileImg(value:PeBitmap):void 
		{
			_tileImg = value;
		}
		
		override public function toString():String 
		{
			return name + "[" + x + ", " + y + "]";
		}
		
		public function clone():Tile
		{
			return new Tile(new PeBitmap(_tileImg.image));
			
		}
	}

}