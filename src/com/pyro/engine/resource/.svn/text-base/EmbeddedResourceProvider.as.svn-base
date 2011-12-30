package com.pyro.engine.resource 
{
	/**
	 * ...
	 * @author Jesse James Lord
	 */
	public class EmbeddedResourceProvider extends BaseResourceProvider
	{
		//Our embedded resource object needs
		private static var _EmbObject:EmbeddedResourceProvider = null;
		
		public static function get embObject():EmbeddedResourceProvider
		{
			if ( !embObject )
				_EmbObject = new EmbeddedResourceProvider();
			
			return _EmbObject;
		}
		
		//On create call the BaseResourceProviders constructor.
		public function EmbeddedResourceProvider()
		{
			super();
		}
		
		
		//We want to record this resource so get the name resource class type and the data
		public function recordResource( objName:String, resType:Class, pData:*):void
		{
			//Lets make our generic dictionary string for resources
			var resString:String = objName.toLowerCase() + resType;
			
			//If the resource is already registered just quit out
			if ( _ResDictionary[resString] )
				return;
				
			var resObject:PeResource = new resType();
			resObject.filename = objName;
			resObject.initialize(data);
			
			//Register this new resource in the dictionary
			_ResDictionary[resString] = resObject;
		}
	}
	
	public function unloadResource(fResName:String, fResType:Class):PeResource
	{
		//If its embedded, we can't unload it so don't bother trying
	}
}