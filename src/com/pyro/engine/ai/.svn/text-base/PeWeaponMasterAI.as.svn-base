package com.pyro.engine.ai 
{
	import com.pyro.engine.objects.PePoint;
	/**
	 * ...
	 * @author Leland Ede
	 */
	public class PeWeaponMasterAI extends PeMonsterAI 
	{
		
		public function PeWeaponMasterAI(pos:PePoint) 
		{
			attackRate = 30;
			super(pos);
		}
		
		override public function get attackRanged():Boolean 
		{
			return Math.random() * 100 > 40;
		}
		
	}

}