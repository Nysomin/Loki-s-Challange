package com.pyro.engine.character 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	import com.pyro.engine.objects.PePoint;
	import com.pyro.engine.physics.PeVector2D;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;

	import com.pyro.engine.core.IPeObject;
	import com.pyro.engine.core.PeGroup;
	import com.pyro.engine.physics.PeCircleCollider;

	public class PePowerup implements IPeObject
	{
		private var _collider:PeCircleCollider;
		private var _layer:int;	
		
		private var _parent:DisplayObjectContainer;
		private var _sprite:Sprite;
		private var _powerup:Sprite;
		private var _group:PeGroup;
		private var _name:String;
		
		private var _pos:PeVector2D;
		
		public function PePowerup() 
		{
			_sprite = new Sprite();
			_powerup = new Sprite();
			_sprite.addChild(_powerup);
		}
		
		public function init(inName:String):Boolean
		{
			_name = inName;
			
			_sprite.graphics.beginFill(0x5678ff, 0.5);
				_sprite.graphics.lineStyle(1, 0xffffff, 1);
				_sprite.graphics.drawEllipse(0, 0, 10, 20);
			_sprite.graphics.endFill();
			
			return true;
		}
		
		public function onFrame(e:Event):void
		{
			if (_pos != null)
			{
				sprite.x = _pos.x;
				sprite.y = _pos.y;
			}
		}
		
		public function move(pos:PePoint):void
		{
			
		}
		
		public function destroy():void
		{
			_sprite.removeChild(_powerup);
			_parent.removeChild(_sprite);
			_powerup = null;
			_sprite = null;
			_pos = null;
		}
		
		public function get layer():int 
		{
			return _layer;
		}
		
		public function set layer(value:int):void 
		{
			_layer = value;
		}
		
		public function set parent(cont:DisplayObjectContainer):void 
		{
			_parent = cont;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get owningGroup():PeGroup
		{
			return _group;
		}
		
		public function set owningGroup(grp:PeGroup):void
		{
			_group = grp;
		}
		
		public function get sprite():Sprite 
		{
			return _sprite;
		}
		
		public function get pos():PeVector2D 
		{
			return _pos;
		}
		
		public function set pos(value:PeVector2D):void 
		{
			_pos = value;
		}
		
		public function get collider():PeCircleCollider 
		{
			return _collider;
		}
		
		public function set collider(value:PeCircleCollider):void 
		{
			_collider = value;
		}
	}

}