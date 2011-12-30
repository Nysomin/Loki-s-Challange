package com.pyro.engine.sound 
{
	/**
	 * ...
	 * @author Robbie Carrington Jr.
	 */
	
	import flash.events.Event;
	
	public class PeEnvironmentSystem 
	{
		private static var _allow:Boolean;
		private static var _instance:PeEnvironmentSystem;
		private var _maxVolume:Number;
		private var _audioSources:Array;
		private var _playingPercentage:Array;
		
		public function PeEnvironmentSystem() 
		{
			if (!_allow)
			{
				throw("ERROR: Not allowed to instantiate class directly use the getInstance method.");
			}
			
			_audioSources = new Array();
			_playingPercentage = new Array();
			_maxVolume = 0.07;
			PeSoundEngine.getInstance.playSound("light_wind", true); // play light wind sound constantly
			PeSoundEngine.getInstance.setVolume("light_wind", _maxVolume);
		}
		
		public static function get getInstance():PeEnvironmentSystem
		{
			if (_instance == null)
			{
				_allow = true;
				_instance = new PeEnvironmentSystem();
				_allow = false;
			}
			return _instance;
		}// End method getInstance
		
		public function addSound(name:String, percentage:Number):void 
		{
			_audioSources.push(name);
			_playingPercentage.push(percentage);
		}
		
		public function beginPlayingRandomSounds():void 
		{
			var tmpRandSound:Number = Math.floor(Math.random() * _audioSources.length);
			
			var randChannel:Number = PeSoundEngine.getInstance.playSound(_audioSources[tmpRandSound]);
			PeSoundEngine.getInstance.setVolume(_audioSources[tmpRandSound], _maxVolume);
			
			var tmpRandNum:Number = Math.floor(Math.random() * 10) + 1;
			
			switch (_playingPercentage[tmpRandSound]) // set volume to zero if the number found is not equal to certain numbers
			{
				case 0.0:
					PeSoundEngine.getInstance.setVolume(_audioSources[tmpRandSound], 0.0);
				break;
				
				case 0.1:
					if (tmpRandNum != 1) 
					{
						PeSoundEngine.getInstance.setVolume(_audioSources[tmpRandSound], 0.0);
					}
				break;
				
				case 0.2:
					if (tmpRandNum != 1 && tmpRandNum != 10) 
					{
						PeSoundEngine.getInstance.setVolume(_audioSources[tmpRandSound], 0.0);
					}
				break;
				
				case 0.3:
					if (tmpRandNum != 1 && tmpRandNum != 10 && tmpRandNum != 2) 
					{
						PeSoundEngine.getInstance.setVolume(_audioSources[tmpRandSound], 0.0);
					}
				break;
				
				case 0.4:
					if (tmpRandNum != 1 && tmpRandNum != 10 && tmpRandNum != 2 && tmpRandNum != 9) 
					{
						PeSoundEngine.getInstance.setVolume(_audioSources[tmpRandSound], 0.0);
					}
				break;
				
				case 0.5:
					if (tmpRandNum != 1 && tmpRandNum != 10 && tmpRandNum != 2 && tmpRandNum != 9 && tmpRandNum != 3) 
					{
						PeSoundEngine.getInstance.setVolume(_audioSources[tmpRandSound], 0.0);
					}
				break;
				
				case 0.6:
					if (tmpRandNum != 1 && tmpRandNum != 10 && tmpRandNum != 2 && tmpRandNum != 9 && tmpRandNum != 3 && tmpRandNum != 8) 
					{
						PeSoundEngine.getInstance.setVolume(_audioSources[tmpRandSound], 0.0);
					}
				break;
				
				case 0.7:
					if (tmpRandNum != 1 && tmpRandNum != 10 && tmpRandNum != 2 && tmpRandNum != 9 && tmpRandNum != 3 && tmpRandNum != 8 && tmpRandNum != 4) 
					{
						PeSoundEngine.getInstance.setVolume(_audioSources[tmpRandSound], 0.0);
					}
				break;
				
				case 0.8:
					if (tmpRandNum != 1 && tmpRandNum != 10 && tmpRandNum != 2 && tmpRandNum != 9 && tmpRandNum != 3 && tmpRandNum != 8 && tmpRandNum != 4 && tmpRandNum != 7) 
					{
						PeSoundEngine.getInstance.setVolume(_audioSources[tmpRandSound], 0.0);
					}
				break;
				
				case 0.9:
					if (tmpRandNum != 1 && tmpRandNum != 10 && tmpRandNum != 2 && tmpRandNum != 9 && tmpRandNum != 3 && tmpRandNum != 8 && tmpRandNum != 4 && tmpRandNum != 7 && tmpRandNum != 5) 
					{
						PeSoundEngine.getInstance.setVolume(_audioSources[tmpRandSound], 0.0);
					}
				break;
				
				default:
					// do nothing
				break;
			}
			
			PeSoundEngine.getInstance.getChannel(randChannel).sourceChannel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
		}//end playRandomNatureSound method
		
		private function soundCompleteHandler(e:Event):void
		{
			beginPlayingRandomSounds();
		}//end natureSoundCompleteHandler	
	}

}