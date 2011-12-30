package com.pyro.engine.gfx2d 
{
	/**
	 * MapLoader class is used to construct level maps and display them to
	 * the game engine.
	 * 
	 * @author Leland Ede
	 */
	import com.pyro.engine.core.PeStageManager;
	import com.pyro.engine.core.PeWorld;
	import com.pyro.engine.gfx2d.layers.PePlayerLayer;
	import com.pyro.engine.gfx2d.tiles.TileArray;
	import com.pyro.engine.gfx2d.tiles.TileData;
	import data.characters.PeCharFactory;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	 
	import com.pyro.engine.core.IPeObject;
	import com.pyro.engine.objects.PeBitmap;
	import com.pyro.engine.gfx2d.dimensions.Size;
	import com.pyro.engine.gfx2d.layers.Layer;
	import com.pyro.engine.gfx2d.layers.LayerEvents;
	import com.pyro.engine.gfx2d.tiles.TileSheet;
	import com.pyro.engine.debug.PeLogger;
	import com.pyro.engine.gfx2d.dimensions.NumSize;
	import com.pyro.engine.objects.PePoint;
	import com.pyro.engine.gfx2d.EventMap;
	import com.pyro.engine.core.PeGroup;
	import com.pyro.engine.gfx2d.layers.PeSpawn;
	 
	// TODO: Comment code
	public class MapLoader extends EventDispatcher implements IPeObject
	{
		private var _spawnLayer:String;
		private var _playerLayer:String;
		private var spawnID:int;
		private var playerID:int;
		public var imgData:Array;
		public var layers:Array;
		public var tileSheets:TileArray;
		private var myStage:Sprite;
		private var maxSize:Size;
		private var isMapLoaded:Boolean = false;
		private var _parent:DisplayObjectContainer;
		private var _name:String;
		private var _layer:int;
		private var _owningGroup:PeGroup;
		private var _world:PeWorld;
		private var _charbuilder:PeCharFactory;
		private var onFrameID:int;
		
		/**
		 * MapLoader is a utility class that you use to extend your actual map and pass it data to load.
		 * 
		 * @param	level
		 * @param	cStage
		 */
		public function MapLoader(level:String, cStage:Sprite) 
		{
			name = level;
			myStage = new Sprite();
			//parent = cStage;
		}
		
		/**
		 * Porcess XML map data from the tIDE map generator
		 * 
		 * This is how all those wonder levels get parsed from data, maps, and into nice
		 * looking levels that scroll
		 * 
		 * @param	data
		 * @return
		 */
		public function loadMapXML(data:XML):Boolean
		{
			// Method data memebers
			var retVal:Boolean = false;
			// Get tile sheet information
			var tileSheetData:XMLList = data.TileSheets.TileSheet;
			var tileData:XMLList = data.Layers.Layer;
			// Set default maxSize value for level used in calculating scroll speed
			maxSize = new Size(0, 0);
			// Create blank arrays
			layers = [];
			tileSheets = new TileArray();
			spawnID = -1;
			
			// Time to process each layer code
			for each(var sData:XML in tileSheetData)
			{
				// Temp variables used only in the parsing of each layer
				var key:String = sData.attributes();
				var imageKey:String = sData.ImageSource;
				var tileSize:Size;
				var imgSize:Size;
				var tileSpace:Size;
				
				// Get the sheet size from XML tag attribute
				var tmp:XMLList = sData.Alignment.attribute("SheetSize");
				// Create a new image size from tmp string or xml pased data
				imgSize = new Size(tmp);
				// Get tile size from XML data
				tmp = sData.Alignment.attribute("TileSize");
				// Create tile size object
				tileSize = new Size(tmp);
				// Get space between tiles
				tmp = sData.Alignment.attribute("TileSpace");
				// Create space size object
				tileSpace = new Size(tmp);
				// Create tile sheet object and store it in the sheets array
				if (!(imgData[imageKey] is Class))
				{
					throw("Missing tile set: " + imageKey);
				}
				tileSheets.setupSheet(new TileSheet(imgData[imageKey], imgSize, tileSize, tileSpace, key), key);
			}// End for sheet loop
			imgData = null;

			// Set access of XML to the layer definition section of XML data
			tileSheetData = data.Layers.Layer;
			// Loop through each layer and build data array
			for each(var tData:XML in tileSheetData)
			{
				var layerName:String = tData.attribute("Id");
				// Check to make sure layer is visible
				if (tData.attribute("Visible") == "True")
				{
					//var cellData:XML = tData.
					tmp = tData.Dimensions;
					var layerSize:Size = new Size(tmp.attribute("LayerSize"));
					var tsTmp:Size = new Size(tmp.attribute("TileSize"));
					// Check to see if layer is larger than max size width
					if ((layerSize.width * tsTmp.width) > maxSize.width )
					{
						maxSize.width = layerSize.width * tsTmp.width;
					}
					// Check to see if layer is larger than max height
					if ((layerSize.height * tsTmp.height) > maxSize.height)
					{
						maxSize.height = layerSize.height * tsTmp.height;
					}
					
					// Create XML row structure
					var row:XMLList = tData.TileArray.children();
					// Create a new layer object
					var layer:Layer;
					switch(layerName)
					{
						case _spawnLayer:
							layer = new PeSpawn(layerName, layerSize);
							break;
						case _playerLayer:
							layer = new PePlayerLayer(layerName, layerSize);
							break;
						default:
							layer = new Layer(layerName, layerSize);
							break;
					}// End switch layerName
					
					layer.tileSize = tsTmp;
					layer.tileSheet = tileSheets;
					
					// Set new width and height for map
					var width:int = 0;
					var height:int = 0;
					// Loop through each row in layer
					var tKey:String = null;
					for each(var rData:XML in row)
					{
						// Get XML reference tag
						// Get cell data for row
						var cell:XMLList = rData.children();
						// Loop through each cell item
						for each( var cData:XML in cell)
						{
							if (cData.name() == "TileSheet")
							{
								tKey = cData.attribute("Ref");
								continue;
							}
							// If tag is null advance map and create blank tile
							if (cData.name() == "Null")
							{
								// Loop through the number of blank tiles
								for (var i:int = 0; i < cData.attribute("Count"); i++)
								{
									layer.setTile(width++, height, new TileData(-1, null));
								}
								continue;
							}// Endif node is null
							// Store XML data in map array
							if (cData.name() == "Static")
							{
								layer.setTile(width++, height, new TileData(cData.attribute("Index"), tKey));
							}// Endif node is static
						}// End for loop cData
						// Incrament height by one
						height++;
						// Reset width to 0 for next loop interation
						width = 0;
						//trace(rData.Row.TileSheet.attribute("Ref"));
					}// End for row
					tKey = null;
					// Store layer in array and set its sequence number
					switch(layerName)
					{
						case _spawnLayer:
							layer.setToSpawn(0);
							spawnID = layers.length;
							break;
						case _playerLayer:
							layer.setToSpawn(0);
							playerID = layers.length;
							break;
					}
					layer.setSequence(layers.length);	
					layers.push(layer);
					layer = null;
				}// Endif layer is visible
			}// End for sheetData
			
			// Start layer drawing processes
			layers[0].layerSpeed = maxSize;
			// Add event listener so we can load each layer in proper order
			layers[0].addEventListener(LayerEvents.DRAW_COMPLETE, onComplete);
			// Draw time yes we can do it
			layers[0].draw(new Size(0, 0));
			return retVal;
		}// End method loadMapXML
		
		public function onComplete(e:LayerEvents):void
		{
			// Layer draw is complete
			var id:int = e.data.curr;
			var nId:int = e.data.next;
			// Remove event listener for layer
			layers[id].removeEventListener(LayerEvents.DRAW_COMPLETE, onComplete);
			myStage.addChild(Layer(layers[id]).sprite);
			Layer(layers[id]).parent = myStage;
			// Is this the last layer to draw?
			if (nId < layers.length )
			{
				// Start drawing next layer
				layers[nId].layerSpeed = maxSize;
				layers[nId].addEventListener(LayerEvents.DRAW_COMPLETE, onComplete);
				layers[nId].draw(new Size(0,0));
			}else
			{
				// Whew we are done now so let's tell the class we are ready for usage
				isMapLoaded = true;
				tileSheets = null;
				// All layers are done drawing so time to tell who ever cares we are done
				dispatchEvent(new EventMap(EventMap.LOAD_COMPLETE));
			}
		}
		
		/**
		 * Add image data to the array.  Used in the child class to tell us what images we have
		 * available to draw map
		 * 
		 * @param	data
		 */
		public function addImgData(data:Array):void
		{
			imgData = data;			
		}
		
		/**
		 * Moving map by adding position to current position
		 * @param	pos
		 */
		public function move(pos:PePoint):void
		{
			var rightSide:Boolean = false;
			for each(var layerMove:Layer in layers)
			{
				layerMove.move(pos);
				if (layerMove.name != _spawnLayer && layerMove.name != _playerLayer && !rightSide)
				{
					rightSide = layerMove.rightSide;
				}
			}// End for loop
			if (rightSide)
			{
				dispatchEvent(new EventMap(EventMap.AT_RIGHT_SIDE));
			}
		}// End method move
		
		/**
		 * Return current map sprite for use in game
		 */
		public function get mapStage():Sprite
		{
			return myStage;
		}// End method get mapStage
		
		/**
		 * Get the number of layers in map array
		 */
		public function get length():int
		{
			return layers.length;
		}// End method get length
		
		public function set spawnLayer(spawn:String):void 
		{
			_spawnLayer = spawn;
		}
		
		/**
		 * Get layer form provided index
		 * 
		 * @param	idx
		 * @return
		 */
		public function getLayer(idx:int):Layer
		{
			var retLayer:Layer = null;
			// Check to see if we have a valid layer id
			if ( layers.indexOf(idx) )
			{
				// Set retLayer to item in array
				retLayer = layers[idx];
			}
			return retLayer;
		}// End methid getLayer
		
		/**
		 * Access the spawn layer data if it is defined
		 * 
		 * @return PeSpawn
		 */
		public function get spawnData():PeSpawn
		{
			var retSpawn:PeSpawn;
			if (layers.indexOf(spawnID))
			{
				retSpawn = PeSpawn(layers[spawnID]);
			}
			return retSpawn;
		}// End method get spawnData
		
		public function init(inName:String):Boolean
		{
			name = inName;
			return true;
		}
		
		public function onFrame(e:Event):void
		{
			PeLogger.getInstance.log("Map Name:" + name);
			if (spawnData != null)
			{
				spawnData.onFrame(e);
			}
			if (playerData != null)
			{
				playerData.onFrame(e);
			}
			
		}
		
		public function destroy():void
		{
			if (layers.length > 0)
			{
				for each(var del:Layer in layers)
				{
					del.destroy();
				}
			}
			if (_parent.contains(myStage))
			{
				_parent.removeChild(myStage);
			}
			_spawnLayer = null;
			_playerLayer = null;
			tileSheets = null;
			maxSize = null;	
			_name = null;
			_owningGroup = null;
			_world = null;
			_charbuilder = null
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get layer():int 
		{
			return _layer;
		}
		
		public function set layer(value:int):void 
		{
			_layer = value;
		}
		
		public function get owningGroup():PeGroup 
		{
			return _owningGroup;
		}
		
		public function set owningGroup(value:PeGroup):void 
		{
			_owningGroup = value;
		}
		
		public function get parent():DisplayObjectContainer 
		{
			return _parent;
		}
		
		public function set parent(value:DisplayObjectContainer):void 
		{
			_parent = value;
		}
		
		public function get sprite():Sprite
		{
			return myStage;
		}
		
		public function get world():PeWorld 
		{
			return _world;
		}
		
		public function set world(wld:PeWorld):void 
		{
			if (spawnData != null)
			{
				spawnData.gameWorld = wld;
			}
			_world = wld;
		}
		
		public function set stageManager(sm:PeStageManager):void
		{
			if (spawnData != null)
			{
				spawnData.stageManager = sm;
			}
			if (playerData != null)
			{
				playerData.stageManager = sm;
			}
		}
		
		public function get playerData():PePlayerLayer
		{
			var plSpawn:PePlayerLayer;
			if (layers.indexOf(playerID))
			{
				plSpawn = PePlayerLayer(layers[playerID]);
			}
			return plSpawn;
		}
		
		public function set playerLayer(value:String):void 
		{
			_playerLayer = value;
		}
		
		public function set charbuilder(factory:PeCharFactory):void 
		{
			_charbuilder = factory;
		}
		
		public function get charbuilder():PeCharFactory
		{
			return _charbuilder;
		}
		
		public function set frameID(id:int):void
		{
			onFrameID = id;
		}
	}

}