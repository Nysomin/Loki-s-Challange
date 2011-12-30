package com.pyro.engine.core 
{
	/**
	 * ...
	 * @author Jesse James Lord
	 */
	public class PeGroup extends PeObject
	{
		//A variable to hold our list of objects we have
		protected var _list:Array = [];
		
		//Create the add function
		internal function add(object:IPeObject):Boolean
		{
			object.owningGroup = this;
			object.layer = _list.length;
			_list.push(object);		
			return true;
		}
		
		//Create the remove function
		internal function remove( object:IPeObject):Boolean
		{
			//lets get the index of the object
			var i:int = _list.indexOf(object);
			
			if ( i == -1 )
			{
				//If the object does not exsist in the index then
				return false;
			}
			else
			{
				//lets take it out of the list
				_list.splice(i, 1);
				return true;
			}
		}
		
		//Get the list int count of items in the PeGroup
		public function get length():int
		{
			return _list.length;
		}
		
		public function getObject(index:int):IPeObject
		{
			// Streamed lined this so that it can accept other kind of indexes in the future
			if (!_list.indexOf(index))
				return null;
			else
				return _list[index];
		}
		
		//Clear out the group
		public function clear():void
		{
			while ( _list.length )
			{
				//While the list still has objects call the destroy on each object to clean it up
				(_list.pop() as PeObject).destroy();
			}
		}
		
		public override function destroy(): void
		{
			//Run the clear to cleanup all of the objects this group is holding
			clear();
			
			//Since the group is an object we have to run its cleanup as well
			super.destroy();
		}
	}
}