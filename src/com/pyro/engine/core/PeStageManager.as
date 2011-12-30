package com.pyro.engine.core 
{
	/**
	 * ...
	 * @author Jesse James Lord
	 * @author Leland Ede
	 * @author Robbie Carrington Jr.
	 */
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import flash.system.System;
	
	import com.pyro.engine.core.IPeObject;
	import com.pyro.engine.objects.PePoint;
	import com.pyro.engine.debug.PeLogger;

	public class PeStageManager extends PeGroup implements IPeGroups
	{
		//We will have the stage manager extend the PeGroup so that it can add and remove objects
		//This class is in charge of :
		/*
		 * Adding objects to the stage 
		 * Removing an object from the stage
		 * Tracking Layers
		 * Add event handlers for the following list
		 * Event.ENTER_FRAME
		 * Keyboard Events
		 * Event.ACTIVE
		 * Event.DEACTIVE
		 * 
		 * Goal is to glue all of the pieces of the engine together and allow us to manage it in one center location
		 * May need to create an interface class to implemnt in our other classes for the game engine.
		*/
		
		private var grpIdx:String = "StageManager";
		private var currStage:Stage;
		
		// Tick manager
		private var tickedObjects:Array;
		private var lastIterator:int;			// Last iterator processed in array
		private var lastTicks:int;
		private var timer:Timer;
		
		private var frameFunction:Array;
		private var objArray:Array;
		
		private var guiLayer:Sprite;
		private var gameLayer:Sprite;
		private var _sprite:Sprite;
		
		private var _debug:Boolean;
		
		public function PeStageManager(gStage:Stage) 
		{
			currStage = gStage; // add the stage that is passed to the object of the class
			objArray = [];
			tickedObjects = [];
			clearObjectList();
			lastIterator = 0;
			_sprite = new Sprite();
			guiLayer = new Sprite();
			gameLayer = new Sprite();
			_sprite.addChild(gameLayer);
			_sprite.addChild(guiLayer);
			_debug = false;
			//Globals etc.
		}// End constructor
		
		public function addObject(obj:IPeObject):Boolean
		{
			var tmpBool:Boolean = true;
			tmpBool = super.add(obj);
			obj.layer = objArray.length;
			obj.parent = gameLayer;
			if (obj.sprite == null)
			{
				throw("Can't add null object to the game stage.");
			}
			gameLayer.addChild(obj.sprite); // add the child to the stage
			objArray.push(obj);
			makeGuiTop();
			return tmpBool;
		}// End methid addObject
		
		public function clearObjectList():void
		{
			frameFunction = [];
			objArray = [];
		}
		
		public function clearTickList():void
		{
			tickedObjects = [];
		}
		
		public function addGuiObject(obj:Sprite):void
		{
			if (obj != null)
			{
				guiLayer.addChild(obj);
			}
			makeGuiTop();
		}
		
		public function removeObject(obj:IPeObject):Boolean
		{
			var tmpBool:Boolean = false;
			if (objArray[obj.layer] != null)
			{
				tmpBool = true;
				gameLayer.removeChild(IPeObject(objArray[obj.layer]).sprite);
				objArray[obj.layer] = null;
			}// Endif objectg is not null
			
			
			return tmpBool;
		}// End method removeObject
		
		private function makeGuiTop():void
		{
			if (_sprite.getChildIndex(guiLayer) < _sprite.getChildIndex(gameLayer))
			{
				_sprite.swapChildren(guiLayer, currStage);
			}
		}
		
		public function removeGuiObject(obj:Sprite):Boolean
		{
			var retBool:Boolean = false;
			if (guiLayer.contains(obj))
			{
				guiLayer.removeChild(obj);
			}
			
			return retBool;
		}
		
		override public function get sprite():Sprite 
		{
			return _sprite;
		}
		
		public function addFrameEvent(func:Function):void
		{
			frameFunction.push(func);
		}
		
		public function removeFrameEvent(func:Function):void
		{
			var idx:int = frameFunction.indexOf(func);
			if ( idx != -1)
			{
				frameFunction.splice(idx, 1);
			}
		}
		
		public function get group():PeGroup
		{
			// Return objects group information
			return super;
		}// End method get group
		
		public function set debug(value:Boolean):void 
		{
			_debug = value;
		}
		
		public function getobjArray():Array 
		{
			return objArray;
		}
		
		public override function move(pos:PePoint):void
		{
			for (var i:int = 0; i < length; i++)
			{
				IPeObject(getObject(i)).move(pos);
			}
		}
		
		override public function onFrame(e:Event):void 
		{
			// Check to see if we have any pre frame functions that need to run
			if (frameFunction.length > 0)
			{
				// Loop through all pre frame render options
				for each(var func:Function in frameFunction)
				{
					if (func != null)
					{
						func(e);
					}// Endif null check
				}// End for i loop for fameFunctions
			}// Endif frameFunction length greater than zero
			
			// Run IPeObjects onFrame event
			for each(var obj:IPeObject in objArray)
			{
				if (obj != null)
				{
					obj.onFrame(e);
				}
			}
			if (PeLogger.getInstance.debugState)
			{
				trace(objArray);
			}
			//flash.system.System.gc();
		}// End method onFrame
		
		/**
		 * Add object to tick event array
		 * 
		 * @param	object
		 */
		public function addTickObject(object:IPeTicked):int
		{
			if (timer == null)
			{
				setupTimer();
			}
			var idx:int = tickedObjects.length;
			object.tickID = idx;
			tickedObjects.push(object);
			return idx;
		}
		
		public function removeTickObject(idx:int):void
		{
			if (tickedObjects[idx] != null)
			{
				tickedObjects.splice(idx, 1);
				for (var i:int = idx; i < tickedObjects.length; i++)
				{
					IPeTicked(tickedObjects[i]).tickID = idx;
				}
			}
		}
		
		/**
		 * Setup game timer and start the event listener
		 * 
		 * Change the frequency of the tick event in PeWorkd class but be careful to not set it to high or low
		 */
		public function setupTimer():void
		{
			//var timer:Timer = new Timer(PeWorld.TICK_STEP, 0);
			// Create timer event
			timer = new Timer(PeWorld.TICK, 0);
			// Add event handler to the timer
			timer.addEventListener(TimerEvent.TIMER, onTicked);
			// Initialize the lastTicks variable
			lastTicks = getTimer();
			// Start timer
			timer.start();
			// Add garbage collerctor the game
			addTickObject(new PeGarbage());
		}// End method setupTimer
		
		/**
		 * Process the tick event array. May add some optimization stuff to this method
		 * so that it can try and scale based on each items tick amount
		 * 
		 * @param	e
		 */
		public function onTicked(e:TimerEvent):void
		{
			var deltaTime:Number = 0;
			var time:int = getTimer();

			for (var i:int = lastIterator; i < tickedObjects.length; i++)
			{
				// Check to see if tick is ready to run again
				if (IPeTicked(tickedObjects[i]).tickReady)
				{
					deltaTime = (getTimer() - lastTicks) / (1000 / 60);
					IPeTicked(tickedObjects[i]).onTick(deltaTime);
				}// Endif tickReady
				if (getTimer() - time > 9)
				{
					lastIterator = i;
					break;
				}
				lastIterator = 0;
			}
			lastTicks = getTimer();
		}// End method onTicked
	}

}