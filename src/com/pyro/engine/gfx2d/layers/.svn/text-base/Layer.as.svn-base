package com.pyro.engine.gfx2d.layers 
{
	
	/**
	 * Layer class is the individual layers for the map and is responsible for drawing the
	 * map image from a TileSheet.
	 * 
	 * @author Leland Ede
	 */
	import com.pyro.engine.gfx2d.tiles.TileArray;
	import com.pyro.engine.gfx2d.tiles.TileData;
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.Event;

	import com.pyro.engine.gfx2d.tiles.TileSheet;
	import com.pyro.engine.debug.PeLogger;
	import com.pyro.engine.gfx2d.tiles.Tile;
	import com.pyro.engine.objects.PePoint;
	import com.pyro.engine.core.PeFPS;
	import com.pyro.engine.core.IPeObject;
	import com.pyro.engine.gfx2d.dimensions.Size;
	import com.pyro.engine.gfx2d.dimensions.NumSize;
	import com.pyro.engine.core.PeGroup;

	public class Layer extends EventDispatcher implements IPeObject
	{
		// Class data structures
		private var layerPos:NumSize;
		private var scrollSpeed:NumSize;
		private var layerName:String;
		private var tSheet:TileArray;
		
		// Layer data members
		private var _layerData:Array;
		private var layerSize:Size;
		// Layer ready for use and fully loaded
		private var ready:Boolean;
		private var drawSequence:int;
		private var screenRes:Size;
		private var isSpawnLayer:Boolean;
		
		// Optimizer variable
		private var _renderSize:PeGrid;
		
		// Current buffer being displayed
		private var _stage:Sprite;
		private var _layerGfx:Sprite;
		private var _buffer:Sprite;
		
		// IPeObject interface structures
		private var _name:String;
		private var _group:PeGroup;
		private var _layerId:int;
		private var _parent:DisplayObjectContainer;
		private var _rightSide:Boolean;
		
		/**
		 * Create a new layer and set the basic construction values
		 * 
		 * @param	name - Layer name
		 * @param	layerTiles - TileSheet for layer creation
		 * @param	lSize - Layer Size
		 */
		public function Layer(name:String, lSize:Size) 
		{
			_renderSize = new PeGrid();
			// Create new stage sprite for this layer
			_stage = new Sprite();
			_layerGfx = new Sprite();
			_stage.addChild(_layerGfx);
			// Set layer name
			layerName = name;
			layerSize = lSize;
			_renderSize.worldSize = lSize;
			ready = false;
			// TODO: Get screen resolution from game engine
			screenRes = new Size(800, 600);
			_renderSize.resSize = screenRes;
			layerPos = new NumSize(0.0, 0.0);
			layerPos.neg = true;
			isSpawnLayer = false;
			_rightSide = false;
		}// End constructor method
		
		public function set tileSheet(inSheet:TileArray):void
		{
			tSheet = inSheet;
		}
		
		public function get sheet():TileArray
		{
			// Accessor method to get the tilesheet
			return tSheet;
		}// End get sheet
		
		public function draw(currPos:Size):void
		{
			ready = false;
			var buffer:Sprite = new Sprite();
			// Calculate start and end matrix
			renderSize.calcPosition(currPos);
			for (var height:int = renderSize.start.height; height < renderSize.end.height; height++)
			{
				for (var width:int = renderSize.start.width; width < renderSize.end.width; width++)
				{
					var color:uint = 0x00ff00;
					if (width % 2)
					{
						color = 0x0000ff;
					}
					if (layerData.indexOf(height))
					{
						if (layerData[height][width] is TileData)
						{
							var tileData:TileData = layerData[height][width];
							if (tileData.sheetId != null)
							{
								var sheet:TileSheet = tSheet.getSheet(tileData.sheetId);
								var tile:Tile = sheet.getNumTile(tileData.tileId);
								tile.x = width * renderSize.tileSize.width;
								tile.y = height * renderSize.tileSize.height;
								buffer.addChild(tile);
								tile.parent = buffer;
								tile = null;
								sheet = null;
							}// Endif sheet is not null
							tileData = null;
						}// Endif layerData >= 0
					}// Endif indexof height and width
				}// End for width loop;
			}// End for height loop;
			buffer.x = 0;
			buffer.y = 0;
			blit(buffer);
			ready = true;
			
			// Displatch event that layer is done being drawn
			var obj:Object = new Object();
			obj.layerName = layerName;
			obj.curr = drawSequence;
			obj.next = drawSequence + 1;
			dispatchEvent(new LayerEvents(LayerEvents.DRAW_COMPLETE, obj)); 
		}// End method draw
		
		public function setTile(width:int, height:int, tile:TileData):void
		{
			// Check to make sure we have a valid layerData array
			if (layerData == null)
			{
				_layerData = [];
			}// Endif layerData is null
			// Check to make sure we have a valid height array
			if (layerData[height] == null)
			{
				layerData[height] = new Array();
			}// Endif layerData[height] is null
			
			// Store cell id in data structure
			layerData[height][width] = tile;
			
		}// End method setTile
		
		public function blit(buf:Sprite):void
		{
			if (_buffer != null)
			{
				_layerGfx.removeChild(_buffer);
			}
			// Blit method is used to transfer the draw buffer from out of view and place it on the layer stage
			_buffer = buf;
			
			_layerGfx.addChild(_buffer);
		}// End method blit
		
		/**
		 * Check to see if layer is ready to be drawn
		 * 
		 * @return Boolen layer is ready
		 */
		public function isReady():Boolean
		{
			var retVal:Boolean = ready;
			if (layerData == null) retVal = true;
			return retVal;
		}// End method isReady
		
		/**
		 * Convert layer to text and print out layer name
		 * 
		 * @return String layerName
		 */
		override public function toString():String
		{
			return layerName;
		}// End toString
		
		/**
		 * Get layer stage sprite
		 * 
		 * @return stage:Sprite
		 */
		public function get stage():Sprite
		{
			return _stage;
		}
		
		/**
		 * IPeObject interface to retrieve object as a sprite
		 */
		public function get sprite():Sprite
		{
			return _stage;
		}
		
		/**
		 * Return the layer name as string
		 * 
		 * @return layerName:String
		 */
		public function get lName():String
		{
			return layerName;
		}// End method lName
		
		/**
		 * Return the map data as an array, used for building layer information like what
		 * tile is located in what position
		 * 
		 * @return mapData:Array
		 */
		public function get mapData():Array
		{
			return layerData;
		}// End method mapData
		
		/**
		 * Set layerSpeed when MapLoader processes layer
		 */
		public function set layerSpeed(pSize:Size):void
		{
			scrollSpeed = new NumSize();
			scrollSpeed.height = 0.0;
			scrollSpeed.width = 0.0;
			
			if (pSize.width > 0 && layerSize.width > 0)
			{
				scrollSpeed.width = ((layerSize.width * renderSize.tileSize.width) - screenRes.width) / pSize.width;
			}
			if (pSize.height > 0 && layerSize.height > 0)
			{
				scrollSpeed.height = ((layerSize.height * renderSize.tileSize.height)- screenRes.height) / pSize.height;
			}
			
			PeLogger.getInstance.log("Scroll Speed: " + scrollSpeed.toString());
		}// End method layerSpeed
		
		/**
		 * Move layer by adding PePoint data to current position.  Does take into
		 * accoutn deltaTime
		 * 
		 * @param	pos
		 */
		public function move(pos:PePoint):void
		{
			var posX:Number = 0.0;
			var deltaTime:Number = PeFPS.getInstance.deltaTime;
			
			layerPos.width += (scrollSpeed.width * Number(pos.x * deltaTime));
			layerPos.height += (scrollSpeed.height * Number(pos.y * deltaTime));
			// Check to see if we need to blit the level for new location
			var screenWidth:int = renderSize.end.width * renderSize.tileSize.width;

			// Check to see if we need to blit the level for new location
			if (Math.abs(layerPos.width) > (renderSize.resEnd.width - screenRes.width) ||
				(Math.abs(layerPos.width) < (renderSize.resStart.width + screenRes.width) && 
				(renderSize.resStart.width >= screenRes.width))
			)
			{
				var newPos:Size = new Size(Math.abs(layerPos.width), Math.abs(layerPos.height));
				draw(newPos);
			}
			
			// Keep map within boundry
			if (layerPos.width > 0.0)
			{
				 layerPos.width = 0.0;
			}
			if (layerPos.height > 0.0)
			{
				 layerPos.height = 0.0;
			}
			_rightSide = false;
			if (Math.abs(layerPos.width) > (renderSize.resEnd.width - screenRes.width))
			{
				layerPos.width = -(renderSize.resEnd.width - screenRes.width);
				_rightSide = true;
			}
			// TODO: check the height scrolling and adjust it when we are at max position
			
			stage.x = int(layerPos.width);
			stage.y = int(layerPos.height);
		}// End method move
		
		/**
		 * TODO: Not sure about this method right now need to find how it is being used
		 * This sets the layer id order from MapLoader
		 * @param	id
		 */
		public function setSequence(id:int):void
		{
			drawSequence = id;
		}
		
		/**
		 * Set screen resolution for the layer
		 * 
		 * @param	scrRes:Size
		 */
		public function setScreenRes(scrRes:Size):void
		{
			screenRes = scrRes;
		}// End method setScreenRes
		
		/**
		 * IPeObject interface to get layer name
		 * 
		 * @return name:String
		 */
		public function get name():String
		{
			return _name;
		}// End method get name
		
		/**
		 * IPeObject interface to get layer index
		 * @return layerId:int
		 */
		public function get layer():int
		{
			return _layerId;
		}// End method get layer
		
		/**
		 * IPeObject interface to set the layer when it gets added to a group
		 */
		public function set layer(layerId:int):void
		{
			_layerId = layerId;
		}// End method set layer
		
		/**
		 * IPeObject interface set owning group
		 */
		public function set owningGroup(grp:PeGroup):void
		{
			_group = grp;
		}// End method set owningGroup
		
		/**
		 * IPeObject interface to get ownign group
		 */
		public function get owningGroup():PeGroup
		{
			return _group;
		}// end method get owningGroup
		
		/**
		 * IPeObject interface to initialize group items
		 * 
		 * TODO: Need to implament this feasture for layers
		 * 
		 * @param	name
		 * @return
		 */
		public function init(name:String):Boolean
		{
			var retValue:Boolean = true;
			
			return retValue;
		}// End method init
		
		/**
		 * IPeObject interface to process the onFrame method but for layers
		 * we will dispatch this as an event for engine to handle
		 * 
		 * @param	e:Event
		 */
		public function onFrame(e:Event):void
		{
			dispatchEvent(new LayerEvents(LayerEvents.ENTER_FRAME, _group));
		}
		
		/**
		 * Remove layer from parent
		 */
		public function destroy():void
		{
			tSheet = null;
			_renderSize = null;
			_layerGfx.removeChild(_buffer);
			sprite.removeChild(_layerGfx);
			if (_parent.contains(sprite))
			{
				_parent.removeChild(sprite);
			}// Endif check for sprite in parent
			_stage = null;
		}// End mothod destroy
		
		public function set parent(inParent:DisplayObjectContainer):void
		{
			_parent = inParent;
		}
		
		public function setToSpawn(alpha:Number = 0.2):void
		{
			isSpawnLayer = true;
			_layerGfx.alpha = alpha;
		}// End method setToSpawn
		
		public function get isSpawn():Boolean
		{
			return isSpawnLayer;
		}// End method isSpawn
		
		public function get renderSize():PeGrid 
		{
			return _renderSize;
		}
		
		public function get layerData():Array 
		{
			return _layerData;
		}
		
		public function get layerGfx():Sprite 
		{
			return _layerGfx;
		}
		
		public function set tileSize(tSize:Size):void
		{
			renderSize.tileSize = tSize;
		}
		
		public function get rightSide():Boolean 
		{
			return _rightSide;
		}
	}
}