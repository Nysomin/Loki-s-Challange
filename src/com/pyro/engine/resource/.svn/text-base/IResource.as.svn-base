package com.pyro.engine.resource 
{
	/**
	 * ...
	 * @author Jesse James Lord
	 */
	public interface IResource
	{
		//This is our sort for the resourceProvider Class.
		//These are how we desdinguish resource objects.
		//It also will allow us to 
		//Add a resource, get a resource, see if we already have it, unload a resource.
		
		function getResource(resName:String, resType:Class):PeResource;
		
		function unloadResource(resName:String, resType:Class):void;
		
		function hasResource(resName:String, resType:Class):Boolean;
		
		function addResource(resName:String, resType:Class, resource:PeResource):Boolean;
	}

}