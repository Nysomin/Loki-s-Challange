package com.pyro.engine 
{
	
	/**
	 * PyroEngine - Core controller for the game conponents
	 * 
	 * @author Leland Ede
	 * @author Robbie Carrington Jr.
	 */
	import com.pyro.gui.PeScreenManager;
	import flash.display.Stage;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.KeyLocation;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;

	import com.pyro.engine.core.PeStageManager;
	import com.pyro.engine.gfx2d.sprites.PeSprite;
	import com.pyro.engine.objects.PePoint;
	import com.pyro.engine.core.PeFPS;
	import com.pyro.engine.core.PeFPSEvent;
	import com.pyro.engine.core.PeWorld;
	import com.pyro.engine.debug.PeLogger;
	import com.pyro.engine.debug.SWFProfiler;
	
	//**************EXPERIMENTAL PLAYER IMPORTS********************
	import com.pyro.engine.character.PePlayer;
	import com.pyro.engine.core.InputController;
	
	public class PE
	{
		// Create link to main stage for game
		private var gStage:Stage;
		// Create a link to the main sprite for the game
		private var gSprite:Sprite;
		// Create stage manager class to handle all graphic type of things
		private var _StageManager:PeStageManager;
		private var _ViewManager:PeScreenManager;
		// Check to see if game is ready to start and FPS is calculating at full stream
		private var startGame:Boolean;
		private var _showDebug:Boolean;
		// Create an input manager for engin
		private var _inputManager:InputController;
		private var _gameWorld:PeWorld;
		private var overlay:Sprite;
		
		//******************EXPERIMENTAL PLAYER VARIABLES*********************
		private var mainPlayer:PePlayer;
		private var mainInput:InputController;		
		private var keyAction:String;
		
		public function PE(inStage:Stage, curSprite:Sprite):void
		{
			SWFProfiler.init(inStage, curSprite);
			// Store the stage information in private variable
			gStage = inStage;
			gSprite = curSprite;
			// Instantiate our stage manager
			_StageManager = new PeStageManager(gStage);
			_StageManager.parent = curSprite;
			
			// Instantiate our gui manager
			_ViewManager = new PeScreenManager();
			
			keyAction = "idle";
			
			gStage.addEventListener(Event.ENTER_FRAME, PeFPS.getInstance.onFrame);
			PeFPS.getInstance.addEventListener(PeFPSEvent.READY, onReady);
			PeFPS.getInstance.stage = curSprite;
			startFPS();
			// Create input manager object
			_inputManager = new InputController(gStage);
			
			startGame = false;
			_showDebug = true;
			_inputManager.addKeyPress(Keyboard.F1, showDebug);
			_inputManager.addKeyPress(Keyboard.TAB, onLogger);
			_gameWorld = new PeWorld();
		}// End constructor
		
		public function onLogger(e:Event):void 
		{
			PeLogger.getInstance.debugState = !PeLogger.getInstance.debugState;
			if (PeLogger.getInstance.debugState)
			{
				PeLogger.getInstance.log("Loggin is on");
			}
		}
		
		public function startFPS():void
		{
			_StageManager.addTickObject(PeFPS.getInstance);
		}
		
		private function onReady(e:PeFPSEvent):void 
		{
			if (true == startGame)
			{
				start();
			}// Endif start game check
		}// End onReady event handler
		
		public function get gameStage():Stage
		{
			// Return game stage
			return gStage;
		}// End method get stage
		
		public function get curSprite():Sprite
		{
			return gSprite;
		}
		
		public function get stageManager():PeStageManager
		{
			return _StageManager;
		}// End method get stageManager
		
		public function get inputManager():InputController
		{
			return _inputManager;
		}

		public function start():void
		{
			// Check to see if FPS is ready and deltaTime is properly getting calilated
			if (!PeFPS.getInstance.isReady)
			{
				startGame = true;
			}else
			{
				gStage.addChild(stageManager.sprite);
				
				// Add stage manager event listener
				PeLogger.getInstance.log("<---Game Engine starting--->");
				stageManager.addFrameEvent(_inputManager.onFrame);
				gStage.addEventListener(Event.ENTER_FRAME, stageManager.onFrame);
				gStage.addEventListener(Event.DEACTIVATE, onOutFocus);
				gStage.addEventListener(Event.ACTIVATE, onInFocus);
			}// Endif PeFPS is ready check
		}// End method start
		
		public function stop():void
		{
			gStage.removeChild(stageManager.sprite);
			stageManager.removeFrameEvent(_inputManager.onFrame);
			gStage.removeEventListener(Event.ENTER_FRAME, stageManager.onFrame);
			gStage.removeEventListener(Event.DEACTIVATE, onOutFocus);
			gStage.removeEventListener(Event.ACTIVATE, onInFocus);
			
		}
		
		private function onInFocus(e:Event):void 
		{
			if (overlay != null)
			{
				gStage.removeChild(overlay);
				overlay = null;
			}// Endif overlay is not null
			gStage.addEventListener(Event.ENTER_FRAME, stageManager.onFrame);
		}
		
		private function onOutFocus(e:Event):void 
		{
			overlay = new Sprite();
			overlay.graphics.beginFill(0x000000, .3);
			overlay.graphics.drawRect(0, 0, 800, 600);
			overlay.graphics.endFill();
			gStage.addChild(overlay);
			gStage.removeEventListener(Event.ENTER_FRAME, stageManager.onFrame);
		}
		
		//****************EXPERIMENTAL PLAYER FUNCTIONS**********************
		
		public function get player():PePlayer 
		{
			return mainPlayer;
		}
		
		public function get gameWorld():PeWorld 
		{
			return _gameWorld;
		}
		
		public function get ViewManager():PeScreenManager 
		{
			return _ViewManager;
		}
		
		public function showDebug(e:Event):void
		{
			if (_showDebug)
			{
				SWFProfiler.show();
			}else
			{
				SWFProfiler.hide();
			}
			_showDebug = !_showDebug;
		}
		
		public function destroy():void
		{
			_StageManager.removeTickObject(PeFPS.getInstance.tickID);
		}
		
	}
}