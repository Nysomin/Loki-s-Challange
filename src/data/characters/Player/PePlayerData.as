package data.characters.Player
{
	/**
	 * ...
	 * @author Leland Ede
	 * @author Mark Petro
	 */
	
	import com.pyro.engine.gfx2d.sprites.PeSprite;
	import com.pyro.engine.objects.PePoint;
	import data.characters.IPeCharacteraData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.utils.ByteArray;

	import com.pyro.engine.gfx2d.sprites.SpriteLoader;

	public class PePlayerData extends SpriteLoader //implements IPeCharacteraData
	{
		// Embed the datasheet that stores sprite locaiton
		[Embed(source="PePlayerData.txt", mimeType = "application/octet-stream")]
		public static const spriteData:Class;
		// Embed sprite sheet image
		[Embed(source="PePlayerData.png")]
		public static const spriteImage:Class;
		private static var allow:Boolean = false;
		
		//private var sMachine:PePlayerStateMachine;
		
		public function PePlayerData(inStage:Sprite) 
		{
			var file:ByteArray;
			var fileData:String;
			
			file = new PePlayerData.spriteData();
			fileData = file.readUTFBytes(file.length);
			
			// Load sprite sheet
			super(fileData, spriteImage, inStage);
		}
		
		/*
		public function get runRight():PeSprite
		{
			var retSprite:PeSprite = getSprite("player_run_right")
			retSprite.speed = 45;
			return retSprite;
		}
		
		public function get runLeft():PeSprite
		{
			var retSprite:PeSprite = getSprite("player_run_left")
			retSprite.speed = 30;
			return retSprite;
		}
		*/
		public function get idleRight():PeSprite
		{
			return getSprite("player_idle_right");
		}
		/*
		public function get idleLeft():PeSprite
		{
			return getSprite("player_idle_left");
		}
		
		public function get jumpUpRight():PeSprite
		{
			return getSprite("player_jump_up_right");
		}
		
		public function get jumpUpLeft():PeSprite
		{
			return getSprite("player_jump_up_left");
		}
		
		public function get jumpDownRight():PeSprite
		{
			return getSprite("player_jump_down_right");
		}
		
		public function get jumpDownLeft():PeSprite
		{
			return getSprite("player_jump_down_left");
		}
		
		public function get jumpAirRight():PeSprite
		{
			return getSprite("player_jump_airborne_right");
		}
		
		public function get jumpAirLeft():PeSprite
		{
			return getSprite("player_jump_airborne_left");
		}
		
		public function get defendRight():PeSprite
		{
			return getSprite("player_defend_right");
		}
		
		public function get defendLeft():PeSprite
		{
			return getSprite("player_defend_left");
		}
		
		public function get attackARight():PeSprite
		{
			return getSprite("player_attacka_right");
		}
		
		public function get attackALeft():PeSprite
		{
			return getSprite("player_attacka_left");
		}
		
		public function get attackBRight():PeSprite
		{
			return getSprite("player_attackb_right");
		}
		
		public function get attackBLeft():PeSprite
		{
			return getSprite("player_attackb_left");
		}
		
		public function get attackCRight():PeSprite
		{
			return getSprite("player_attackc_right");
		}
		
		public function get attackCLeft():PeSprite
		{
			return getSprite("player_attackc_left");
		}
		
		public function get dieRight():PeSprite
		{
			return getSprite("player_die_right");
		}
		
		public function get dieLeft():PeSprite
		{
			return getSprite("player_die_left");
		}
		
		public function get hurtARight():PeSprite
		{
			return getSprite("player_hurta_right");
		}
		
		public function get hurtALeft():PeSprite
		{
			return getSprite("player_hurta_left");
		}
		
		public function get hurtBRight():PeSprite
		{
			return getSprite("player_hurtb_right");
		}
		
		public function get hurtBLeft():PeSprite
		{
			return getSprite("player_hurtb_left");
		}
		
		public function get celebrateRight():PeSprite
		{
			return getSprite("player_celebrate_right");
		}
		
		public function get celebrateLeft():PeSprite
		{
			return getSprite("player_celebrate_left");
		}
		
		public function get powerupRight():PeSprite
		{
			return getSprite("player_powerup_right");
		}
		
		public function get powerupLeft():PeSprite
		{
			return getSprite("player_powerup_left");
		}
		
		public function get throwRight():PeSprite
		{
			return getSprite("player_throw_right");
		}
		
		public function get throwLeft():PeSprite
		{
			return getSprite("player_throw_left");
		}
		*/
	}

}