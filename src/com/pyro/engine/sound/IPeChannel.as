package com.pyro.engine.sound 
{
	/**
	 * ...
	 * @author Robbie Carrington Jr.
	 */
	
	import flash.media.SoundChannel;
	import flash.events.Event;
	 
	public interface IPeChannel 
	{
		
		function play(source:Object, soundVolume:Number, fadeIn:Boolean, fadeInTime:Number, fadeOut:Boolean, fadeOutTime:Number, repeatSound:Boolean):void;
		
		function stop():void;
		
		function onTick(dt:Number):void;
		
		function get audioSource():Object;

		function get sourceChannel():Object;
		
		function get isChannelNull():Boolean;
		
		function get repeat():Boolean;
		
		function set repeat(value:Boolean):void;
		
		function get volume():Number;
		
		function set volume(value:Number):void;
		
		function get tickReady():Boolean;

	}

}