package data.sound 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	import flash.media.Sound;
	import flash.media.SoundTransform;

	import com.pyro.engine.core.IPeTicked;
	import com.pyro.engine.sound.IPeSound;
	import com.pyro.engine.sound.PeSoundItem;
	
	// already implemented in the SoundData.as class - RobbieC
	// also, I got a java heap space error when I was trying to compile this with it included in the theGameTest.as. - RobbieC

	public class SoundLoader implements IPeTicked, IPeSound
	{
		[Embed(source = "attack_block.mp3")]
		public static const attack_block:Class;
		
		[Embed(source = "attack_hit.mp3")]
		public static const attack_hit:Class;
		
		[Embed(source = "attack_miss.mp3")]
		public static const attack_miss:Class;
		
		[Embed(source = "player_hit.mp3")]
		public static const player_hit:Class;
		
		[Embed(source = "player_powerup.mp3")]
		public static const player_powerup:Class;
		
		[Embed(source = "birds027.mp3")]
		public static const birds:Class;
		
		[Embed(source = "nature003.mp3")]
		public static const light_wind:Class;
		
		[Embed(source = "nature008.mp3")]
		public static const heavy_wind:Class;
		
		[Embed(source = "thunder3.mp3")]
		public static const thunder3:Class;
		
		public var soundFonts:Array;
		public var tickFunctions:Array;
		
		public function SoundLoader() 
		{
			soundFonts = [];
			tickFunctions = [];
			soundFonts["attack"] = [];
			soundFonts["attack"]["block"]		= new PeSoundItem(attack_block);
			soundFonts["attack"]["hit"]			= new PeSoundItem(attack_hit);
			soundFonts["attack"]["miss"]		= new PeSoundItem(attack_miss);
			soundFonts["player"] = [];
			soundFonts["player"]["hit"]			= new PeSoundItem(player_hit);
			soundFonts["player"]["powerup"]		= new PeSoundItem(player_powerup);
			soundFonts["nature"] = [];
			soundFonts["nature"]["birds"]		= new PeSoundItem(birds);
			soundFonts["nature"]["lightwind"]	= new PeSoundItem(light_wind);
			soundFonts["nature"]["heavywind"]	= new PeSoundItem(heavy_wind);
			soundFonts["nature"]["thunder"]		= new PeSoundItem(thunder3);
			
			tickFunctions.push(soundFonts["attack"]["block"]);
			tickFunctions.push(soundFonts["attack"]["hit"]);
			tickFunctions.push(soundFonts["attack"]["miss"]);
			tickFunctions.push(soundFonts["player"]["hit"]);
			tickFunctions.push(soundFonts["player"]["powerup"]);
			tickFunctions.push(soundFonts["nature"]["birds"]);
			tickFunctions.push(soundFonts["nature"]["lightwind"]);
			tickFunctions.push(soundFonts["nature"]["heavywind"]);
		}
		
		public function getFont(collection:String, sound:String):PeSoundItem
		{
			var font:PeSoundItem = null;
			if (soundFonts[collection] != null)
			{
				if (soundFonts[collection][sound] is PeSoundItem)
				{
					font = PeSoundItem(soundFonts[collection][sound]);
				}// Endif sound exists
			}// Endif collection exists
			
			return font;
		}
		
		public function onTick(dt:Number):void
		{
			if (tickFunctions.length > 0)
			{
				for each(var snd:PeSoundItem in tickFunctions)
				{
					if (snd.tickReady) snd.onTick(dt);
				}
			}
		}
		
		public function get tickReady():Boolean
		{
			var retBool:Boolean = false;
			if (tickFunctions.length > 0)
			{
				for each(var snd:PeSoundItem in tickFunctions)
				{
					if (snd.tickReady) retBool = true;
				}
			}			
			return retBool;
		}
	}

}