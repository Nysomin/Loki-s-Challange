package com.pyro.engine.sound
{
	/**
	 * Sound Channel class that handles channel functionaility
	 * @author Robbie Carrington Jr.
	 */
	
	/**
	import com.noteflight.standingwave3.elements.IAudioSource;
	import com.noteflight.standingwave3.generators.FadeEnvelopeGenerator;
	import com.noteflight.standingwave3.output.AudioPlayer;
	import com.noteflight.standingwave3.filters.EchoFilter;
	import com.noteflight.standingwave3.filters.PanFilter;
	import com.noteflight.standingwave3.filters.FadeInFilter;
	import com.noteflight.standingwave3.filters.FadeOutFilter;
	import com.noteflight.standingwave3.sources.SoundSource;
	*/
	import flash.media.Sound;
	
	import flash.events.Event;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import com.pyro.engine.core.IPeTicked;
	
	public class PeChannel implements IPeChannel, IPeTicked
	{
		private var _repeat:Boolean;
		private var _audioSource:Sound;
		private var _soundTransform:SoundTransform;
		private var _volume:Number;
		private var _maxFadeInVolume:Number
		private var _fadeIn:Boolean;
		private var _fadeInRate:Number;
		private var _fadeOut:Boolean;
		private var _fadeOutRate:Number;
		private var _channel:SoundChannel;
		private var _tickID:int;
		private var _isChannelNull:Boolean;
		
		public function PeChannel() 
		{
			_repeat = false;
			_audioSource = null;
			_soundTransform = null;
			_isChannelNull = true;
			_fadeIn = false;
			_fadeOut = false;
			volume = 0;
		}// end constructor method
		
		public function play(source:Object, soundVolume:Number, fadeIn:Boolean, fadeInRate:Number, fadeOut:Boolean, fadeOutRate:Number, repeatSound:Boolean):void 
		{
			_audioSource = Sound(source); // here, source is passed by reference and a copy of the reference is saved in the channel class
			_fadeIn = fadeIn;
			_fadeInRate = fadeInRate;
			_fadeOut = fadeOut;
			_fadeOutRate = fadeOutRate;
			
			_channel = _audioSource.play();
			
			repeat = repeatSound;
			volume = soundVolume;
			_isChannelNull = false;
			
			if (fadeIn)
			{
				_maxFadeInVolume = volume; // save the current volume so that the fade in will not go beyond this volume
				volume = 0.0; // set up the volume to be nothing if the sound is suppose to fade in
			}
						
			sourceChannel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler); // so that repeat can be set up
		}// end play method
		
		public function stop():void 
		{
			repeat = false;
			_channel.stop();
			_isChannelNull = true;
		}// end stop method
		
		public function get audioSource():Object
		{
			return _audioSource;
		}// end audioSource get method
		
		public function get sourceChannel():Object
		{
			return _channel;
		}// end sourceChannel get method
		
		public function get isChannelNull():Boolean 
		{
			return _isChannelNull;
		}// end isChannelNull get method
		
		public function get repeat():Boolean 
		{
			return _repeat;
		}// end get repeat method
		
		public function set repeat(value:Boolean):void 
		{
			_repeat = value;
		}// end repeat set method
		
		public function get volume():Number
		{
			return _volume;
		}// end volume get method
		
		public function set volume(value:Number):void 
		{
			_volume = value;
			
			if (_volume > 1.0) 
			{
				_volume = 1.0;
			}
			else if (_volume < 0.0) 
			{
				_volume = 0.0;
			}
			
			if (sourceChannel != null)
			{
				sourceChannel.soundTransform = new SoundTransform(_volume);
			}
		}// end volume set method
		
		private function soundCompleteHandler(e:Event):void
		{
			_isChannelNull = true;
			if (repeat) 
			{
				play(_audioSource, volume, _fadeIn, _fadeInRate, _fadeOut, _fadeOutRate, repeat);
			}
		}// end soundCompleteHandler method
		
		private function fadeIn(fadeInRate:Number):void 
		{
			volume += fadeInRate;
			
			if (volume > _maxFadeInVolume) 
			{
				volume = _maxFadeInVolume;
			}
		}// end fadeIn method
		
		private function fadeOut(fadeOutRate:Number):void 
		{
			volume -= fadeOutRate;
			
			if (volume < 0.0) 
			{
				volume = 0.0;
			}
		}// end fadeOut method
		
		public function onTick(dt:Number):void
		{
			if (_fadeIn)
			{
				fadeIn(_fadeInRate);
			}
			
			if (_fadeOut)
			{
				fadeOut(_fadeOutRate);
			}
		}// end onTick method
		
		public function get tickReady():Boolean
		{
			if (isChannelNull)
			{
				return false;
			}
			
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