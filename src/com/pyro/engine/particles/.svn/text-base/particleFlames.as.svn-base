package com.pyro.engine.particles 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	
	import flash.display.Sprite;
	
	import com.pyro.engine.PE;
	import com.pyro.engine.objects.peObjects;
	
	public class particleFlames implements peObjects
	{
	
		private var _particles:Array;
		private var _max_particles:int = 1000;
		private var _birthrate:int = 25;
		private var _maxage:int = 40;
		
		public function move():void
		{
			for (var i:int = 0; i < _particles.length(); i++)
			{
				_particles[i].move();
			}
		}
		
		public function particleFlames() 
		{
			
		}
		
	}

}