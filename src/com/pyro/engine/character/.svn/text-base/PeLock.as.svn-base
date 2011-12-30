package com.pyro.engine.character 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	public class PeLock 
	{
		/**
		 * The following static constants are going to be used in bitwise manipulations
		 */
		public static const IDLE:uint			= 1;		// 2^0
		public static const RUN:uint			= 2;		// 2^1
		public static const JUMP:uint			= 4;		// 2^2
		public static const ATTACK:uint			= 8;		// 2^3
		public static const DEFEND:uint			= 16;		// 2^4
		public static const THROW:uint			= 32;		// 2^5
		public static const DIE:uint			= 64;		// 2^6
		public static const POWERUP:uint		= 128;		// 2^7
		public static const LEVELUP:uint		= 256;		// 2^8
		public static const HIT:uint			= 512;		// 2^9
		public static const CLEARANIM:uint		= 1024;		// 2^10
		public static const MOVINGDOWN:uint		= 2048;		// 2^11
		public static const MOVINGRIGHT:uint	= 4096;		// 2^12
		public static const MOVINGLEFT:uint		= 8192;		// 2^13
		public static const UP:uint				= 16384;	// 2^14
		public static const DOWN:uint			= Math.pow(2, 15);	// 2^15
		public static const RIGHT:uint			= Math.pow(2, 16);	// 2^16
		public static const LEFT:uint			= Math.pow(2, 17);	// 2^17
		public static const COLLISION:uint		= Math.pow(2, 18);
		
		private var _lockout:uint;
		private var bitCheck:Array;
		
		public function PeLock() 
		{
			unlockAll();
			// Create a validation list so we can validate usage
			bitCheck = [];
			bitCheck.push(IDLE);
			bitCheck.push(RUN);
			bitCheck.push(JUMP);
			bitCheck.push(ATTACK);
			bitCheck.push(DEFEND);
			bitCheck.push(THROW);
			bitCheck.push(DIE);
			bitCheck.push(POWERUP);
			bitCheck.push(LEVELUP);
			bitCheck.push(HIT);
			bitCheck.push(CLEARANIM);
			bitCheck.push(MOVINGDOWN);
			bitCheck.push(MOVINGRIGHT);
			bitCheck.push(MOVINGLEFT);
			bitCheck.push(UP);
			bitCheck.push(DOWN);
			bitCheck.push(RIGHT);
			bitCheck.push(LEFT);
			bitCheck.push(COLLISION);
		}
		
		public function get locked():uint 
		{
			return _lockout;
		}
		
		/**
		 * Add inLock to lockout value if it isn't already locked out.
		 * 
		 * @param inLock:uint - Value to lockout in system
		 */
		public function set lock(inLock:uint):void 
		{
			for (var i:int = 0; i < bitCheck.length; i++)
			{
				var chkLock:uint = bitCheck[i];
				if ((chkLock & inLock) && !(chkLock & _lockout))
				{
					_lockout += chkLock;
				}// Endif bitwise check to make sure item is in list plus is not already locked out
			}// End for i loop
		}
		
		/**
		 * Remove inLock value from lockout if it is locked
		 * 
		 * @param inLock:uint - lock value to remove from lockout
		 */
		public function set unlock(inLock:uint):void
		{
			for (var i:int = 0; i < bitCheck.length; i++)
			{
				var chkLock:uint = bitCheck[i];
				if ((inLock & chkLock) && (chkLock & _lockout))
				{
					_lockout -= chkLock;
				}
			}
		}
		
		public function unlockAll():void
		{
			_lockout = 0;
		}
		
	}

}