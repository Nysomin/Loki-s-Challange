package data.menus 
{
	import com.pyro.engine.sound.PeEnvironmentSystem;
	import com.pyro.gui.PeBaseScreen;
	import data.characters.EventChar;
	import data.characters.PeCharFactory;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.display.Graphics;
	
	/**
	 * ...
	 * @author Jesse James Lord
	 */
	public class VVIntroScreen extends PeBaseScreen
	{
		[Embed(source = "logo.png")]
		public static const introClass:Class;
		public static var button:Sprite = new Sprite();
		
		[Embed(source = 'ClicktoPlay.png')]
		public static const CtP:Class;
		
		public function VVIntroScreen()
		{
			/*
			button = new Sprite();
			
			button.graphics.beginFill(0xFFCC00);
			button.graphics.drawRect((800 / 2) - 100, (600 / 2) - 100, 200, 200 );
			
			button.graphics.endFill();
			*/
			
			var PT2:Bitmap = new introClass();
			addChild(PT2);
			
			var click_play:Bitmap = new CtP();
			click_play.x = 250;
			click_play.y = 500;
			addChild(click_play);
		}
		
		override public function onActive():void
		{
			//button.addEventListener(MouseEvent.CLICK, back);
			addEventListener(MouseEvent.CLICK, back);
			theGameTest.game.gameStage.removeEventListener(Event.ENTER_FRAME, theGameTest.game.stageManager.onFrame);
			//addChild(button);
		}
		
		override public function onDeactivate():void
		{
			//button.removeEventListener(MouseEvent.CLICK, back);
			removeEventListener(MouseEvent.CLICK, back);
			theGameTest.game.gameStage.addEventListener(Event.ENTER_FRAME, theGameTest.game.stageManager.onFrame);
		}
		
		override public function onFrame(delta:Number):void
		{
			
		}
		
		override public function onTick(delta:Number):void
		{	
			
		}
		
		private function back(evt:*):void
		{
			theGameTest.game.ViewManager.popView();
		}
	}
}