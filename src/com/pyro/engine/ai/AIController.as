package com.pyro.engine.ai 
{
	import com.pyro.engine.character.PeCharacter;
	import com.pyro.engine.core.IPeController;
	import com.pyro.engine.core.IPeTicked;
	import com.pyro.engine.objects.PePoint;
	
	/**
	 * ...
	 * @author Leland Ede
	 */
	public class AIController implements IPeTicked 
	{
		private var monster:Array;
		private var archer:int;
		private var attacker:int;
		private var master:int;
		private var boss:int;
		private var length:int;
		
		private var _tickID:int;

		public function AIController() 
		{
			monster = [];
			archer = 0;
			attacker = 0;
			master = 0;
			boss = 0;
			length = 0;
		}
		
		public function onTick(deltaTime:Number):void
		{
			// Check if we need to convert a monster to be a weapon master
			//convertMaster();
			// Convert archers to attacker
			//convertArchers();
			// Convert attackers to archers
			//convertAttackers();
		}
		
		private function convertMaster():void
		{
			var tmpPos:PePoint;
			if (length > 6 && master < 1)
			{
				var idx:int = -1;
				var brk:int = 0;
				do
				{
					idx = Math.random() * monster.length;
					if (brk++ > 10)
					{
						idx = -1;
						break;
					}
				}while (monster[idx] != null && !(monster[idx] is PeWeaponMasterAI));
				if (idx >= 0)
				{
					master++;
					tmpPos = PeMonsterAI(monster[idx]).myPos;
					monster[idx] = new PeWeaponMasterAI(tmpPos);
				}
			}
			tmpPos = null;
		}
		
		private function convertArchers():void
		{
			var tmpPos:PePoint;
			if (attacker < 1 && archer > 2)
			{
				var idx:int = -1;
				var brk:int = 0;
				do
				{
					idx = Math.random() * monster.length;
					if (brk++ > 10)
					{
						idx = -1;
						break;
					}
				}while (monster[idx] != null && monster[idx] is PeArcherAI)
				if (idx >= 0)
				{
					attacker++;
					archer--;
					tmpPos = PeMonsterAI(monster[idx]).myPos;
					monster[idx] = new PeMonsterAI(tmpPos);
				}
			}
			tmpPos = null;
		}
		
		private function convertAttackers():void
		{
			var tmpPos:PePoint;
			if (attacker > 3 && archer < 2)
			{
				var idx:int = -1;
				var brk:int = 0;
				do
				{
					idx = Math.random() * monster.length;
					if (brk++ > 10)
					{
						idx = -1;
						break;
					}
				}while (monster[idx] != null && !(monster[idx] is PeArcherAI))
				if ( idx >= 0)
				{
					attacker--;
					archer++;
					tmpPos = PeMonsterAI(monster[idx]).myPos;
					monster[idx] = PeArcherAI(tmpPos);
				}
			}
		}
		
		public function get tickReady():Boolean
		{
			return true;
		}
		
		public function get tickID():int 
		{
			return _tickID;
		}
		
		public function set tickID(value:int):void 
		{
			_tickID = value;
		}
		
		public function getController(pos:PePoint):IPeController
		{
			var type:int = Math.random() * 100;
			var idx:int = getNextIndex();
			if (type == 200)
			{
				monster[idx] = new PeWeaponMasterAI(pos);
				master++;
			}else if ( type > 75)
			{
				monster[idx] = new PeArcherAI(pos);
			}else
			{
				monster[idx] = new PeMonsterAI(pos);
			}
			
			length++;
			return monster[idx];
		}
		
		
		public function clearController(idx:int):void
		{
			if (monster[idx] != null)
			{
				if (monster[idx] is PeMonsterAI) attacker--;
				if (monster[idx] is PeArcherAI) archer--;
				if (monster[idx] is PeWeaponMasterAI) master--;
				monster[idx] = null;
				length--;
			}
		}
		
		public function getNextIndex():int
		{
			var idx:int = -1;
			if (monster.length > 0)
			{
				for (var i:int = 0; i < monster.length; i++)
				{
					if (null == monster[i])
					{
						// Found an empty index so return it
						idx = i;
						break;
					}// Endif monster[i]equal null check
				}// End for loop index search
			}// Endif monster array length greater than 0
			if (idx < 0)
			{
				// Add new element to array
				idx = monster.length;
				monster.push(null);
			}
			
			return idx;
		}
	}

}