package data.levels.lvlThree 
{
	
	/**
	 * ...
	 * @author Leland Ede
	 */
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.utils.ByteArray;

	import com.pyro.engine.gfx2d.MapLoader;
	import com.pyro.engine.debug.PeLogger;
	import com.pyro.engine.gfx2d.layers.SpawnEvent;
	import com.pyro.engine.character.PeCharacter;
	import com.pyro.engine.ai.PeMonsterAI;
	import com.pyro.engine.ai.PeArcherAI;
	import com.pyro.engine.physics.CollisionEvent;
	import com.pyro.engine.sound.PeSoundEngine;
	import com.pyro.engine.physics.ProjectileEvent;
	import com.pyro.engine.ai.AIController;
	import data.characters.PeCharFactory;

	public class PeLevelThree extends MapLoader 
	{
		[Embed(source = "assets/lvlthree.tide", mimeType="application/octet-stream")]
		public static const mapData:Class;
		
		[Embed(source = "assets/boattile.png")]
		public static const boat:Class;
		[Embed(source = "assets/water.png")]
		public static const water:Class;
		[Embed(source = 'assets/ocean-sky.png')]
		public static const ocean_sky:Class;
		[Embed(source = "assets/spawn.png")]
		public static const spawn:Class;

		
		private var _charbuilder:PeCharFactory;
		private var ai:AIController;
		
		
		public function PeLevelThree(inStage:Sprite) 
		{
			// Set spawn layer
			spawnLayer = "monsterspawn";
			playerLayer = "playerspawn";
			// Setup ai level system
			ai = new AIController();
			super("Level Three", inStage);
		}
		
		override public function init(name:String):Boolean
		{
			// Change this to the name of level class
			var file:ByteArray = new PeLevelThree.mapData();
			var fileData:String;
			fileData = file.readUTFBytes(file.length);
			// Create level XML data set
			var xmlData:XML = new XML(fileData);

			var imgData:Array = new Array();
			imgData["boattile.png"] = boat;
			imgData["water.png"] = water;
			imgData["ocean-sky.png"] = ocean_sky;
			imgData["spawn.png"] = spawn;


			addImgData(imgData);
			loadMapXML(xmlData);
			
			spawnData.addEventListener(SpawnEvent.SPAWN, onSpawn);
			spawnData.addEventListener(CollisionEvent.HIT, onHit);
			PeSoundEngine.getInstance.stopSound("lvlTwo_boss");
			PeSoundEngine.getInstance.playSound("lvlThree", true);
			
			spawnData.ai = ai;
			
			return true;
		}

		private function onSpawn(e:SpawnEvent):void 
		{
			var monster:PeCharacter;
			var mType:String = "";
			
			switch(e.spawn.type)
			{
				case 1:
					{
						mType = "light";
					}
					break;
				case 2:
					{
						mType = "medium";
					}
					break;
				case 3:
					{
						mType = "boss";
						PeSoundEngine.getInstance.stopSound("lvlthree");
						PeSoundEngine.getInstance.playSound("lvlthree_boss", true);
					}
					break;
			}
			monster = charbuilder.makeCharacter(e.spawn.pos, mType);
			monster.leftBoundry = 0;
			monster.rightBoundry = 39600;
			monster.projAxe = charbuilder.fillAxe();
			if (e.spawn.type > 2)
			{
				monster.controller = new PeMonsterAI(monster.stats.pos);
			}else
			{
				monster.controller = ai.getController(monster.stats.pos);				
			}
			monster.init("");
			monster.spawner = spawnData.addEnemyProjectile;
 			//monster.sound = sndFont;
			spawnData.addObject(monster);
			
			monster = null;
		}
		
		private function onHit(e:CollisionEvent):void 
		{
			if (e.colObject.stats.life == 0)
			{
				spawnData.setupMonsterDeath(e.colObject.layer);
			}
		}
		
		override public function destroy():void 
		{
			super.destroy();
			spawnData.removeEventListener(SpawnEvent.SPAWN, onSpawn);
			spawnData.removeEventListener(CollisionEvent.HIT, onHit);
			PeSoundEngine.getInstance.stopSound("lvlThree");
			//spawnData.removeEventListener(ProjectileEvent.PROJECTILE_HIT, onProjectile);
		}
		
		private function onProjectile(e:ProjectileEvent):void 
		{
			PeLogger.getInstance.log("Hit monster so do someting!");
		}
				
	}

}