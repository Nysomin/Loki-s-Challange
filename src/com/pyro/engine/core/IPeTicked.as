package com.pyro.engine.core 
{
	/**
	 * Classes that need to be ran every tick need to implament this interface
	 * 
	 * @author Leland Ede
	 */
	public interface IPeTicked 
	{
		/**
		 * Used to process code every tick that is called from the PeStageManager that has been
		 * added to the stage as a tick item using addTickObject
		 * 
		 * @param	deltaTime The amount of time (in seconds) specified for the tick
		 */
		function onTick(deltaTime:Number):void;
		
		function get tickReady():Boolean;
		
		function set tickID(id:int):void;
		function get tickID():int;
	}

}