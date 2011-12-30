package com.pyro.engine.core 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Leland Ede
	 */
	public final class PeCopy 
	{
		public static function clone(object:*):Object
		{
			var clone:ByteArray = new ByteArray();
			clone.writeObject(object);
			clone.position = 0;
			
			return clone.readObject();
		}
		
	}

}