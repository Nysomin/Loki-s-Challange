package 
{
	
	/**
	 * @author Jesse Lord
	 * @author Leland Ede
	 * @author Mark Petro
	 */
	// Flash Imports
	import com.bit101.components.NumericStepper;
	import com.pyro.engine.ai.PeArcherAI;
	import com.pyro.engine.ai.PeMonsterAI;
	import com.pyro.engine.character.CharacterEvent;
	import com.pyro.engine.character.PeLock;
	import com.pyro.engine.gfx2d.layers.SpawnEvent;
	import com.pyro.engine.gfx2d.MapLoader;
	import com.pyro.engine.physics.CollisionEvent;
	import data.GUI.PlayerHUD;
	import data.menus.VVBaseView;
	import data.menus.VVCredits;
	import data.menus.VVIntroScreen;
	import data.menus.VVMenu;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.ui.Keyboard;
	
	// Pyro engine linrary
	import com.pyro.engine.PE;
	import com.pyro.engine.objects.basicSprite;
	import com.pyro.engine.debug.PeLogger;
	import com.pyro.engine.core.PeFPS;
	import com.pyro.engine.objects.PePoint;
	import com.pyro.engine.gfx2d.EventMap;
	import com.pyro.engine.gfx2d.sprites.SpriteArray;
	import com.pyro.engine.sound.PeSoundEngine;
	import com.pyro.engine.sound.PeEnvironmentSystem;
	import com.pyro.engine.debug.SWFProfiler;
	import com.pyro.engine.core.InputController;

	// Game data
	import data.levels.demoLvl.PeDemoLevel;
	import data.levels.lvlOne.PeLevelOne;
	import data.levels.lvlTwo.PeLevelTwo;
	import data.levels.lvlThree.PeLevelThree;
	
	//EXPERIMENTAL PePlayer imports
	import com.pyro.engine.character.PeCharacter;
	import com.pyro.engine.character.PePlayer;
	import com.pyro.engine.character.PeMonster;

	import data.characters.EventChar;
	import data.characters.PeCharFactory;
	import data.sound.SoundLoader;

	
	[SWF(width = "800", height = "600", frameRate = "60")]
	[Frame(factoryClass="Preloader")]
	public class theGameTest extends Sprite 
	{
		public static var game:PE;
		private var gameLvl:MapLoader;
		private var levelArray:Array;
		private var currLevel:int;
		private var hud:PlayerHUD;
		private var guiSprite:Sprite = new Sprite();
		public static var GameLoaded:Boolean = false;
		
		//private var soundEngine:PeSoundEngine;
		
		//EXPERIMENAL Player Character Test
		private var _Player:PeCharacter;
		public static var _charbuilder:PeCharFactory;
		//private var sndFont:SoundLoader;
		
	
		public function theGameTest():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			currLevel = 0;
			levelArray = [];
			levelArray.push(PeLevelOne);
			levelArray.push(PeLevelTwo);
			levelArray.push(PeLevelThree);
			levelArray.push(PeDemoLevel);
			// Game creation should be the first thing we do
			game = new PE(this.stage, this);
			
			//GUI Manager happens after the game PE class hase been instantiated.
			if (game.ViewManager != null)
			{
				//Hook the onFrame and OnTick methods up for use with the GUI System.
				game.stageManager.addFrameEvent(game.ViewManager.onFrame);
				game.stageManager.addTickObject(game.ViewManager);
				
				game.ViewManager.viewParent = guiSprite;
				
				game.stageManager.addGuiObject(guiSprite);
				
				//setup our initial registered screens
				game.ViewManager.registerView("VVCredits", new VVCredits());
				//game.ViewManager.registerView("VVMenu", new VVMenu());
				game.ViewManager.registerView("VVIntroScreen", new VVIntroScreen());
				//This sets our base gui view to the main sprite field
				//game.ViewManager.gotoView("VVBaseGame");
				//This pushes a view ontop of our main gui view
				//game.ViewManager.pushView("VVMenu");
				game.ViewManager.pushView("VVIntroScreen");
			}
			game.stageManager.addTickObject(PeSoundEngine.getInstance);
			PeEnvironmentSystem.getInstance.addSound("birds", 0.2);
			PeEnvironmentSystem.getInstance.addSound("heavy_wind", 0.3);
			PeEnvironmentSystem.getInstance.addSound("wind_howl", 0.2);
			PeEnvironmentSystem.getInstance.beginPlayingRandomSounds();
			//game.stageManager.addTickObject(sndFont);
			theGameTest._charbuilder = new PeCharFactory(); //constructs all chracter data for use
			theGameTest._charbuilder.addEventListener(EventChar.LOAD_COMPLETE, onCharLoad);
			theGameTest._charbuilder.init();
		}
		
		public function onCharLoad(e:EventChar):void
		{
			/*************************************************************EXPERIMENTAL PePlayer creation*********************************************************************
			 *
			 * Here he are loading up all characters with their correct starting data,
			 * both sprites and statistics.
			 * For now the monsters are just created to test out memory usage,
			 * but will be added later on with a spawn layer from the current level.
			 * 
			 */
			_charbuilder.removeEventListener(EventChar.LOAD_COMPLETE, onCharLoad);
			PeLogger.getInstance.log("Make a player");
			_Player = new PeCharacter("Player"); //Creates shell new character as a player
			hud = new PlayerHUD();
			hud.graph = _charbuilder.fillHUD();
			hud.startHUD();
			hud.init("Player HUD");
			game.stageManager.addGuiObject(hud.sprite);
			_Player = _charbuilder.makeCharacter(new PePoint(0,0,0), "player"); //fills is stats for character type of "player"
			_Player.init("Player");
			_Player.rightBoundry = 400;
			_Player.leftBoundry = 50;
			_Player.controller = game.inputManager;
			_Player.world = game.gameWorld;
			_Player.stats.updateExp = hud.expereince;
			_Player.stats.updateLevel = hud.setLevel;
			_Player.stats.updatePotions = hud.setPotions;
			_Player.stats.updateLife = hud.life;
			_Player.addEventListener(CharacterEvent.REMOVE_CHARACTER, respawnPlayer);
			_Player.projAxe = _charbuilder.fillAxe();
			game.gameWorld.playerPosition = _Player.stats.pos;
			// Tie player to keyboard controller
			
			initGameLevel();
		}
		
		private function respawnPlayer(e:CharacterEvent):void 
		{
			_Player.stats.life = _Player.stats.maxLife;
			_Player.stats.pos = gameLvl.playerData.playerPos;
		}
		
		public function onLoad(e:EventMap):void
		{
			PeLogger.getInstance.log("Level Loaded: " + currLevel);
			gameLvl.removeEventListener(EventMap.LOAD_COMPLETE, onLoad);
			game.stageManager.addObject(gameLvl);
			gameLvl.world = game.gameWorld;
			gameLvl.stageManager = game.stageManager;
			// Setup player
			_Player.stats.pos = gameLvl.playerData.playerPos;
			_Player.moveMap = gameLvl.move;
			_Player.spawner = gameLvl.spawnData.addPlayerProjectile;
			gameLvl.spawnData.player = _Player;
			gameLvl.spawnData.lifePotion = _charbuilder.fillPotion();
			gameLvl.charbuilder = _charbuilder;
			gameLvl.playerData.addObject(_Player);
			game.start();
		}
				
		public function onClose(e:Event):void
		{
			PeLogger.getInstance.log("<--Closing game engine-->");
		}

		private function closeLevel(e:Event):void
		{
			if (gameLvl != null)
			{
				game.stop();
				game.stageManager.debug = true;
				game.stageManager.removeObject(gameLvl);
				game.stageManager.clearObjectList();
				gameLvl.destroy();
				gameLvl = null;
				_Player.moveMap = null;
				_Player.spawner = null;
				_Player.stats.pos = null;
				_Player.stats.life = _Player.stats.maxLife;
				System.gc();
				initGameLevel();
			}
		}
			
		public function loadNextLevel(e:EventMap):void
		{
			// Try and see if this prevents the event listener from firing more than once
			gameLvl.removeEventListener(EventMap.AT_RIGHT_SIDE, loadNextLevel);
			currLevel++;
			closeLevel(e);
		}
		
		private function initGameLevel():void
		{
			if (levelArray.length > currLevel)
			{
				gameLvl = new levelArray[currLevel](game.curSprite);
				gameLvl.addEventListener(EventMap.LOAD_COMPLETE, onLoad);
				gameLvl.addEventListener(EventMap.AT_RIGHT_SIDE, loadNextLevel);
				gameLvl.init("Level " + currLevel);
			}else
			{
				this.graphics.beginFill(0x000000, 1);
				this.graphics.drawRect(0, 0, 800, 600);
				this.graphics.endFill();
				game.stageManager.addFrameEvent(game.ViewManager.onFrame);
				game.ViewManager.pushView("VVCredits");
				game.start();
			}
		}
		
	}
	
}