package com.pyro.engine.resource 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Jesse James Lord
	 */
	public class PeResourceEvent extends Event
	{
		//Create the base event class so we know when we were sucessfull or failed
		//Successful Load
		public static const LOAD_EVENT:String = "LOAD_EVENT";
		//Fail Load
		public static const FAIL_EVENT:String = "FAIL_EVENT";
		
		//We need to be do a composite relationship with the PeResource object
		//so lets store an object here
		public var resHolder:PeResource = null;
		
		public function PeResourceEvent( file:String, object:PeResource, bubbles:Boolean=false, cancelable:Boolean=false )
		{
			//First lets set the resholder to the object
			resHolder = object;
			
			//Then we do a super to put the file, bubbles and cancelable
			super(file, bubbles, cancelable);
		}
	}
}