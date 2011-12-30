package com.pyro.engine.gfx2d.layers 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;

	import com.pyro.engine.character.PeCharacter;
	import com.pyro.engine.core.IPeObject;
	import com.pyro.engine.core.IPeTicked;
	import com.pyro.engine.core.PeStageManager;
	import com.pyro.engine.core.PeWorld;
	import com.pyro.engine.debug.PeLogger;
	import com.pyro.engine.gfx2d.dimensions.Size;
	import com.pyro.engine.gfx2d.objects.PeSpawnObject;
	import com.pyro.engine.objects.PePoint;
	import com.pyro.engine.gfx2d.tiles.TileData;
	import com.pyro.engine.character.CharacterEvent;
	import com.pyro.engine.character.PeProjectile;
	import com.pyro.engine.physics.CollisionEvent;
	
	public class PePlayerLayer extends Layer implements IPeTicked
	{
		private var _playerPos:PePoint;
		private var mySprite:Sprite;
		private var objectArray:Array;
		private var _gameWorld:PeWorld;
		private var _stageManager:PeStageManager;
		private var _tickID:int;
		
		private var _lastTick:int;
		
		public function PePlayerLayer(name:String, lSize:Size) 
		{
			super(name, lSize);				// Run super constructor
			mySprite = new Sprite();		// Create new sprite for layer
			sprite.addChild(mySprite);		// Add mySprite to sprite layer
			objectArray = [];				// Objects int he spawn layer
			_lastTick = 0;					// Where to start the tick event handler
		}
		
		/**
		 * Return the player start position based on the tile map data
		 * 
		 * @return PePoint
		 */
		public function get playerPos():PePoint
		{
			if (_playerPos == null)
			{
				_playerPos = PePoint.ZERO;
				// Find the spot on the game map where we spawn the player
				for (var width:int = renderSize.start.width; width < renderSize.end.width; width++)
				{
					for (var height:int = renderSize.start.height; height < renderSize.end.height; height++)
					{
						if (TileData(layerData[height][width]).tileId == 0)
						{
							_playerPos.x = (width * renderSize.tileSize.width) - 32;
							_playerPos.y = (height * renderSize.tileSize.height) - 64;
							_playerPos.z = (height - 360) / 115
							TileData(layerData[height][width]).tileId = -1;
						}// Endif layerData equials player tile
					}// End for 
				}
			}// Endif player position not defined
			return _playerPos;
		}// End method playerPos
		
		override public function onFrame(e:Event):void 
		{
			if (objectArray != null && objectArray.length > 0)
			{
				for each(var char:PeCharacter in objectArray)
				{
					if (char != null)
					{
					IPeObject(char).onFrame(e);
					}
				
				}
			}
			//super.onFrame(e);
		}
		
		override public function move(pos:PePoint):void 
		{
			//super.move(pos);
		}
		
		override public function draw(currPos:Size):void 
		{
			super.draw(currPos);
		}
		
		public function addObject(obj:IPeObject):void
		{
			if (objectArray.length == 0)
			{
				tickID = _stageManager.addTickObject(this);
			}
			var idx:int = -1;
			// Search for empty slot
			for (var i:int = 0; i < objectArray.length; i++)
			{
				if (objectArray[i] == null)
				{
					idx = i;
					break;
				}
			}
			if (idx >= 0)
			{
				obj.layer = idx;
				objectArray[idx] = obj;
			}else
			{
				obj.layer = objectArray.length;
				objectArray.push(obj);
			}
			sprite.addChild(IPeObject(objectArray[obj.layer]).sprite);
			PeCharacter(obj).addEventListener(CharacterEvent.REMOVE_CHARACTER, removeObject);
		}
		
		public function removeObject(e:CharacterEvent):void
		{
			var idx:int = e.layer;
			PeLogger.getInstance.log("Remove monster from game stage: " + idx);
			if (objectArray[idx] != null)
			{
				PeCharacter(objectArray[idx]).removeEventListener(CharacterEvent.REMOVE_CHARACTER, removeObject);
				//sprite.removeChild(IPeObject(objectArray[idx]).sprite);
				objectArray[idx] = null;
			}else
			{
				throw("Error: idx is not a valid object anymore!");
			}
		}
		
		public function onTick(deltaTime:Number):void
		{
			if (objectArray.length > 0)
			{
				var time:int = getTimer();
				for (var i:int = _lastTick; i < objectArray.length; i++)
				{
					if (objectArray[i] is PeCharacter)
					{
						if (PeCharacter(objectArray[i]).tickReady)
						{
							PeCharacter(objectArray[i]).onTick(deltaTime);
						}
					}
					if (getTimer() - time > 4)
					{
						_lastTick = i;
						break;
					}
					_lastTick = 0;
				}
			}
		}
		
		public function get tickReady():Boolean
		{
			return true;
		}
		
		public function set gameWorld(world:PeWorld):void 
		{
			_gameWorld = world;
		}
				
		public function set stageManager(sm:PeStageManager):void
		{
			_stageManager = sm;
		}
		
		public function get tickID():int 
		{
			return _tickID;
		}
		
		public function set tickID(value:int):void 
		{
			_tickID = value;
		}
		
		override public function setToSpawn(alpha:Number = 0.0):void 
		{
			super.setToSpawn(alpha);
		}
		
		override public function destroy():void 
		{
			if (objectArray.length > 0)
			{
				for each(var obj:PeCharacter in objectArray)
				{
					obj.removeEventListener(CharacterEvent.REMOVE_CHARACTER, removeObject);
				}
			}
			_stageManager.removeTickObject(tickID);
			_playerPos = null;
			mySprite = null;
			objectArray = null;
			_stageManager = null;
			super.destroy();
		}
	}

}