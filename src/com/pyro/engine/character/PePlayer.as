package com.pyro.engine.character 
{
	import com.pyro.engine.core.InputController;
	import com.pyro.engine.core.PeKeyBinding;
	import data.characters.Player.PePlayerData;
	import com.pyro.engine.objects.PePoint;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * 
	 * @author Mark Petro
	 * 
	 */
	public class PePlayer extends PeCharacter 
	{
		
	
		
		public function PePlayer(name:String) 
		{
			super(name);
		}
		
		override public function init(inName:String):Boolean 
		{
			//sprite.addChild(states.getState());
			moveToStartLocation();
			return super.init(inName);
		}		
		
	}

}