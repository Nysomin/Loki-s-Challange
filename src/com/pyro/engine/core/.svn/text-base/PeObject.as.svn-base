package com.pyro.engine.core 
{
	/**
	 * ...
	 * @author Jesse James Lord
	 */
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import Box2D.Dynamics.b2Body;

	import com.pyro.engine.core.PeObject;
	import com.pyro.engine.objects.PePoint;

	public class PeObject implements IPeObject
	{
		//Base variables for the object name and owningGroup
		protected var _name:String;
		protected var _owningGroup:PeGroup;
		protected var _layer:int;
		//protected var _body:b2Body;
		protected var _design:DisplayObject;
		
		// Interface needed data structure
		private var _parent:DisplayObjectContainer;
		
		/* INTERFACE com.pyro.engine.core.IPeObject */
		
		public function get layer():int
		{
			return _layer;
		}
		
		public function set layer(value:int):void
		{
			if (isNaN(value))
				throw new Error("Need a valid int to set the object layer.");
			else
			{
				//Lets check to make sure it is in our range
				if ( value <= 50 && value >= 0 )
					_layer = value;
				else
				{
					//Add it to a generic layer for right now say 5
					_layer = 5;
				}
			}
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function set owningGroup(value:PeGroup):void 
		{
			if (!value)
			{
				//Then there is no group associated with the value or an invalid value was given
				throw new Error("Please make sure it is a valid group");
			}
			else
			{
				//We have a valid group so lets assign it over
				_owningGroup = value;
			}
		}
		
		
		
		public function get owningGroup():PeGroup 
		{
			return _owningGroup;
		}
		
		public function init(name:String):Boolean 
		{
			_name = name;
			return true;
		}
		
		public function onFrame(e:Event):void
		{
			
		}
		
		public function get sprite():Sprite
		{
			return new Sprite();
		}
		
		public function destroy():void 
		{	
			//If it is part of a group remove it from the group
			_owningGroup.remove(this);
			
			//Set its variables to null since we don't need it linking to anything
			_owningGroup = null;
			_name = null;
			//_layer = null;
		}
		
		public function move(pos:PePoint):void
		{
			// This function needs to be overwritten in any calling methods so it get properly implamented
		}
		
		public function set parent(inPanret:DisplayObjectContainer):void
		{
			_parent = inPanret;
		}// End method set parent
	}
}