package data.characters.Medium
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

	public class PeMediumData extends SpriteLoader //implements IPeCharacteraData
	{
		// Embed the datasheet that stores sprite locaiton
		[Embed(source="PeMediumData.txt", mimeType = "application/octet-stream")]
		public static const spriteData:Class;
		// Embed sprite sheet image
		[Embed(source="PeMediumData.png")]
		public static const spriteImage:Class;
		private static var allow:Boolean = false;
		
		//private var sMachine:PeMediumStateMachine;
		
		public function PeMediumData(inStage:Sprite) 
		{
			var file:ByteArray;
			var fileData:String;
			
			file = new PeMediumData.spriteData();
			fileData = file.readUTFBytes(file.length);
			
			// Load sprite sheet
			super(fileData, spriteImage, inStage);
		}
		
		
		public function get runRight():PeSprite
		{
			var retSprite:PeSprite = getSprite("medium_run_right")
			retSprite.speed = 45;
			return retSprite;
		}
		
		public function get runLeft():PeSprite
		{
			var retSprite:PeSprite = getSprite("medium_run_left")
			retSprite.speed = 30;
			return retSprite;
		}
		
		public function get idleRight():PeSprite
		{
			return getSprite("medium_idle_right");
		}
		
		public function get idleLeft():PeSprite
		{
			return getSprite("medium_idle_left");
		}
		
		public function get jumpUpRight():PeSprite
		{
			return getSprite("medium_jump_up_right");
		}
		
		public function get jumpUpLeft():PeSprite
		{
			return getSprite("medium_jump_up_left");
		}
		
		public function get jumpDownRight():PeSprite
		{
			return getSprite("medium_jump_down_right");
		}
		
		public function get jumpDownLeft():PeSprite
		{
			return getSprite("medium_jump_down_left");
		}
		
		public function get jumpAirRight():PeSprite
		{
			return getSprite("medium_jump_airborne_right");
		}
		
		public function get jumpAirLeft():PeSprite
		{
			return getSprite("medium_jump_airborne_left");
		}
		
		public function get defendRight():PeSprite
		{
			return getSprite("medium_defend_right");
		}
		
		public function get defendLeft():PeSprite
		{
			return getSprite("medium_defend_left");
		}
		
		public function get attackARight():PeSprite
		{
			return getSprite("medium_attack_right");
		}
		
		public function get attackALeft():PeSprite
		{
			return getSprite("medium_attack_left");
		}
		
		public function get attackBRight():PeSprite
		{
			return getSprite("medium_attackb_right");
		}
		
		public function get attackBLeft():PeSprite
		{
			return getSprite("medium_attackb_left");
		}
		
		public function get attackCRight():PeSprite
		{
			return getSprite("medium_attackc_right");
		}
		
		public function get attackCLeft():PeSprite
		{
			return getSprite("medium_attackc_left");
		}
		
		public function get dieRight():PeSprite
		{
			return getSprite("medium_die_right");
		}
		
		public function get dieLeft():PeSprite
		{
			return getSprite("medium_die_left");
		}
		
		public function get hurtARight():PeSprite
		{
			return getSprite("medium_hurta_right");
		}
		
		public function get hurtALeft():PeSprite
		{
			return getSprite("medium_hurta_left");
		}
		
		public function get hurtBRight():PeSprite
		{
			return getSprite("medium_hurtb_right");
		}
		
		public function get hurtBLeft():PeSprite
		{
			return getSprite("medium_hurtb_left");
		}
		
		public function get celebrateRight():PeSprite
		{
			return getSprite("medium_celebrate_right");
		}
		
		public function get celebrateLeft():PeSprite
		{
			return getSprite("medium_celebrate_left");
		}
		
		public function get powerupRight():PeSprite
		{
			return getSprite("medium_powerup_right");
		}
		
		public function get powerupLeft():PeSprite
		{
			return getSprite("medium_powerup_left");
		}
		
		public function get throwRight():PeSprite
		{
			return getSprite("medium_throw_right");
		}
		
		public function get throwLeft():PeSprite
		{
			return getSprite("medium_throw_left");
		}
		
	}

}