package com.pyro.gui 
{
	
	/**
	 * ...
	 * @author Jesse James Lord
	 */
	//We need to be able to put things on the screen when the following conditions happen
	/*
	 * onActive -so we can add things or make an animation play
	 * onDeactive - so we can clean it up so there isn't too much in memory
	 * onFrame - If we want something to be checked perhaps mouse position
	 * onTick - If we want something to be checked at a particluar tick rate
	 */
	public interface IPeScreen
	{
		function onActive():void;
		
		function onDeactivate():void;
		
		function onFrame(delta:Number):void;
		
		function onTick(delta:Number):void;
	}
}