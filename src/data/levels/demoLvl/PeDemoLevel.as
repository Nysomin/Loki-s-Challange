package data.levels.demoLvl 
{
	
	/**
	 * ...
	 * @author Leland Ede
	 */
	import com.pyro.engine.ai.AIController;
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
	import data.characters.PeCharFactory;

	public class PeDemoLevel extends MapLoader 
	{
		[Embed(source = "assets/demoLvl.tide", mimeType="application/octet-stream")]
		public static const mapData:Class;
		
		[Embed(source = "assets/farback.png")]
		public static const farback:Class;
		[Embed(source = "assets/midback.png")]
		public static const midback:Class;
		[Embed(source = "assets/midbacktrees.png")]
		public static const midbacktrees:Class;
		[Embed(source = "assets/nearbacktrees.png")]
		public static const nearbacktrees:Class;
		[Embed(source = "assets/sky.png")]
		public static const sky:Class;
		[Embed(source = "assets/spawn.png")]
		public static const spawn:Class;
		
		private var ai:AIController;
		
		public function PeDemoLevel(inStage:Sprite) 
		{
			// Set spawn layer
			spawnLayer = "spawn";
			playerLayer = "playerspawn";
			ai = new AIController();
			super("Demo Level", inStage);
		}
		
		override public function init(name:String):Boolean
		{
			var file:ByteArray = new PeDemoLevel.mapData();
			var fileData:String;
			fileData = file.readUTFBytes(file.length);
			// Create level XML data set
			var xmlData:XML = new XML(fileData);

			var imgData:Array = new Array();
			imgData["farback.png"] = farback;
			imgData["midback.png"] = midback;
			imgData["midbacktrees.png"] = midbacktrees;
			imgData["nearbacktrees.png"] = nearbacktrees;
			imgData["sky.png"] = sky;
			imgData["spawn.png"] = spawn;
			
			addImgData(imgData);
			loadMapXML(xmlData);
						
			spawnData.addEventListener(SpawnEvent.SPAWN, onSpawn);
			spawnData.addEventListener(CollisionEvent.HIT, onHit);

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
						PeSoundEngine.getInstance.stopSound("lvlfour");
						PeSoundEngine.getInstance.playSound("lvlfour_boss", true);
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
			//spawnData.removeEventListener(ProjectileEvent.PROJECTILE_HIT, onProjectile);
		}
		
		private function onProjectile(e:ProjectileEvent):void 
		{
			PeLogger.getInstance.log("Hit monster so do someting!");
		}
		
	}

}