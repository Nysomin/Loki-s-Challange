package data.levels.lvlOne 
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

	public class PeLevelOne extends MapLoader 
	{
		[Embed(source = "assets/LevelOne.tide", mimeType="application/octet-stream")]
		public static const mapData:Class;
		
		[Embed(source = "assets/forest.png")]
		public static const forest:Class;
		[Embed(source = "assets/forestfront.png")]
		public static const forestfront:Class;
		[Embed(source = "assets/front_graves.png")]
		public static const front_graves:Class;
		[Embed(source = "assets/graves.png")]
		public static const graves:Class;
		[Embed(source = "assets/nograves.png")]
		public static const nograves:Class;
		[Embed(source = "assets/spawn.png")]
		public static const spawn:Class;
		[Embed(source = 'assets/midother.png')]
		public static const midother:Class;
		[Embed(source = 'assets/midgraves.png')]
		public static const midgraves:Class;
		[Embed(source = 'assets/midforest.png')]
		public static const midforest:Class;
		[Embed(source = 'assets/forestreverse.png')]
		public static const forestreverse:Class;
		[Embed(source='assets/forestback.png')]
		public static const forestback:Class;
		[Embed(source = 'assets/night3.png')]
		public static const night:Class;
		[Embed(source = 'assets/nightmountians.png')]
		public static const nightmountians:Class;
		
		private var _charbuilder:PeCharFactory;
		private var ai:AIController;
		
		
		public function PeLevelOne(inStage:Sprite) 
		{
			// Set spawn layer
			spawnLayer = "monsterspawn";
			playerLayer = "playerspawn";
			// Setup ai level system
			ai = new AIController();
			super("Level One", inStage);
		}
		
		override public function init(name:String):Boolean
		{
			// Change this to the name of level class
			var file:ByteArray = new PeLevelOne.mapData();
			var fileData:String;
			fileData = file.readUTFBytes(file.length);
			// Create level XML data set
			var xmlData:XML = new XML(fileData);

			var imgData:Array = new Array();
			imgData["forest.png"] = forest;
			imgData["forestfront.png"] = forestfront;
			imgData["front_graves.png"] = front_graves;
			imgData["graves.png"] = graves;
			imgData["nograves.png"] = nograves;
			imgData["spawn.png"] = spawn;
			imgData["midother.png"] = midother;
			imgData["midgraves.png"] = midgraves;
			imgData["midforest.png"] = midforest;
			imgData["forestreverse.png"] = forestreverse;
			imgData["forestback.png"] = forestback;
			imgData["night3.png"] = night;
			imgData["nightmountians.png"] = nightmountians;

			addImgData(imgData);
			loadMapXML(xmlData);
			
			spawnData.addEventListener(SpawnEvent.SPAWN, onSpawn);
			spawnData.addEventListener(CollisionEvent.HIT, onHit);
			PeSoundEngine.getInstance.stopSound("intro");
			PeSoundEngine.getInstance.playSound("lvlOne", true);
			
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
						PeSoundEngine.getInstance.stopSound("lvlone");
						PeSoundEngine.getInstance.playSound("lvlOne_boss", true);
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
			PeSoundEngine.getInstance.stopSound("lvlone");
			//spawnData.removeEventListener(ProjectileEvent.PROJECTILE_HIT, onProjectile);
		}
		
		private function onProjectile(e:ProjectileEvent):void 
		{
			PeLogger.getInstance.log("Hit monster so do someting!");
		}
				
	}

}