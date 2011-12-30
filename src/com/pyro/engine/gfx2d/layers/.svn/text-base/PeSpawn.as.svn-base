package com.pyro.engine.gfx2d.layers 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	import com.pyro.engine.ai.AIController;
	import com.pyro.engine.character.CharacterEvent;
	import com.pyro.engine.character.PeLock;
	import com.pyro.engine.character.PeProjectile;
	import com.pyro.engine.physics.CollisionEvent;
	import com.pyro.engine.physics.PeCircleCollider;
	import com.pyro.engine.physics.PeVector2D;
	import com.pyro.engine.physics.ProjectileEvent;
	import data.items.GamePotion;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;

	import com.pyro.engine.ai.PeMonsterAI;
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
	import com.pyro.engine.character.PePowerup;

	public class PeSpawn extends Layer implements IPeTicked
	{
		public static const ENEMY:String		= "Enemy";
		public static const PLAYER:String		= "Player";
		
		private var _playerPos:PePoint;
		private var _monsterSpawn:Array;
		private var mySprite:Sprite;
		private var objectArray:Array;
		private var _gameWorld:PeWorld;
		private var _player:PeCharacter;
		private var _stageManager:PeStageManager;
		private var _tickID:int;
		private var _projectileArray:Array;
		private var _powerups:Array;
		private var _lifePotion:GamePotion;
		private var _ai:AIController;

		private var _lastTick:int;
		
		public function PeSpawn(name:String, lSize:Size) 
		{
			super(name, lSize);				// Run super constructor
			mySprite = new Sprite();		// Create new sprite for layer
			sprite.addChild(mySprite);		// Add mySprite to sprite layer
			objectArray = [];				// Objects int he spawn layer
			_lastTick = 0;					// Where to start the tick event handler
			_projectileArray = [];
			_projectileArray[ENEMY] = [];
			_projectileArray[PLAYER] = [];
			_powerups = [];
		}
		
		public function buildMonsterList():void
		{
			_monsterSpawn = [];
			for (var width:int = renderSize.start.width; width < renderSize.end.width; width++)
			{
				for (var height:int = renderSize.start.height; height < renderSize.end.height; height++)
				{
					if (TileData(layerData[height][width]).tileId > 0)
					{
						// Calculate position
						var tilePos:PePoint = PePoint.ZERO;
						tilePos.x = (width * renderSize.tileSize.width) - 32;
						tilePos.y = (height * renderSize.tileSize.height) - 64;
						tilePos.z = (tilePos.y - 360) / (475 - 360);
						// Create new object
						var spawn:PeSpawnObject = new PeSpawnObject(tilePos, TileData(layerData[height][width]).tileId);
						_monsterSpawn.push(spawn);
						TileData(layerData[height][width]).tileId = -1;
					}
				}
			}
		}
		
		override public function move(pos:PePoint):void 
		{
			// Check to see if we need to spawn a monster
			if (_monsterSpawn != null)
			{
				// Create a check point to look on the map for new monsters in array
				var chkPos:PePoint = PePoint.ZERO;
				chkPos.x = Math.abs(sprite.x) + pos.x + 850;
				chkPos.y = sprite.y;
				// Loop through all the monsters
				for (var i:int = 0; i < _monsterSpawn.length; i++)
				{
					if (PeSpawnObject(_monsterSpawn[i]).pos.x < Math.abs(chkPos.x))
					{
						var spawn:PeSpawnObject = _monsterSpawn[i];
						dispatchEvent(new SpawnEvent(SpawnEvent.SPAWN, _monsterSpawn[i]));
						_monsterSpawn.splice(i, 1);
					}// Endif monster x is greater than check position x
				}// End for i loop monster length
				chkPos = null;
			}// Endif Monster array is not null
			
			super.move(pos);
			var myPos:PePoint = new PePoint(Math.abs(sprite.x), Math.abs(sprite.y), 0);
			if (_gameWorld is PeWorld)
			{
				_gameWorld.mapPosition = myPos;
			}
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
			var reset:Boolean;

			if (objectArray != null && objectArray.length > 0)
			{
				reset = true;
				for each(var char:PeCharacter in objectArray)
				{
					if (char != null)
					{
						IPeObject(char).onFrame(e);
						PeMonsterAI(char.controller).player = _gameWorld.playerPosition;
						char.controller.onFrame(e);
						reset = false;
						if (char.sprite.hitTestObject(_player.sprite)
							&& !char.stats.dead)
						{
							dispatchEvent(new CollisionEvent(CollisionEvent.HIT, char));
						}// Endif player hit test
						
						if (_projectileArray[PLAYER].length > 0)
						{
							for each(var pProj:PeProjectile in _projectileArray[PLAYER])
							{
								if (pProj != null && char.sprite.hitTestObject(pProj.sprite))
								{
									monsterHit(pProj, char);
								}// Endif projectile is not null
							}// End for each loop of each projectile in array
						}// Endif projectile array has items to check
					}// Endif char is not null
				
				}
				if (reset)
				{
					objectArray = [];
				}
			}// Endif objectArray
			
			// Check monster projectiles
			if (_projectileArray != null && _projectileArray[ENEMY].length > 0)
			{
				reset = true;
				for each(var proj:PeProjectile in _projectileArray[ENEMY])
				{
					if (proj != null)
					{
						reset = false;
						proj.onFrame(e);
						if (proj.sprite != null && proj.sprite.hitTestObject(_player.sprite))
						{
							dispatchEvent(new ProjectileEvent(ProjectileEvent.PROJECTILE_HIT, proj));
						}
					}
				}
				// Cleanup monster array
				if (reset)
				{
					_projectileArray[ENEMY] = [];
				}
			}
			
			
			if (_projectileArray != null && drawArray(_projectileArray[PLAYER], e))
			{
				_projectileArray[PLAYER] = [];
			}
			
			if (_powerups != null && drawArray(_powerups, e, true))
			{
				_powerups = [];
			}
			
			super.onFrame(e);
		}
		
		private function drawArray(arr:Array, e:Event, checkCollision:Boolean = false):Boolean
		{
			var reset:Boolean = true;
			if (arr != null && arr.length > 0)
			{
				for each(var obj:IPeObject in arr)
				{
					if (obj != null)
					{
						reset = false;
						obj.onFrame(e);
						if (checkCollision
							&& _player.collider.hitTestCollider(PePowerup(obj).collider))
						{
							obj.destroy();
							obj = null;
							_player.stats.lifePotions++;
						}
					}
				}
			}
			
			return reset;
		}
		
		override public function draw(currPos:Size):void 
		{
			super.draw(currPos);
			buildMonsterList();
		}
		
		public function addObject(obj:IPeObject):void
		{
			if (objectArray.length == 0)
			{
				tickID = _stageManager.addTickObject(this);
			}
			// Search for empty slot
			var idx:int = getIndex(objectArray);
			objectArray[idx] = obj;
			obj.layer = idx;
			sprite.addChild(IPeObject(objectArray[obj.layer]).sprite);
			PeCharacter(obj).addEventListener(CharacterEvent.REMOVE_CHARACTER, removeObject);
		}
		
		public function addEnemyProjectile(obj:IPeObject):void
		{
			// Search for empty slot
			var idx:int = getIndex(_projectileArray[ENEMY]);
			_projectileArray[ENEMY][idx] = obj;
			obj.layer = idx;
			sprite.addChild(IPeObject(_projectileArray[ENEMY][idx]).sprite);
			IPeObject(_projectileArray[ENEMY][idx]).parent = sprite;
			PeProjectile(obj).sprite.addEventListener(CharacterEvent.KILL_PROJECTILE, removeEnemyProjectile);
		}
		
		public function addPlayerProjectile(obj:IPeObject):void
		{
			// Search for empty slot
			var idx:int = getIndex(_projectileArray[PLAYER]);
			_projectileArray[PLAYER][idx] = obj;
			obj.layer = idx;
			sprite.addChild(IPeObject(_projectileArray[PLAYER][idx]).sprite);
			IPeObject(_projectileArray[PLAYER][idx]).parent = sprite;
			PeProjectile(obj).sprite.addEventListener(CharacterEvent.KILL_PROJECTILE, removePlayerProjectile);
		}
		
		public function addPowerup(obj:IPeObject):void
		{
			var idx:int = getIndex(_powerups);
			_powerups[idx] = obj;
			IPeObject(_powerups[idx]).parent = sprite;
			sprite.addChild(IPeObject(_powerups[idx]).sprite);
		}
		
		public function removeEnemyProjectile(e:CharacterEvent):void 
		{
			if (_projectileArray[ENEMY][e.layer] != null)
			{
				PeProjectile(_projectileArray[ENEMY][e.layer]).sprite.removeEventListener(CharacterEvent.KILL_PROJECTILE, removeEnemyProjectile);
				IPeObject(_projectileArray[ENEMY][e.layer]).destroy();
				_projectileArray[ENEMY][e.layer] = null;
			}
		}
		
		public function removePlayerProjectile(idx:int):void 
		{
			if (_projectileArray[PLAYER][idx] != null)
			{
				PeProjectile(_projectileArray[PLAYER][idx]).sprite.removeEventListener(CharacterEvent.KILL_PROJECTILE, removePlayerProjectile);
				IPeObject(_projectileArray[PLAYER][idx]).destroy();
				_projectileArray[PLAYER][idx] = null;
			}
		}
		
		public function removePowerup(e:CharacterEvent):void
		{
			PePowerup(_powerups[e.layer]).destroy();
			_powerups[e.layer] = null;
		}
		
		public function setupMonsterDeath(idx:int):void
		{
			if (!PeCharacter(objectArray[idx]).hasEventListener(CharacterEvent.REMOVE_CHARACTER))
			{
				PeLogger.getInstance.log("Adding monster to death cycle: " + idx);
				PeCharacter(objectArray[idx]).addEventListener(CharacterEvent.REMOVE_CHARACTER, removeObject);
			}
		}
		
		public function removeObject(e:CharacterEvent):void
		{
			var idx:int = e.layer;
			PeLogger.getInstance.log("Remove monster from game stage: " + idx);
			if (objectArray[idx] != null)
			{
				// Clear monster controller out of AI system
				if (_ai != null)
				{
					_ai.clearController(PeMonsterAI(PeCharacter(objectArray[idx]).controller).layer);
				}
				// Remove event listener
				PeCharacter(objectArray[idx]).removeEventListener(CharacterEvent.REMOVE_CHARACTER, removeObject);
				var pos:PePoint = PeCharacter(objectArray[idx]).stats.pos;
				// Remnove sprite from stage
				sprite.removeChild(IPeObject(objectArray[idx]).sprite);
				// Clear object
				objectArray[idx] = null;
				var spawnPotion:int = Math.random() * 100 + 1
				if ( spawnPotion > 69 && spawnPotion < 75)
				{
					pos.x += 64;
					pos.y += 64;
					var power:PePowerup = new PePowerup();
					power.collider = new PeCircleCollider(new PeVector2D(8.0, 15.0), 20); 
					power.sprite.addChild(power.collider.sprite);
					power.init("Potion");
					power.pos = new PeVector2D(pos.x, pos.y);
					addPowerup(power);
				}
			}else
			{
				throw("Error: idx is not a valid object anymore!");
			}
		}
		
		public function onTick(deltaTime:Number):void
		{
			if (objectArray != null && objectArray.length > 0)
			{
				if (_ai != null)
				{
					_ai.onTick(deltaTime);
				}
				var time:int = getTimer();
				for (var i:int = _lastTick; i < objectArray.length; i++)
				{
					if (objectArray[i] != null && objectArray[i].controller is PeMonsterAI)
					{
						if (PeMonsterAI(PeCharacter(objectArray[i]).controller).tickReady)
						{
							PeMonsterAI(PeCharacter(objectArray[i]).controller).onTick(deltaTime);
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
		
		public function getIndex(arr:Array):int
		{
			/*var idx:int = -1;
			if (arr.length > 0)
			{
				for (var i:int = 0; i < arr.length; i++)
				{
					if (arr[i] == null)
					{
						idx = i;
						break;
					}
				}
			}
			if (idx < 0)
			{
				idx = arr.length;
				arr.push(null);
			}*/
			
			return arr.length;
		}
		
		public function monsterHit(proj:PeProjectile, char:PeCharacter):void
		{
			if (proj.collider.hitTestCollider(char.collProjectile))
			{
				if (!(char.lockout.locked & PeLock.DIE))
				{
					char.reduceLife(proj.attack);
					if (char.stats.life <= 0)
					{
						_player.stats.exp += char.stats.expereince;
						PeMonsterAI(char.controller).hitByPlayer = true;
					}
					removePlayerProjectile(proj.layer);
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
		
		public function set player(value:PeCharacter):void 
		{
			_player = value;
			addEventListener(CollisionEvent.HIT, _player.onCollision);
			addEventListener(ProjectileEvent.PROJECTILE_HIT, _player.onProjectile);
		}
		
		public function set stageManager(sm:PeStageManager):void
		{
			_stageManager = sm;
		}
		
		public function set ai(inAI:AIController):void
		{
			_ai = inAI;
		}
		
		public function get tickID():int 
		{
			return _tickID;
		}
		
		public function set tickID(value:int):void 
		{
			_tickID = value;
		}
		
		public function set lifePotion(life:GamePotion):void 
		{
			_lifePotion = life;
			//_lifePotion.init();
		}
		
		override public function destroy():void 
		{
			removeEventListener(CollisionEvent.HIT, _player.onCollision);
			_stageManager.removeTickObject(tickID);
			_ai = null;
			_playerPos = null;
			_monsterSpawn = null;
			objectArray = null;
			_gameWorld = null;
			_player = null;
			_stageManager = null;
			_projectileArray = null;
			_powerups = null;
			_lifePotion = null;
			super.destroy();
		}
	}

}