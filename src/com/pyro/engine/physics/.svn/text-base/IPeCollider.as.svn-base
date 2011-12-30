package com.pyro.engine.physics 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Leland Ede
	 */
	public interface IPeCollider 
	{
		function set direction(dir:PeVector2D):void;
		function set debug(dbg:Boolean):void;
		function get whatHit():IPeCollider;
		function get sprite():Sprite;
		function set vector(vec:PeVector2D):void;
		function get vector():PeVector2D;
		function hitTestCollider(obj:IPeCollider):Boolean;
		function convertToWorld(point:PeVector2D):PeVector2D;
		function convertToLocal(point:PeVector2D):PeVector2D;
		function clearPredictor():void;
		function drawPreditcor(stPnt:PeVector2D, enPnt:PeVector2D):void;
	}
	
}