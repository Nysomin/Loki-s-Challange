package data.animations 
{
	/**
	 * Example sprite sheet of how to convert
	 * 
	 * @author Leland Ede
	 */
	import com.pyro.engine.gfx2d.sprites.PeSprite;
	import com.pyro.engine.gfx2d.sprites.SpriteArray;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;

	import com.pyro.engine.debug.PeLogger;
	import com.pyro.engine.gfx2d.sprites.SpriteLoader;
	
	public class testSprite extends SpriteLoader
	{
		// Embed the datasheet that stores sprite locaiton
		[Embed(source = "testspritesheet/05_Viking_run.txt", mimeType="application/octet-stream")]
		public static const spriteData:Class;
		// Embed sprite sheet image
		[Embed(source = "testspritesheet/05_Viking_run.png")]
		public static const spriteImage:Class;
		
		[Embed(source = "testspritesheet/testsheet.txt", mimeType = "application/octet-stream")]
		public static const idleData:Class;
		[Embed(source = "testspritesheet/testsheet.png")]
		public static const idleImage:Class;
		
		
		// Class varaibles needed for conversions
		private var file:ByteArray;
		private var fileData:String;
		private var gStage:Sprite;
		
		public function testSprite(inStage:Sprite) 
		{
			// Store stage in cStage for later use
			gStage = inStage;
			// Convert file data
			file = new testSprite.idleData;
			fileData = file.readUTFBytes(file.length);
			
			// Process spritesheet and all its data
			super(fileData, idleImage, gStage);
		}// End method contructor
		
		public function run(color:String):PeSprite
		{
			return addSprite("viking_" + color + "_run_right");
		}// End method get run
		
		public function addSprite(key:String):PeSprite
		{
			gStage.addEventListener(Event.ENTER_FRAME, getSprite(key).onFrame);
			return getSprite(key);
		}
		
		public function get idle():PeSprite
		{
			return addSprite("viking_idle");
		}
		
	}

}