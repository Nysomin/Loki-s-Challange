package com.pyro.engine.resource 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.display.Loader;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.net.URLLoaderDataFormat;
	
	/**
	 * ...
	 * @author Jesse James Lord
	 */
	public class PeResource extends EventDispatcher
	{
		//Variables that the class object needs to know about
		protected var _filename:String = null;
        private var _isLoaded:Boolean = false;
        private var _didFail:Boolean = false;
        private var _loader:Loader;
		private var _urlLoader:URLLoader;
		
		//Object class that holds object methods to be used by a Resource Manager
		//Load event
		[Event(name = "LOAD_EVENT", type = "com.pyro.engine.resource.PeResourceEvent")]
		
		//Fail Load event
		[Event(name = "FAIL_EVENT", type = "com.pyro.engine.resource.PeResourceEvent")]
		
		//Things that this resource needs to be able to do
		/*
		 * Get/Set filename
		 * Check to see if it is already loaded
		 * Check to see if it failed
		 * 
		 * Load a resource
		 * Initialize a resource
		 * Fail out
		 * 
		 * When load is complete
		 * When load Fails
		 */
		
		public function get filename():String
		{
			return _filename;
		}
		
		public function set filename(param:String):void
		{
			//make sure you can only set the filename once
			if (_filename != null )
				return;
			
			_filename = param;
		}
		
		//Need to be able to get the loader in case of something
		protected function get resourceLoader():Loader
		{
			return _loader;
		}
		
		public function load(param:String):void
		{
			_filename = param;
			
			var objLoader:URLLoader = new URLLoader();
			objLoader.dataFormat = URLLoaderDataFormat.BINARY;
			objLoader.addEventListener(Event.COMPLETE, onDownloadComplete);
			objLoader.addEventListener(IOErrorEvent.IO_ERROR, onDownloadError);
			
			var objRequest:URLRequest = new URLRequest();
			objRequest.url = param;
			objLoader.load(objRequest);
			
			//Reference the loader in case we need it for something later
			_urlLoader = objLoader;
		}
		
		//Use the * data type so that it can polymorph to our needs
		public function initialize(param:*):void
		{
			//if the data is not a ByteArray then htis is not needed
			if (!(param is ByteArray))
				return;
			var objLoader:Loader = new Loader();
			objLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			objLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onDownloadError);
			objLoader.loadBytes(param);
			
			//Keep the reference to the loader on this object
			_loader = objLoader;
		}
		
		public function fail():void
		{
			onFailed();
		}
		
		protected function onContentReady(content:*):Boolean
        {
            return false;
        }
		
		protected function onLoadComplete( evt:Event = null ):void
		{
			//If the event is exists return content otherwise return null
			if ( onContentReady( evt ? evt.target.content : null ))
			{
				_isLoaded = true;
				_urlLoader = null;
				_loader = null;
				dispatchEvent(new PeResourceEvent(PeResourceEvent.LOAD_EVENT, this));
				return;
			}
		}
		
        protected function onFailed():void
        {
			//We failed to load the resource so mark it as failed and remove references
            _isLoaded = true;
            _didFail = true;
            dispatchEvent(new PeResourceEvent(PeResourceEvent.FAIL_EVENT, this));
            
			//Clean up the loaders
            _urlLoader = null;
            _loader = null;
        }
		
		//If the download is compelte then initialize the data
		private function onDownloadComplete(evt:Event):void
        {
            var data:ByteArray = ((evt.target) as URLLoader).data as ByteArray;
            initialize(data);
        }
		
		//If the download failed report that it failed
		private function onDownloadError(event:IOErrorEvent):void
        {
            onFailed();
        }
		
		public function get isLoaded():Boolean
        {
            return _isLoaded;
        }
	}
}