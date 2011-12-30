package com.pyro.engine.sound 
{
	/**
	 * Holds all the sound files' data
	 * @author Robbie Carrington Jr.
	 */
	public class SoundData
	{
		[Embed(source = "../../../../data/sound/attack_block.mp3")]
		public static var attack_block:Class;
		
		[Embed(source = "../../../../data/sound/attack_hit.mp3")]
		public static var attack_hit:Class;
		
		[Embed(source = "../../../../data/sound/attack_miss.mp3")]
		public static var attack_miss:Class;
		
		[Embed(source = "../../../../data/sound/player_hit.mp3")]
		public static var player_hit:Class;
		
		[Embed(source = "../../../../data/sound/player_powerup.mp3")]
		public static var player_powerup:Class;
		
		[Embed(source = "../../../../data/sound/player_footsteps.mp3")]
		public static var player_footsteps:Class;
		
		[Embed(source = "../../../../data/sound/birds027.mp3")]
		public static var birds:Class;
		
		[Embed(source = "../../../../data/sound/nature003.mp3")]
		public static var light_wind:Class;
		
		[Embed(source = "../../../../data/sound/nature008.mp3")]
		public static var heavy_wind:Class;
		
		[Embed(source = '../../../../data/sound/nature_windhowl001.mp3')]
		public static var wind_howl:Class;
		
		[Embed(source = "../../../../data/sound/music/IntroMenu3.mp3")]
		public static var music_intro:Class;
		
		[Embed(source = "../../../../data/sound/music/EndOfGame3.mp3")]
		public static var music_gameOver:Class;
		
		[Embed(source = '../../../../data/sound/music/Graveyard3.mp3')]
		public static var lvlOne_music:Class;
		
		[Embed(source = '../../../../data/sound/music/BossViking.mp3')]
		public static var lvlOne_boss:Class;
		
		[Embed(source = '../../../../data/sound/music/SunriseBeach3.mp3')]
		public static var lvlTwo_music:Class;
		
		[Embed(source = '../../../../data/sound/music/BossPirate3.mp3')]
		public static var lvlTwo_boss:Class;
		
		[Embed(source = '../../../../data/sound/music/FightOnBoatAtSea.mp3')]
		public static var lvlThree_music:Class;
		
		[Embed(source = '../../../../data/sound/music/BossButtercup3.mp3')]
		public static var lvlThree_boss:Class;
		
		[Embed(source = '../../../../data/sound/music/FortSeige3.mp3')]
		public static var lvlFour_music:Class;
		
		[Embed(source = '../../../../data/sound/music/MainBoss3.mp3')]
		public static var lvlFour_boss:Class;

		[Embed(source = '../../../../data/sound/andersonmode.mp3')]
		public static var andersonMode:Class;
		
		[Embed(source = '../../../../data/sound/music/ShopMode3.mp3')]
		public static var shopMode:Class;
		
		[Embed(source = '../../../../data/sound/music/CautionayTale3.mp3')]
		public static var cautionayTale:Class;
		
		[Embed(source = '../../../../data/sound/music/StrangeNews3.mp3')]
		public static var strangeNews:Class;
		
		public function SoundData() 
		{
			
		}
		
	}

}