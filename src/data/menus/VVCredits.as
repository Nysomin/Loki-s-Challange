package data.menus 
{
	import com.pyro.gui.PeBaseScreen;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author ...
	 */
	public class VVCredits extends PeBaseScreen 
	{
		[Embed(source = "credits.png")]
		public static const creditsClass:Class;
		private var boolDone:Boolean = false;
		private var PE1:Bitmap
		
		public function VVCredits() 
		{
			PE1 = new creditsClass();
			addEventListener(Event.ENTER_FRAME, onFrame2);
			addChild(PE1);
		}

		public function onFrame2(e:Event):void
		{
			if ( PE1.y > -900 )
			{
				PE1.y -= 1;
			}
			if ( PE1.y < -890 )
			{
				boolDone = true;
			}
		}
		
		override public function onActive():void
		{
			addEventListener(MouseEvent.CLICK, back);
			theGameTest.game.gameStage.removeEventListener(Event.ENTER_FRAME, theGameTest.game.stageManager.onFrame);
		}
		
		override public function onDeactivate():void
		{
			removeEventListener(MouseEvent.CLICK, back);
			theGameTest.game.gameStage.addEventListener(Event.ENTER_FRAME, theGameTest.game.stageManager.onFrame);
		}
		
		private function back(evt:*):void
		{
			if( boolDone )
				theGameTest.game.ViewManager.popView();
		}
	}

}