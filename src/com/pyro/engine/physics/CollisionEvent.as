package com.pyro.engine.physics 
{
	import com.pyro.engine.character.PeCharacter;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leland Ede
	 */
	public class CollisionEvent extends Event 
	{
		public static const HIT:String				= "ObjectHit";
		public static const PROJECTILE_HIT:String	= "ProjectileHit";
		
		public var colObject:PeCharacter;
		
		public function CollisionEvent(e:String, obj:PeCharacter) 
		{
			colObject = obj;
			super(e);
		}
		
	}

}