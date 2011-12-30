package com.pyro.engine.resource 
{
	import com.pblabs.engine.resource.provider.IResourceProvider;
	import com.pyro.engine.PE;
	import com.pyro.engine.resource.PeResource;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Jesse James Lord
	 */
	public class BaseResourceProvider implements IResourceProvider
	{
		protected var _ResDictionary:Dictionary;
		
        public function BaseResourceProvider()
        {
			//Create our resource dicationary
			_ResDictionary = new Dictionary();
		}
		
		public function getResource(fResName:String, fResType:Class)
		{
			//When using the dictionary we will just add the resoucename to the resource type
            var mResName:String = fResName.toLowerCase() + fResType;
            return _ResDictionary[mResName];
		}
		
		public function unloadResource(fResName:String, fResType:Class):PeResource
		{
			var mResName:String = fResName.toLowerCase() + fResType;
			
			//Lets check to see if the dictionary resource name is present or not
			if ( _ResDictionary[mResName] != null )
			{
				_ResDictionary[mResName].dispose();
				_ResDictionary[mResName] = null;
			}
		}
		
		protected function addResource(fResName:String, fResType:Class, fResource:PeResource):void
		{
			var mResName:String = fResName.toLowerCase() + fResType;
			_ResDictionary[mResName] = fResource;
		}
		
	}
}