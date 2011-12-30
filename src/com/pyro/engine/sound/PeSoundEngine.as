package com.pyro.engine.sound
{
	/**
	 * The Pyro Sound Engine using the StandingWave3 library
	 * @author Robbie Carrington Jr.
	 */
	
	// audio engine imports
	//import com.noteflight.standingwave3.elements.IAudioFilter;
	//import com.noteflight.standingwave3.elements.IAudioSource;
	import com.pyro.engine.core.IPeTicked;
	//import com.noteflight.standingwave3.filters.EchoFilter;
	//import com.noteflight.standingwave3.filters.FadeInFilter;
	//import com.noteflight.standingwave3.filters.FadeOutFilter;
	//import com.noteflight.standingwave3.filters.GainFilter;
	//import com.noteflight.standingwave3.filters.PanFilter;
	//import com.noteflight.standingwave3.performance.AudioPerformer;
	//import com.noteflight.standingwave3.performance.IPerformance;
	//import com.noteflight.standingwave3.performance.ListPerformance;
	//import com.noteflight.standingwave3.sources.SoundSource;
	
	// standard imports
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;

	//PeLogger Import -MarkP
	import com.pyro.engine.debug.PeLogger;
		
	public class PeSoundEngine extends SoundData implements IPeTicked 
	{
		private static var _instance:PeSoundEngine;
		private static var _allow:Boolean;
		private var _channels:Array;
		private var _sounds:Array;
		private var _sndVolume:Number;
		private var _randSoundChan:int = -1;
		private var _tickID:int;
		private const MAX_SOUND_CHANNELS:int = 32;
		// http://help.adobe.com/en_US/flex/using/WS2db454920e96a9e51e63e3d11c0bf60546-7ff2.html - useful info on how to to embed
		
		// soundChans refers to the maximum number of sound channels that can play at once
		public function PeSoundEngine() 
		{
			if (!_allow)
			{
				throw("ERROR: Not allowed to instantiate class directly use the getInstance method.");
			}
			
			// initialize all the players
			_channels = new Array(MAX_SOUND_CHANNELS);
			for (var i:int = 0; i < MAX_SOUND_CHANNELS; i++) 
			{
				_channels[i] = new PeChannel();
			}
			
			_sounds = new Array(); // intialize the Sound class array
			
			loadSounds(); // load all the sounds defined
			setGlobalVolume(0.05); // set global maximum volume
			//PeLogger.getInstance.log("Sound Engine intialized");
		}//end PeSoundEngine method
		
		public static function get getInstance():PeSoundEngine
		{
			if (_instance == null)
			{
				_allow = true;
				_instance = new PeSoundEngine();
				_allow = false;
			}
			return _instance;
		}// End method getInstance
		
		public function getChannel(index:int):Object 
		{
			return _channels[index];
		}// end getChannel method
		
		// load all sounds. They must be declared here. Also, DO NOT change what index a sound is loaded in or else the rest of the code will not work.
		private function loadSounds():void
	    {
			// load all the sounds
			_sounds.push(new attack_block as Sound); // index 0
			_sounds.push(new attack_hit as Sound); // index 1
			_sounds.push(new attack_miss as Sound); // index 2
			_sounds.push(new player_hit as Sound); // index 3
			_sounds.push(new player_powerup as Sound); // index 4
			_sounds.push(new player_footsteps as Sound); // index 5
			_sounds.push(new andersonMode as Sound); // index 6
			_sounds.push(new birds as Sound); // index 7
			_sounds.push(new light_wind as Sound); // index 8
			_sounds.push(new heavy_wind as Sound); // index 9
			_sounds.push(new wind_howl as Sound); // index 10
			_sounds.push(new music_intro as Sound); // index 11
			_sounds.push(new music_gameOver as Sound); // index 12
			_sounds.push(new lvlOne_music as Sound); // index 13
			_sounds.push(new lvlOne_boss as Sound); // index 14
			_sounds.push(new lvlTwo_music as Sound); // index 15
			_sounds.push(new lvlTwo_boss as Sound); // index 16
			_sounds.push(new lvlThree_music as Sound); // index 17
			_sounds.push(new lvlThree_boss as Sound); // index 18
			_sounds.push(new lvlFour_music as Sound); // index 19
			_sounds.push(new lvlFour_boss as Sound); // index 20
			_sounds.push(new shopMode as Sound); // index 21
			_sounds.push(new cautionayTale as Sound); // index 22
			_sounds.push(new strangeNews as Sound); // index 23
	    }//end loadSounds method

		public function playSound(name:String, repeat:Boolean = false, fadeIn:Boolean = false, fadeOut:Boolean = false, fadeInTime:Number = 0.01, fadeOutTime:Number = 0.01):int
		{
			
			switch (name.toLocaleLowerCase()) 
			{
				case "attack_block": // attack is blocked
					return playSoundFile(0, fadeIn, fadeInTime, fadeOut, fadeOutTime, repeat);
				break;
				
				case "attack_hit": // attack hits target
					return playSoundFile(1, fadeIn, fadeInTime, fadeOut, fadeOutTime, repeat);
				break;
				
				case "attack_miss": // attack is missed
					return playSoundFile(2, fadeIn, fadeInTime, fadeOut, fadeOutTime, repeat);
				break;
				
				case "player_hit": // player is hit
					return playSoundFile(3, fadeIn, fadeInTime, fadeOut, fadeOutTime, repeat);
				break;
				
				case "player_powerup": // player recieves power up sound
					return playSoundFile(4, fadeIn, fadeInTime, fadeOut, fadeOutTime, repeat);
				break;
				
				case "player_footsteps": // player walking
					return playSoundFile(5, fadeIn, fadeInTime, fadeOut, fadeOutTime, repeat);
				break;
				
				case "andersonmode": // cheat mode alarm sound
					return playSoundFile(6, fadeIn, fadeInTime, fadeOut, fadeOutTime, repeat);
				break;
				
				case "birds": // birds in nature
					return playSoundFile(7, fadeIn, fadeInTime, fadeOut, fadeOutTime, repeat);
				break;
				
				case "light_wind": // light wind in nature
					return playSoundFile(8, fadeIn, fadeInTime, fadeOut, fadeOutTime, repeat);
				break;
				
				case "heavy_wind": // heavy wind in nature
					return playSoundFile(9, fadeIn, fadeInTime, fadeOut, fadeOutTime, repeat);
				break;
				
				case "wind_howl": // wind howling in nature
					return playSoundFile(10, fadeIn, fadeInTime, fadeOut, fadeOutTime, repeat);
				break;
				
				case "intro": // music menu intro
					return playSoundFile(11, fadeIn, fadeInTime, fadeOut, fadeOutTime, repeat);
				break;
				
				case "game_over": // music menu game over
					return playSoundFile(12, fadeIn, fadeInTime, fadeOut, fadeOutTime, repeat);
				break;
				
				case "lvlone": // Level one music
					return playSoundFile(13, fadeIn, fadeInTime, fadeOut, fadeOutTime, repeat);
				break;
				
				case "lvlone_boss": // Level one boss music
					return playSoundFile(14, fadeIn, fadeInTime, fadeOut, fadeOutTime, repeat);
				break;
				
				case "lvltwo": // Level two music
					return playSoundFile(15, fadeIn, fadeInTime, fadeOut, fadeOutTime, repeat);
				break;
				
				case "lvltwo_boss": // Level two boss music
					return playSoundFile(16, fadeIn, fadeInTime, fadeOut, fadeOutTime, repeat);
				break;
				
				case "lvlthree": // Level three music
					return playSoundFile(17, fadeIn, fadeInTime, fadeOut, fadeOutTime, repeat);
				break;
				
				case "lvlthree_boss": // Level three boss music
					return playSoundFile(18, fadeIn, fadeInTime, fadeOut, fadeOutTime, repeat);
				break;
				
				case "lvlfour": // Level four music
					return playSoundFile(19, fadeIn, fadeInTime, fadeOut, fadeOutTime, repeat);
				break;
				
				case "lvlfour_boss": // Level four boss music
					return playSoundFile(20, fadeIn, fadeInTime, fadeOut, fadeOutTime, repeat);
				break;
				
				case "shopMode": // shop mode
					return playSoundFile(21, fadeIn, fadeInTime, fadeOut, fadeOutTime, repeat);
				break;
				
				case "cautionayTale": // Cautionay Tale (story part)
					return playSoundFile(22, fadeIn, fadeInTime, fadeOut, fadeOutTime, repeat);
				break;
				
				case "strangeNews": // Strange News (story)
					return playSoundFile(23, fadeIn, fadeInTime, fadeOut, fadeOutTime, repeat);
				break;
				
				default: // return -1 if sound is not recongized
					return -1;
				break;
			}
		}//end playSound method
		
		public function setGlobalVolume(amount:Number):void // range is 0.0 for mute to 1.0 for full volume
		{
			// make sure amount is in the range of 0.0 to 1.0
			if (amount < 0.0) 
			{
				amount = 0.0;
			}
			else if (amount > 1.0) 
			{
				amount = 1.0;
			}
			
			_sndVolume = amount;
			//_sndVolume = new SoundTransform(amount);
			for (var i:int = 0; i < MAX_SOUND_CHANNELS; i++) 
			{
				if (_channels[i].audioSource != null) 
				{	
					_channels[i].volume = amount;;
				}
			}
		}//end setGlobalVolume method
		
		public function stopSound(name:String):void 
		{
			switch (name.toLocaleLowerCase()) 
			{
				case "attack_block": // attack_block is index 0
					for (var i:int = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[0])
						{
							_channels[i].stop();
						}
					}
				break;
				
				case "attack_hit": // attack_hit is index 1
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[1])
						{
							_channels[i].stop();
						}
					}
				break;
				
				case "attack_miss": // attack_miss is index 2
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[2])
						{
							_channels[i].stop();
						}
					}
				break;
				
				case "player_hit": // player_hit is index 3
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[3])
						{
							_channels[i].stop();
						}
					}
				break;
				
				case "player_powerup": // player_PowerUp is index 4
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[4])
						{
							_channels[i].stop();
						}
					}
				break;
				
				case "player_footsteps": // player_footsteps is index 5
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[5])
						{
							_channels[i].stop();						
						}
					}
				break;
				
				case "andersonmode": // andersonmode is index 6
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[6])
						{
							_channels[i].stop();
						}
					}
				break;
				
				case "birds": // birds is index 7
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[7])
						{
							_channels[i].stop();
						}
					}
				break;
				
				case "light_wind": // light_wind is index 8
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[8])
						{
							_channels[i].stop();
						}
					}
				break;
				
				case "heavy_wind": // heavy_wind is index 9
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[9])
						{
							_channels[i].stop();
						}
					}
				break;
				
				case "wind_howl": // wind_howl is index 10
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[10])
						{
							_channels[i].stop();
						}
					}
				break;
				
				case "intro": // intro is index 11
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[11]) 
						{
							_channels[i].stop();
						}
					}
				break;
				
				case "game_over": // lvlone is index 12
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[12])
						{
							_channels[i].stop();						
						}
					}
				break;
				
				case "lvlone": // lvlone is index 13
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[13])
						{
							_channels[i].stop();
						}
					}
				break;
				
				case "lvlone_boss": // lvlone_boss is index 14
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[14])
						{
							_channels[i].stop();
						}
					}
				break;
				
				case "lvltwo": // Level two music
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[15])
						{
							_channels[i].stop();
						}
					}
				break;
				
				case "lvltwo_boss": // Level two boss music
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[16])
						{
							_channels[i].stop();
						}
					}				
				break;
				
				case "lvlthree": // Level three music
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[17])
						{
							_channels[i].stop();
						}
					}
				break;
				
				case "lvlthree_boss": // Level three boss music
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[18])
						{
							_channels[i].stop();
						}
					}
				break;
				
				case "lvlfour": // Level four music
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[19])
						{
							_channels[i].stop();
						}
					}
				break;
				
				case "lvlfour_boss": // Level four boss music
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[20])
						{
							_channels[i].stop();
						}
					}				
				break;
				
				case "shopMode": // shop mode
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[21])
						{
							_channels[i].stop();
						}
					}
				break;
				
				case "cautionayTale": // Cautionay Tale (story part)
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[22])
						{
							_channels[i].stop();
						}
					}
				break;
				
				case "strangeNews": // Strange News (story)
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[23])
						{
							_channels[i].stop();
						}
					}
				break;
				
				default: // do nothing if not found
					return;
				break;
			}
		}// end stopSound method
		
		public function setVolume(name:String, amount:Number):void // name is the name of the sound file defined here and amount is the range. range is 0.0 for mute to 1.0 for full volume
		{
			// make sure amount is in the range of 0.0 to 1.0
			if (amount < 0.0) 
			{
				amount = 0.0;
			}
			else if (amount > 1.0) 
			{
				amount = 1.0;
			}
			
			switch (name.toLocaleLowerCase()) 
			{
				case "attack_block": // attack_block is index 0
					for (var i:int = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[0])
						{
							_channels[i].volume = amount;
						}
					}
				break;
				
				case "attack_hit": // attack_hit is index 1
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[1])
						{
							_channels[i].volume = amount;
						}
					}
				break;
				
				case "attack_miss": // attack_miss is index 2
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[2])
						{
							_channels[i].volume = amount;
						}
					}
				break;
				
				case "player_hit": // player_hit is index 3
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[3])
						{
							_channels[i].volume = amount;
						}
					}
				break;
				
				case "player_powerup": // player_PowerUp is index 4
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[4])
						{
							_channels[i].volume = amount;
						}
					}
				break;
				
				case "player_footsteps": // player_PowerUp is index 5
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[5])
						{
							_channels[i].volume = amount;
						}
					}
				break;
				
				case "andersonmode": // andersonmode is index 6
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[6])
						{
							_channels[i].volume = amount;
						}
					}
				break;

				
				case "birds": // birds is index 7
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[7])
						{
							_channels[i].volume = amount;
						}
					}
				break;
				
				case "light_wind": // light_wind is index 8
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[8])
						{
							_channels[i].volume = amount;
						}
					}
				break;
				
				case "heavy_wind": // heavy_wind is index 9
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[9])
						{
							_channels[i].volume = amount;
						}
					}
				break;
				
				case "wind_howl": // wind_howl is index 10
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[10]) 
						{
							_channels[i].volume = amount;
						}
					}
				break;
				
				case "intro": // intro is index 11
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[11]) 
						{
							_channels[i].volume = amount;
						}
					}
				break;
				
				case "game_over": // game_over is index 12
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[12])
						{
							_channels[i].volume = amount;
						}
					}
				break;
				
				case "lvlone": // lvlone is index 13
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[13])
						{
							_channels[i].volume = amount;
						}
					}
				break;
				
				case "lvlone_boss": // lvlone is index 14
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[14])
						{
							_channels[i].volume = amount;
						}
					}
				break;
				
				case "lvltwo": // Level two music
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[15])
						{
							_channels[i].volume = amount;
						}
					}
				break;
				
				case "lvltwo_boss": // Level two boss music
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[16])
						{
							_channels[i].volume = amount;
						}
					}				
				break;
				
				case "lvlthree": // Level three music
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[17])
						{
							_channels[i].volume = amount;
						}
					}
				break;
				
				case "lvlthree_boss": // Level three boss music
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[18])
						{
							_channels[i].volume = amount;
						}
					}
				break;
				
				case "lvlfour": // Level four music
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[19])
						{
							_channels[i].volume = amount;
						}
					}
				break;
				
				case "lvlfour_boss": // Level four boss music
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[20])
						{
							_channels[i].volume = amount;
						}
					}				
				break;
				
				case "shopMode": // shop mode
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[21])
						{
							_channels[i].volume = amount;
						}
					}
				break;
				
				case "cautionayTale": // Cautionay Tale (story part)
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[22])
						{
							_channels[i].volume = amount;
						}
					}
				break;
				
				case "strangeNews": // Strange News (story)
					for (i = 0; i < MAX_SOUND_CHANNELS; i++) 
					{
						if (_channels[i].audioSource == _sounds[23])
						{
							_channels[i].volume = amount;
						}
					}
				break;
				
				default: // do nothing if not found
					return;
				break;
			}
		}//end setVolume method
		
		//Play a sound file. Index refers to the sound file that is loaded in the array. Pan should be between -1.0 (left) to 1.0 (right). Echo is false if no echo, true if one should be applied.
		private function playSoundFile(index:int, fadeIn:Boolean, fadeInTime:Number, fadeOut:Boolean, fadeOutTime:Number, repeat:Boolean):int
		{
			var sndIdx:int = -1;
			if (index < 0) // ensure that the index is not below 0
			{
				return sndIdx;
			}

			for (var i:int = 0; i < MAX_SOUND_CHANNELS; i++) 
			{
				if (_channels[i].isChannelNull) 
				{
					_channels[i].play(_sounds[index], _sndVolume, fadeIn, fadeInTime, fadeOut, fadeOutTime, repeat);
					sndIdx = i;
					break;
				}	
			}
			return sndIdx;
		}//end playSoundFile method
		
		public function onTick(dt:Number):void
		{
			for (var i:int = 0; i < MAX_SOUND_CHANNELS; i++) 
			{
				if (_channels[i].tickReady)
				{	
					_channels[i].onTick(dt);
				}
			}
		}// end onTick method
		
		public function get tickReady():Boolean
		{
			return true;
		}// end tickReady get method
		
		public function get tickID():int 
		{
			return _tickID;
		}// end tickID get method
		
		public function set tickID(value:int):void 
		{
			_tickID = value;
		}// end tickID set method
	}

}