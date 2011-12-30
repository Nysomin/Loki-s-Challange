package com.pyro.engine.character 
{
	import com.pyro.engine.objects.PePoint;
	/**
	 * ...
	 * @author Mark Petro
	 */
	public class CharacterMover 
	{
		
		private var going_up:String;
		private var deltaTime:Number;
		
		public function CharacterMover() 
		{
			going_up = "standing";
			deltaTime = 0;  //I don't know how to set this to equal current delta time.
		}
		
		public function move_x(spd:int, pos:PePoint):PePoint
		{
			var new_pos = pos;
			new_pos.x += (spd * deltaTime);
			return new_pos;
		}
		
		public function move_z(spd:int, pos:PePoint):PePoint
		{
			var new_pos = pos;
			new_pos.z += ((spd * deltaTime)/100);
			return new_pos;
		}
		
		//I do not know if this function can stay here or not, I do not know how to cycle this.
		public function jump(spd:int, pos:PePoint):PePoint
		{
			var new_pos = pos;
			if (going_up == "jumping")
			{
				new_pos.y += (spd * deltaTime);
				if (new_pos.y >= spd)
					going_up = "falling";
			}
			else if (going_up =="falling")
			{
				new_pos.y -= (spd * deltaTime);
				if (new_pos.y <= 0)
				{
					new_pos.y = 0;
					going_up = "standing";
				}
			}
			else
				going_up = "jumping";
			
			return new_pos;
		}
		
		public function get going():String 
		{
			return going_up;
		}
		
		public function set going(value:String):void 
		{
			going_up = value;
		}
		
		/*
		 * Here is how we can do this.  There will be another jump function that calls every frame event and just loops until going_up is equal to standing again.  Like this:
		 
		 public function display_jump(key:String)
		 {
			var CM = new CharacterMover;
			CM.going = key;
			while(CM.going != "standing")
			{
				player.move(jump(player.stats.speed, player.stats.pos);
			}
		 }
		 
		 Or soemthing like that.  I'm not sure just yet.  Leland, this may be best for you.
		 
		 */
	}

}