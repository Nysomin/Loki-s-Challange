package com.pyro.engine.physics 
{
	import com.pyro.engine.character.PeProjectile;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leland Ede
	 */
	public class ProjectileEvent extends Event 
	{
		public static const PROJECTILE_HIT:String		= "ProjectileHit";
		public static const PROJECTILE_PLAYER:String	= "ProjectilePlayerHit";
		
		private var _projectile:PeProjectile;

		public function ProjectileEvent(e:String, obj:PeProjectile) 
		{
			_projectile = obj;
			super(e);
		}
		
		public function get projectile():PeProjectile 
		{
			return _projectile;
		}
		
		public function set projectile(value:PeProjectile):void 
		{
			_projectile = value;
		}
		
	}

}