package com.pyro.engine.ai 
{
	import com.pyro.engine.debug.PeLogger;
	import com.pyro.engine.objects.PePoint;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author Leland Ede
	 */
	public class PeArcherAI extends PeMonsterAI 
	{
		public static const yRange:int = 5;
		
		public function PeArcherAI(pos:PePoint)
		{
			super(pos);
			inSightRange = 500;
			attackRate = 50;
		}
		
		override public function get attackRanged():Boolean 
		{
			var chkPos:PePoint = new PePoint(0, 0, 0, true);
			chkPos.x = myPos.x - plPos.x;
			chkPos.y = myPos.y - plPos.y;
			nextAttack++;
			if (chkPos.x < 280 || chkPos.x > 330)
			{
				return false;
			}
			if (chkPos.y < -yRange && chkPos.y > yRange)
			{
				return false;
			}
			if (nextAttack > attackRate)
			{
				nextAttack = 0;
				return true;
			}
			
			return false;
		}
		
		override public function move():void 
		{
			var chkPos:PePoint = new PePoint(0, 0, 0, true);
			var minPos:PePoint = new PePoint(0, 0, 0, true);
			var maxPos:PePoint = new PePoint(0, 0, 0, true);
			
			chkPos.x = Math.abs(myPos.x - plPos.x);
			if (chkPos.x < 280)
			{
				virtKeys[Keyboard.D] = true;
				setDir = false;
			}else if (chkPos.x >= 330)
			{
				virtKeys[Keyboard.A] = true;
				setDir = false;
			}
			
			if (plPos.y < myPos.y)
			{
				virtKeys[Keyboard.W] = true;
				setDir = false;
			}else if (plPos.y > myPos.y)
			{
				virtKeys[Keyboard.S] = true;
				setDir = false;
			}
			
		}
		
	}

}