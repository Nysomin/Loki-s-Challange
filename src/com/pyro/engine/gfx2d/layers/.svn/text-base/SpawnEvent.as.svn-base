package com.pyro.engine.gfx2d.layers 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	import flash.events.Event;
	import com.pyro.engine.gfx2d.objects.PeSpawnObject;

	public class SpawnEvent extends Event
	{
		public static const SPAWN:String			= "SpawnMonster";
		public static const LEVEL1BOSS:String		= "Level1Boss";
		public static const LEVEL2BOSS:String		= "Level2Boss";
		public static const LEVEL3BOSS:String		= "Level3Boss";
		public static const LEVEL4BOSS:String		= "Level4Boss";
		
		public var spawn:PeSpawnObject;
		
		public function SpawnEvent(e:String, inSpawn:PeSpawnObject) 
		{
			spawn = inSpawn;
			super(e);
		}
		
	}

}