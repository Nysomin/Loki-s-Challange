package com.pyro.engine.sound 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	import com.pyro.engine.debug.PeLogger;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import com.pyro.engine.core.IPeTicked;

	public class PeSoundItem implements IPeTicked 
	{
		private var font:Sound;
		private var channel:SoundChannel;
		private var transform:SoundTransform;
		private var tickFunction:Array;
		
		private var maxVolume:Number;
		private var fadeInRate:Number;
		
		// this has already been implemented in PeSoundEngine.as and PeChannel.as. Please use that instead as it is linked to the StandingWave3 library. - RobbieC
		
		public function PeSoundItem(sound:Class) 
		{
			transform = new SoundTransform(1, 0);
			channel = new SoundChannel();
			font = new sound() as Sound;
			tickFunction = [];
		}
		
		/**
		 * Start the sound font playing
		 * @param	start:int starting position of sound to start playing
		 * @param	repeat:int How many times do you want the sound to repeat.
		 */
		public function play(start:int = 0, repeat:int = 0):void
		{
			channel = font.play(start, repeat, transform);
		}
		
		public function playFadeIn(start:int = 0, repeat:int = 0, rate:Number = 0.01):void
		{
			fadeInRate = rate;
			transform.volume = 0.0;
			tickFunction.push(fadeId);
			play(start, repeat);
		}
		
		
		/**
		 * Change volume of sounf font
		 * 
		 * @param vol:Number 0.0 - 1.0
		 */
		public function set volume(vol:Number):void
		{
			maxVolume = 1.0;
			if (vol >= 0.0 && vol <= 1.0)
			{
				maxVolume = vol;
				transform.volume = vol;
			}// Endif check for valid voluime range
		}
		
		public function fadeId():void
		{			
			if (transform.volume < maxVolume)
			{
				transform.volume += fadeInRate;
				channel.soundTransform = transform;
			}else
			{
				// Remove function from ticks
				var idx:int = tickFunction.indexOf(fadeId);
				if (idx >= 0)
				{
					tickFunction.splice(idx, 1);
				}
			}
		}
		
		public function onTick(dt:Number):void
		{
			if (tickFunction.length > 0)
			{
				for each(var func:Function in tickFunction)
				{
					func();
				}
			}
		}
		
		public function get tickReady():Boolean
		{
			return tickFunction.length > 0;
		}
		
	}

}