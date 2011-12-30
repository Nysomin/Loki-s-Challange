package com.pyro.engine.objects 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	import flash.display.Sprite;
	import flash.geom.Point;

	import com.pyro.engine.PE;
	
	public class basicSprite extends Sprite implements peObjects
	{
		private var _name:String;
		private var _alias:String;
		private var _index:int;
		private var _speed:int = 10;
		private var dirX:int = 1;
		private var dirY:int = 1;
		
		/****
		 * Move is where you can add in the AI system or connect the
		 * player directly to their controllers for the object.
		 ****/
		public function move():void
		{
			// Add AI movemnt to this location
			var pos:Point = new Point();
			pos.x = x + (_speed * dirX);
			pos.y = y + ((_speed * (3/4)) * dirY);
			
			if (pos.x > 800 - _speed) dirX = -1;
			if (pos.x < 0 + _speed) dirX = 1;
			if (pos.y > 600 - _speed) dirY = -1;
			if (pos.y < 0 + _speed) dirY = 1;
			
			x = pos.x;
			y = pos.y;
		}// End function move
		
		public function setup(name:String, alias:String):void
		{
			_name = name;
			_alias = alias;
			
			PE.addGameObject(this);
		}
	}

}