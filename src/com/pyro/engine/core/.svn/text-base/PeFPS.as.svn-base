package com.pyro.engine.core 
{
	/**
	 * Frame Per Second class which also calulates out the deltaTime.
	 * @author Leland Ede
	 */
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.text.TextField;
	import flash.utils.getTimer;
	
	import com.pyro.engine.debug.PeLogger;
	
	public class PeFPS extends EventDispatcher implements IPeTicked
	{
		// Used to create a singleton class
		private static var instance:PeFPS;
		private static var allow:Boolean = false;
		
		// Frames Per Second variables
		private var _fps:int;
		private var calcfps:int;
		private var startTime:int;
		
		// Used to display the FPS on screen
		private var cStage:Sprite;
		private var dspFps:TextField;
		private var isStaged:Boolean;
		
		// Used to calclulate the FPS
		private var dStartTime:int;
		private var _deltaTime:Number;
		
		private var _tickID:int;
		
		// Used to check if FPS is ready
		private var _isReady:Boolean;
		
		public function PeFPS() 
		{
			if (!allow)
			{
				throw("ERROR: Not allowed to instantiate class directly use the getInstance method.");
			}
			
			_fps = 60;
			calcfps = 0;
			startTime = 0;
			startTime = getTimer();
			isStaged = false;
			setupField();
			_isReady = false;
		}
		
		public static function get getInstance():PeFPS
		{
			if (instance == null)
			{
				allow = true;
				instance = new PeFPS();
				allow = false;
			}
			return instance;
		}
		
		public function onFrame(e:Event):void
		{
			var elapTime:int = getTimer() - startTime;

			// Calculate the deltaTime
			var gamefps:int = _fps;
			if (isNaN(_fps))
			{
				gamefps = 60	
			}
			var constTime:Number = 1000 / gamefps;
			_deltaTime = constTime / (getTimer() - dStartTime)
			dStartTime = getTimer();
			// Check limit of deltaTime and smooth it out
			if (_deltaTime > 1.2 || _deltaTime < 0.8)
			{
				_deltaTime = 1.0;
			}

			// Increament the frame
			calcfps++;
			if (elapTime > 1000)
			{
				_fps = calcfps;
				calcfps = 0;
				startTime = getTimer();
				if (isStaged) 
				{
					dspFps.text = _fps.toString();
				}
				if (false == isReady && _fps > 15)
				{
					_isReady = true;
					dispatchEvent(new PeFPSEvent(PeFPSEvent.READY));
				}
				if(isReady)
					PeLogger.getInstance.log(_fps.toString());
			}
		}
		
		public function onTick(time:Number):void
		{
			// This gets called every tick so we need to figure out how to calculate the FPS from this call
		}
		
		public function setupField():void
		{
			dspFps = new TextField();
			dspFps.width = 30;
			dspFps.height = 20;
			dspFps.x = 10;
			dspFps.y = 10;
			dspFps.background = true;
			dspFps.backgroundColor = 0xffffff;
		}
		
		public function get fps():int
		{
			var fpsPost:int = _fps;
			if (false == isReady)
			{
				fpsPost = 0;
			}
			return _fps;
		}
		
		public function displayFPS():void
		{
			if (cStage != null)
			{
				setupField();
				isStaged = true;
				dspFps.text = _fps.toString();
				cStage.addChildAt(dspFps, cStage.numChildren);
				PeLogger.getInstance.log("Added FPS to stage");
			}
		}
		
		public function removeFPS():void
		{
			if (cStage != null)
			{
				cStage.removeChild(dspFps);
				isStaged = false;
			}
		}
		
		public function set stage(stg:Sprite):void
		{
			cStage = stg;
		}
		
		public function get deltaTime():Number
		{
			return _deltaTime;
		}
		
		public function get isReady():Boolean 
		{
			return _isReady;
		}
		
		public function get tickReady():Boolean
		{
			return true;
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