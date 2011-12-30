package com.pyro.engine.core 
{
	import com.pyro.engine.objects.PePoint;
	import flash.events.Event;
	/**
	 * ...
	 * @author Leland Ede
	 */
	public interface IPeController 
	{
		/**
		 * Register a onFrame function for keys
		 * 
		 * @param	code - Key Code
		 * @param	func - Function to run when processing
		 */
		function addKeyEvent(code:int, func:Function):void;
		
		/**
		 * Register a function when a key is pressed
		 * 
		 * @param	code - Key Code
		 * @param	func - Function to run when pressed
		 */
		function addKeyPress(code:int, func:Function):void;
		
		/**
		 * Regiswter a function to run when all keys have been released
		 * 
		 * @param	func - Function to process
		 */
		function addKeyUpEvent(func:Function):void;
		
		/**
		 * Frame event handler for game engine
		 * @param	e - Event class
		 */
		function onFrame(e:Event):void;
		
		function set gamePos(pos:PePoint):void;
		
		function addKeyPressUp(code:int, func:Function):void;
		
		function set layer(idx:int):void;
		
		function get layer():int;
	}

}