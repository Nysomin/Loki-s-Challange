package data.animations.player.red 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	import com.pyro.engine.core.stateMachines.PePlayerStateMachine;
	import com.pyro.engine.gfx2d.sprites.PeSprite;
	import com.pyro.engine.objects.PePoint;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.utils.ByteArray;

	import com.pyro.engine.gfx2d.sprites.SpriteLoader;

	public class PeRedPlayer extends SpriteLoader
	{
		// Embed the datasheet that stores sprite locaiton
		[Embed(source = "05_viking_red_spritesheet.txt", mimeType="application/octet-stream")]
		public static const spriteData:Class;
		// Embed sprite sheet image
		[Embed(source = "05_viking_red_spritesheet.png")]
		public static const spriteImage:Class;
		
		//private var sMachine:PePlayerStateMachine;
		
		public function PeRedPlayer(inStage:Sprite) 
		{
			var file:ByteArray;
			var fileData:String;
			
			file = new PeRedPlayer.spriteData();
			fileData = file.readUTFBytes(file.length);
			
			// Load sprite sheet
			super(fileData, spriteImage, inStage);
		}
		
		//public function get stateMachine():PePlayerStateMachine
		//{
			//return sMachine;
		//}
		
		public function get runRight():PeSprite
		{
			return getSprite("viking_red_run_right");
		}
		
		public function get runLeft():PeSprite
		{
			return getSprite("viking_red_run_left");
		}
		
		public function get idleRight():PeSprite
		{
			return getSprite("viking_red_idle_right");
		}
		
		public function get idleLeft():PeSprite
		{
			return getSprite("viking_red_idle_left");
		}
		
		public function get jumpRight():PeSprite
		{
			return getSprite("viking_red_idle_right");
		}
		
		public function get jumpLeft():PeSprite
		{
			return getSprite("viking_red_idle_left");
		}
		
	}

}