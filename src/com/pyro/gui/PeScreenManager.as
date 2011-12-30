package com.pyro.gui 
{
	import com.pyro.engine.core.IPeTicked;
	import com.pyro.engine.PE;
	import data.menus.VVIntroScreen;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Jesse James Lord
	 */
	public class PeScreenManager implements IPeTicked
	{
		/*
		 * The goal of this class is to enable the behavior of switching screens by using a stack
		 * Select a particular screen
		 * Push a new screen ontop
		 * Pop the current screen off
		 * 
		 */
		//this is the PE's PeScreenManager. We only need one.
		private var _ViewManager:PeScreenManager = null;
		
		//We need a displayObject Container to hold our current screens parent screen.
		public var viewParent:DisplayObjectContainer = null;

        private var _currentView:IPeScreen = null;
        private var viewStack:Array = [null];
        private var viewDictionary:Dictionary = new Dictionary();
		private var _tickID:int;
		
		
		public function get ViewManager():PeScreenManager
		{
			if ( !_ViewManager )
				_ViewManager = new PeScreenManager();
			return _ViewManager;
		}
		
		public function registerView( viewName:String, IView:IPeScreen):void
		{
			viewDictionary[viewName] = IView;
		}
		
		public function get(viewName:String):IPeScreen
		{
			return viewDictionary[viewName];
		}
		
		private function set currentView(viewName:String):void
		{
			if ( _currentView )
			{
				_currentView.onDeactivate();
				_currentView = null;
			}
			
			if ( viewName )
			{
				_currentView = viewDictionary[viewName];
				if ( !_currentView )
					return;
				_currentView.onActive();
			}
		}
		
		//Get the currentView
		public function get CurrentView():IPeScreen
		{
			return _currentView;
		}
		
		//Do we have a screen that is called viewName?
		public function isView(viewName:String):Boolean
		{
			//Check the dictionary for the string name
			return get(viewName) != null;
		}
		
		/* INTERFACE com.pyro.engine.core.IPeTicked */
		
		public function gotoView(viewName:String):void
		{
			//Lets take this one out of the View Array
			popView();
			//Lets put the next one into the View Array
			pushView(viewName);
		}
		
		public function pushView(viewName:String):void
		{
			//This is where we add the view to the stack
			viewStack.push(viewName);
			//We set our current view to this view
			currentView = viewName;
			
			//We add this child to the stage using our dictionary
			viewParent.addChild(get(viewName) as DisplayObject);
		}
		
		public function popView():void
		{
			//This pop's off the stack the current view to review what is underneath
			//If we are already at the bottom of the stack then we have nothing to pop so do nothing.
			if ( viewStack.length == 0 )
				return;
			
			var preView:DisplayObject = get (viewStack.pop()) as DisplayObject;
			//If we pop off a view we need to set our view to the next view down in the stack so we have something to look at
			currentView = viewStack[viewStack.length - 1];
			
			//If we are attached to a parent object like the main stage sprite then remove ourselves.
			if ( preView && preView.parent)
				preView.parent.removeChild(preView);
			
		}
		
		public function onFrame(elapsedFrame:Number):void
		{
			if ( _currentView )
				_currentView.onFrame(elapsedFrame);
		}
		
		public function onTick(deltaTime:Number):void 
		{
			if ( _currentView )
				_currentView.onTick(deltaTime);
		}
		
		/* INTERFACE com.pyro.engine.core.IPeTicked */
		
		public function get tickReady():Boolean 
		{
			return false;
		}
		
		public function get tickID():int 
		{
			return _tickID;
		}
		
		public function set tickID(value:int):void 
		{
			_tickID = value;
		}
	}
}