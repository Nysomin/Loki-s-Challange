package com.pyro.engine.character 
{
	
	/**
	 * ...
	 * @author Leland Ede
	 */
	import flash.display.Sprite;
	import flash.events.Event;

	import com.pyro.engine.physics.PeVector2D;
	import com.pyro.engine.physics.IPeCollider;

	public interface IPeProjectileController 
	{
		function set vector(vect:PeVector2D):void;
		function set gravity(grav:Number):void;
		function set weight(wgh:Number):void;
		function set collider(coll:IPeCollider):void;
		function set projectile(pro:Sprite):void;
		function set attack(atk:Number):void;
		
		function get sprite():Sprite;	
		function get attack():Number;
		function get projectile():Sprite;

		function onFrame(e:Event):void;
	}
	
}