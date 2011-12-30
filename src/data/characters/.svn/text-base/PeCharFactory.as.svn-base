package data.characters 
{
	/**
	 * ...
	 * @author Mark Petro
	 */
	 
	//Flash Imports
	import data.items.GameAxe;
	import data.items.GamePotion;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.display.Bitmap;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	
	//Pyro Engine imports
	import com.pyro.engine.objects.PePoint;
	import com.pyro.engine.gfx2d.sprites.PeBlitter;
	import data.characters.EventChar;
	import com.pyro.engine.character.PeCharacterTracker;
	import com.pyro.engine.debug.PeLogger;
	import com.pyro.engine.character.PeCharacter;
	import com.pyro.engine.gfx2d.gui.PeHUD;
	import com.pyro.engine.physics.PeBoxCollider;
	import com.pyro.engine.physics.PeCircleCollider;
	import com.pyro.engine.physics.PeVector2D;
	
	
	public class PeCharFactory extends EventDispatcher
	{
		// use double quotation marks instead of single ones when declaring a source - RobbieC
		// http://help.adobe.com/en_US/flex/using/WS2db454920e96a9e51e63e3d11c0bf60546-7ff2.html - check here for the reason - RobbieC
		[Embed(source = "Player/PePlayerDataTest.png")]
		public static const playerImage:Class;
		[Embed(source="Player/PePlayerDataTest.txt", mimeType = 'application/octet-stream')]
		public static const playerData:Class;
		
		[Embed(source = "Medium/PeMediumData.png")]
		public static const mediumImage:Class;
		[Embed(source="Medium/PeMediumData.txt", mimeType = 'application/octet-stream')]
		public static const mediumData:Class;
		
		[Embed(source = "Light/PeLightData.png")]
		public static const lightImage:Class;
		[Embed(source="Light/PeLightData.txt", mimeType = 'application/octet-stream')]
		public static const lightData:Class;
		
		[Embed(source = "Boss/PeBossData.png")]
		public static const bossImage:Class;
		[Embed(source="Boss/PeBossData.txt", mimeType = 'application/octet-stream')]
		public static const bossData:Class;
		
		[Embed(source = "../GUI/HUD/player_hud.png")]
		public static const HUDimage:Class;
		[Embed(source="../GUI/HUD/player_hud.txt", mimeType = 'application/octet-stream')]
		public static const HUDdata:Class;
		
		[Embed(source = "axe.png")]
		public static const axeImage:Class;
		[Embed(source = "axe.txt", mimeType = 'application/octet-stream')]
		public static const axeData:Class;
		
		[Embed(source = "life_bottle.png")]
		public static const lifeBottleImage:Class;
		[Embed(source = "life_bottle.txt", mimeType = 'application/octet-stream')]
		public static const lifeBottleData:Class;
		
		private var masterData:Array;
		private var masterImage:Array;
		private var master_stats:Array;
		
		public function PeCharFactory() 
		{
			masterData = new Array();
			masterImage = new Array();
			master_stats = new Array();
		}
		
		public function makeCharacter(pos:PePoint, type:String):PeCharacter
		{
			var chop:PeCharacter = new PeCharacter(type);
			chop.stats = SetupCharacter(pos, type);
			chop.setBlitter(fillChar(type));
			chop.sprite.hitArea = new Sprite();
			switch(type)
			{
				case "player":
				{
					// Set front collision
					chop.collider = new PeCircleCollider(new PeVector2D(64.0, 94.0), 20.0);
					chop.collAttack = new PeCircleCollider(new PeVector2D(64.0, 94.0), 80.0);
					// TODO: Set attack range back to normal
//					chop.collAttack = new PeCircleCollider(new PeVector2D(64.0, 94.0), 55.0);
					chop.collProjectile = new PeCircleCollider(new PeVector2D(64.0, 70.0), 30);
					chop.collProjectile.debug = false;
					break;
				}
				
				case "light":
				{
					chop.name = "Light";
					chop.collider = new PeCircleCollider(new PeVector2D(64.0, 94.0), 20.0);
					chop.collAttack = new PeCircleCollider(new PeVector2D(64.0, 94.0), 55.0);
					chop.collProjectile = new PeCircleCollider(new PeVector2D(64.0, 70.0), 45);
					chop.collider.debug = false;
					break;
				}
				
				case "medium":
				{
					chop.name = "Medium";
					chop.collider = new PeCircleCollider(new PeVector2D(64.0, 94.0), 20.0);
					chop.collAttack = new PeCircleCollider(new PeVector2D(64.0, 94.0), 55.0);
					chop.collProjectile = new PeCircleCollider(new PeVector2D(64.0, 70.0), 45);
					chop.collider.debug = false;
					break;
				}
								
				case "boss":
				{
					chop.name = "Boss";
					chop.collider = new PeCircleCollider(new PeVector2D(64.0, 94.0), 20.0);
					chop.collAttack = new PeCircleCollider(new PeVector2D(64.0, 94.0), 55.0);
					chop.collProjectile = new PeCircleCollider(new PeVector2D(64.0, 70.0), 45);
					chop.collider.debug = false;
					break;
				}
				
			}
			return chop;
		}
		
		public function fillHUD():PeHUD
		{
			return new PeHUD(masterData["HUD"], masterImage["HUD"]);
		}
		
		public function fillAxe():GameAxe
		{
			return new GameAxe(masterData["axe"], masterImage["axe"]);
		}
		
		public function fillPotion():GamePotion
		{
			return new GamePotion(masterData["life"], masterImage["life"]);
		}
		
		public function fillChar(type:String):PeBlitter
		{
			return new PeBlitter(masterData[type], masterImage[type]);
		}
		
		public function init():void
		{
			var file:ByteArray = new PeCharFactory.playerData();
			var fileData:String = file.readUTFBytes(file.length);
			var image:Bitmap = new PeCharFactory.playerImage();
			var imageData:BitmapData = image.bitmapData;
			
			masterData["player"] = prepData(fileData);
			masterImage["player"] = imageData;
			
			var mfile:ByteArray = new PeCharFactory.mediumData();
			var mfileData:String = mfile.readUTFBytes(mfile.length);
			var mimage:Bitmap = new PeCharFactory.mediumImage();
			var mimageData:BitmapData = mimage.bitmapData;
			
			masterData["medium"] = prepData(mfileData);
			masterImage["medium"] = mimageData;
			
			var lfile:ByteArray = new PeCharFactory.lightData();
			var lfileData:String = lfile.readUTFBytes(lfile.length);
			var limage:Bitmap = new PeCharFactory.lightImage();
			var limageData:BitmapData = limage.bitmapData;
			
			masterData["light"] = prepData(lfileData);
			masterImage["light"] = limageData;
			
			var bfile:ByteArray = new PeCharFactory.bossData();
			var bfileData:String = bfile.readUTFBytes(bfile.length);
			var bimage:Bitmap = new PeCharFactory.bossImage();
			var bimageData:BitmapData = bimage.bitmapData;
			
			masterData["boss"] = prepData(bfileData);
			masterImage["boss"] = bimageData;
			
			var HUDfile:ByteArray = new PeCharFactory.HUDdata();
			var HUDfileData:String = HUDfile.readUTFBytes(HUDfile.length);
			var HUDimage:Bitmap = new PeCharFactory.HUDimage();
			var HUDimageData:BitmapData = HUDimage.bitmapData;
			
			masterData["HUD"] = prepData(HUDfileData);
			masterImage["HUD"] = HUDimageData;
			
			var axeFile:ByteArray = new PeCharFactory.axeData();
			var axeFileData:String = axeFile.readUTFBytes(axeFile.length);
			var axeImg:Bitmap = new PeCharFactory.axeImage();
			var axeImageData:BitmapData = axeImg.bitmapData;
			
			masterData["axe"] = prepData(axeFileData);
			masterImage["axe"] = axeImageData;
			
			var btlFile:ByteArray = new PeCharFactory.lifeBottleData();
			var btlFileData:String = btlFile.readUTFBytes(axeFile.length);
			var btlImg:Bitmap = new PeCharFactory.lifeBottleImage();
			var btlImageData:BitmapData = btlImg.bitmapData;
			
			masterData["life"] = prepData(btlFileData);
			masterImage["life"] = btlImageData;
			
			PeLogger.getInstance.log("Loading Character Data");
			master_stats = new Array;
			PeLogger.getInstance.log("Loading Player...");
			// TODO: Set attack damage back to 8
			master_stats["player"] = new Array(35, 5, 8, 40, 38);
			PeLogger.getInstance.log("Loading Light Enemey...");
			master_stats["light"] = new Array(8, 2, 2, 25, 0);
			PeLogger.getInstance.log("Loading Medium Enemey...");
			master_stats["medium"] = new Array(12, 3, 3, 30, 0);
			PeLogger.getInstance.log("Loading Level 1 Boss...");
			master_stats["boss1"] = new Array(50, 8, 4, 35, 0);
			PeLogger.getInstance.log("Loading Level 2 Boss...");
			master_stats["boss"] = new Array(65, 9, 6, 40, 0);
			PeLogger.getInstance.log("Loading Level 3 Boss...");
			master_stats["boss3"] = new Array(100, 9, 7, 45, 0);
			PeLogger.getInstance.log("Loading Level 4 Boss...");
			master_stats["boss4"] = new Array(200, 10, 9, 50, 0);
			PeLogger.getInstance.log("Character Data Loading Complete");
			
			file == null;
			fileData = null;
			image = null;
			imageData = null;
			
			mfile == null;
			mfileData = null;
			mimage = null;
			mimageData = null;
			
			lfile == null;
			lfileData = null;
			limage = null;
			limageData = null;
			
			bfile == null;
			bfileData = null;
			bimage = null;
			bimageData = null;
			
			dispatchEvent(new EventChar(EventChar.LOAD_COMPLETE));
		}
		
		/*
		 * 
		 * This is a slightly modified version of Leland's parseData function from SpriteLoader
		 * 
		 */
		private function prepData(data:String):Array
		{
			// Create a new Array to return with all animation information
			var setArray:Array = new Array();
			var dirArray:Array = new Array()
			var frameArray:Array = new Array()
			
			var subFrame:int = 0;
			
			// Create a data structure to store each line from data file
			var lineData:Array = new Array();
			// Break data up based on the line feed and charage return
			lineData = data.split("\r\n");
			// Loop through every line in file data
			for (var i:int = 0; i < lineData.length-1; i++)
			{
				// Create temp array to store lineData peices
				var tmp:Array = new Array();
				// Break line up on the equal sign
				tmp = lineData[i].split("=");
				// Create key from first array element (animation_direction####)
				var key:String = tmp[0].substring(0, (tmp[0].length - 5));
				// Separate and store the animation set and direction
				var tmpSplit:Array = new Array();
				tmpSplit = key.split("_")
				var action:String = tmpSplit[0];
				
				// Get frame number for this key
				var frameKey:int = tmp[0].substring(tmp[0].length - 4, tmp[0].length - 1);
				if (setArray[action] == null)
				{
					setArray[action] = new Array();
				}
				var direction:String = tmpSplit[1];
				if (setArray[action][direction] == null)
				{
					setArray[action][direction] = new Array();
					subFrame = frameKey;
				}
				// Create temp number variable
				var tmpNum:Array;
				// Split second element of tmp array based on space character
				tmpNum = tmp[1].split(" ");
				// Burn first array element since it is blank
				tmpNum.shift();
				// Createa rectangle where to get the sprite from sprite sheet location
				var frame:Rectangle = new Rectangle(int(tmpNum[0]), int(tmpNum[1]), int(tmpNum[2]), int(tmpNum[3]) );
				// Add all this to the master array
				setArray[action][direction][frameKey-subFrame] = frame;	
			}// End for loop
			
			return setArray;
		}
		
		public function SetupCharacter(pos:PePoint, type:String):PeCharacterTracker
		{
			
			var setup_char:PeCharacterTracker = new PeCharacterTracker();
			setup_char.pos = pos;
			setup_char.type = type;
			if (type == "player")
			{
				setup_char.HUD = fillHUD();
			}
			setup_char.maxLife = master_stats[type][0];
			setup_char.life = master_stats[type][0];
			setup_char.speed = master_stats[type][1];
			setup_char.attack = master_stats[type][2];
			setup_char.attackSpeed = master_stats[type][3];
			setup_char.blockSpeed = master_stats[type][4];
			return setup_char;
		}
		
	}

}