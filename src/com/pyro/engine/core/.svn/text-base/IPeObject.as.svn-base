package com.pyro.engine.core 
{
	import com.pyro.engine.objects.PePoint;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Jesse James Lord
	 */
	public interface IPeObject
	{
		//We need an interface that takes care of objects on the stage
		
		//It needs to hold only a unique name
		function get name():String;
		
		function get layer():int;
		function set layer(value:int):void;
		
		//Setting and getting a group associated with this object
		function set owningGroup(value:PeGroup):void;
		function get owningGroup():PeGroup;
		
		//Initialization of the object
		function init(name:String):Boolean;
		
		function set parent(parent:DisplayObjectContainer):void;
		
		function onFrame(e:Event):void;
		
		// Return IPeObject as a sprite
		function get sprite():Sprite;
		
		//Destruction of the object
		function destroy():void;
		
		function move(pos:PePoint):void;
	}
}