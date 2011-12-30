package com.pyro.engine.resource 
{
	import com.noteflight.standingwave3.elements.IRandomAccessSource;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Jesse James Lord
	 */
	public class PeResourceManager
	{
        //Create a Dictionary to hold the loaded resources by 2D array [resource name, type]         
        private var _resources:Dictionary = new Dictionary();
        private var resProviders:Array = new Array();
		
		//This class is suppose to manage the resources, and cleanup for those resources
		public function load( file:String, resType:Class, onLoaded:Function = null, onFailed:Function = null, forceReload:Boolean = false):PeResource
		{
			//if there is no file then just stope now
			if ( file == null || file == "")
				return null;
				
			//Lets look up the resource in question 
			var resName:String = file.toLocaleLowerCase() + resType;
			var res:PeResource = _resources[resName]; //Now we have made a suto resource and placed it in the dictionary
			
			//If our resource does not exsist yet lets make it
			if ( !res )
			{
				//First lets get the extention so we know what to do with it.
				var extIndex:Number = file.lastIndexOf(".");
			    if (extIndex == -1)
				{
					//If we get a -1 that means there was no . so we don't have anything to load
					return null;
				}
				else
				{
					var fileExt:String = file.substr(extIndex + 1,file.length);
				}
				
				for ( var i:int = 0; i < resProviders.length; i++ )
				{
					if (( resProviders[i] as IResource).hasResource(file, resType))
						res = (resProviders[i] as IResource).getResource(file, resType);
				}
				
				if ( !res.filename)
					res.filename = file;
				//Lets assign it in there
				_resources[resName] = res;
			}
			else if ( !( res is PeResource ) )
			{
				//this means that we didn't have a resource type at all.
				return null;
			}
			
			//if the load is finished then
			if ( onLoaded != null )
				res.addEventListener( PeResourceEvent.LOAD_EVENT, function (evt:Event):void 
				{
					onLoaded(res);
				}
				);
			if ( onFailed != null )
				res.addEventListener( PeResourceEvent.FAIL_EVENT, function (evt:Event):void
				{
					onFailed(res);
				}
				);
			
			return res;
		}
		
		public function unload( objName:String, resType:Class):void
		{
			//Setup our default dictionary name
			var resName:String = objName.toLowerCase() + resType;
			
			if ( !_resources[resName] )
				return;
			
			if ( _resources[resName] == null )
			{
				//then we don't have a resource to unload
			}
			else
			{
				for ( var i:int = 0; i < resProviders.length; i++ )
				{
					if ( (resProviders[i] as IResource).hasResource(objName, resType) )
					{
						(resProviders[i] as IResource).unloadResource(objName, resType);
					}
				}
			}
		}
		
		public function registerResourceProvider(resObject:IResource):void
		{
			//if the res object is already registered then there is no reason to reregister it
			if ( resProviders.indexOf(resObject) != -1 )
			{
				return;
			}
			
			//Otherwise lets add it
			resProviders.push(resObject);
		}
		
		public function isLoaded(objName:String, resType:Class):Boolean
		{
			var resName:String = objName.toLowerCase() + resType;
			if ( !_resources[resName] ) 
			{
				return false;
			}
			
			//Else lets load the specify the resouce and run the onLoaded method.
			var resObject:PeResource = _resources[objName];
			return resObject.isLoaded;
		}
		
		public function getResource( objName:String, resType:Class):PeResource
		{
			//Assemble our dictionary name for the resource object
			var resName:String = objName.toLowerCase() + resType;
			return _resources[resName];
		}
		
		public function fail(res:PeResource, onFailed:Function, message:String):void
		{
			//onFailed, [res]);
		}
	}
}