package com.pyro.engine.core.stateMachines 
{
	/**
	 * ...
	 * @author Leland Ede
	 * @author Robbie Carrington Jr.
	 */
	
	import com.pyro.engine.core.IPeObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	 
	import com.pyro.engine.gfx2d.sprites.PeSprite;

	public class PePlayerStateMachine 
	{
		
		private var _idle:String;
		private var states:Array;
		private var curStage:Stage;
		private var currState:String;
		private var prevState:String;
		
		public function PePlayerStateMachine(gStage:Stage)
		{
			// set the stage being used
			curStage = gStage;
			states = new Array();
		}
		
		public function set idle(idx:String):void
		{
			if (states.indexOf(idx) == -1)
			{
				_idle = idx;
			}
		}
		
		public function get idle():String
		{
			return _idle;
		}
		
		public function getState():PeSprite
		{
			var cSprite:PeSprite = states[_idle];
			if (states.indexOf(currState) > -1)
			{
				cSprite = states[currState];
			}
			return cSprite;
		}
		
		public function addState(key:String, stSprite:PeSprite):Boolean
		{
			var retVal:Boolean = false;
			
			if (states.indexOf(key) == -1)
			{
				states[key] = stSprite;
			}
			
			return retVal;
		}
		
		public function set state(key:String):void
		{
			var chk:PeSprite = null;
			if (states.indexOf(key) && key == _idle)
			{
				if (states.indexOf(currState) > -1)
				{
					chk = states[currState];
					// Remove event listener from sprite
					chk.removeEventListener(Event.ENTER_FRAME, chk.onFrame);
					chk.parent.removeChild(chk);
				}
				
				prevState = currState;
				currState = key;
				chk = states[currState];
				chk.addEventListener(Event.ENTER_FRAME, chk.onFrame);
			}
			else if(states.indexOf(key))
			{
				//if (states.indexOf(currState) > -1)
				//{
					//chk = states[currState];
					// Remove event listener from sprite
					
					//chk.parent.removeChild(chk);
				//}
				
				prevState = currState;
				currState = key;
				chk = states[currState];
				/* Removed code from usage since we need to handle keyboard input throught he character controller. -Leland
				 * 
				if (key.toLowerCase().indexOf("right") > -1) 
				{
					chk.checkForKeyDown(68); // pass the key code for the "d" key to the function
				}
				else if (key.toLowerCase().indexOf("left") > -1) 
				{
					chk.checkForKeyDown(65); // pass the key code for the "a" key to the function
				}*/
				
			}
		}
		
		public function clearObject(obj:IPeObject):void
		{
			//obj.parent.removeChild(obj);
		}
		
		public function onTick(e:EventTick):void
		{
			
		}
	}

}