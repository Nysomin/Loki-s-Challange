package com.pyro.engine.character 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	import flash.events.Event;

	public class CharacterEvent extends Event
	{
		public static const REMOVE_CHARACTER:String			= "RemoveCharacter";
		public static const KILL_LAST:String				= "KillLast";
		public static const KILL_PROJECTILE:String			= "KillProjectile";
		
		public var layer:int;								// Layer id of object in array
		
		public function CharacterEvent(e:String, lId:int) 
		{
			layer = lId;
			super(e);
		}
		
	}

}