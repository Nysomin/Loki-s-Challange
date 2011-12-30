package com.pyro.engine.resource 
{
	import flash.media.Sound;
	/**
	 * ...
	 * @author Jesse James Lord
	 */
	
	 //The only type of sound that we have in our game is all encoded in mp3 so just leave it as mp3 here.
	[EditorData(extensions = "mp3")]
	
	public class PeSoundResource extends PeResource
	{
		//Create the object to hold the sound resource
		protected var _soundHolder:Sound = null;
		
		//Provide a get method to get the sound file object later
		public function get soundObject() : Sound
		{
			return _soundHolder;
		}
		
		//When the sound file is initilized store it here using the * type so we get the full object
		override public function initialize(d:*):void
		{
			_soundHolder = d;
			onLoadComplete();
		}
		
		override protected function onContentReady(content:*):Boolean
		{
			//When the load is complete send the soundobject
			//back as requested as long as it is not null.
			return soundObject != null;
		}
	}

}