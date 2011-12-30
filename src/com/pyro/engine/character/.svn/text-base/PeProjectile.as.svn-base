package com.pyro.engine.character 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	import com.pyro.engine.core.PeGroup;
	import com.pyro.engine.debug.PeLogger;
	import com.pyro.engine.objects.PePoint;
	import data.items.GameAxe;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import com.pyro.engine.physics.IPeCollider;
	import com.pyro.engine.core.IPeObject;
	import com.pyro.engine.physics.PeVector2D;

	public class PeProjectile implements IPeProjectileController, IPeObject
	{
		private var _collider:IPeCollider;
		private var _controller:IPeProjectileController;
		private var _sprite:Sprite;
		private var _projectile:Sprite;
		private var _vector:PeVector2D;
		private var _pos:PeVector2D;
		private var _attack:Number;
		private var _age:int;
		private var _active:Boolean;
		
		private var _layer:int;
		private var _group:PeGroup;
		private var _parent:DisplayObjectContainer;
		private var _axeBlit:GameAxe;
		private var _dir:String;
		
		public function PeProjectile() 
		{
			_projectile = new Sprite();
			_sprite = new Sprite();
			_active = true;
		}
		
		public function init(inName:String):Boolean
		{
			return true;
		}
		
		public function set position(pos:PeVector2D):void
		{
			_pos = pos;
		}
		
		public function set vector(vect:PeVector2D):void
		{
			_vector = vect;
		}
		
		public function set gravity(grav:Number):void
		{
			
		}
		
		public function set weight(wgh:Number):void
		{
			
		}
		
		public function set collider(coll:IPeCollider):void
		{
			_collider = coll;
			projectile.addChild(_collider.sprite);
		}
		
		public function get collider():IPeCollider
		{
			return _collider;
		}
		
		public function set attack(atk:Number):void
		{
			_attack = atk;
		}
		
		public function get sprite():Sprite
		{
			return _sprite;
		}
		
		public function get attack():Number
		{
			return _attack;
		}

		public function onFrame(e:Event):void
		{
			_sprite.x = _pos.x;
			_sprite.y = _pos.y;
			if (_age++ < 80)
			{
				_projectile.x += _vector.x;
				_projectile.y += _vector.y;
				if (_projectile.y > -20)
				{
					_vector.x = 0.0;
					_vector.y = 0.0;
				}else
				{
					_vector.y += 0.15;
					_axeBlit.onFrame();
				}
			}else
			{
				_active = false;
				// Dispatch event to kill object
				if (_sprite.alpha <= 0)
				{
					_sprite.dispatchEvent(new CharacterEvent(CharacterEvent.KILL_PROJECTILE, _layer));
					return;
				}
				_sprite.alpha -= .01;
			}
		}
		
		public function onHit():void
		{
			_sprite.dispatchEvent(new CharacterEvent(CharacterEvent.KILL_PROJECTILE, _layer));
		}
		
		public function move(pos:PePoint):void
		{
			
		}
		
		public function get projectile():Sprite
		{
			return _projectile;
		}
		
		public function set projectile(pro:Sprite):void
		{
			if (_projectile != null)
			{
				_sprite.removeChild(_projectile);
				_projectile = null;
			}
			_projectile = pro;
			_sprite.addChild(_projectile);
		}
		
		public function get layer():int 
		{
			return _layer;
		}
		
		public function set layer(value:int):void 
		{
			_layer = value;
		}
		
		public function get owningGroup():PeGroup 
		{
			return _group;
		}
		
		public function set owningGroup(value:PeGroup):void 
		{
			_group = value;
		}
		
		public function set parent(value:DisplayObjectContainer):void 
		{
			_parent = value;
		}
		
		public function get name():String
		{
			return "Projectile";
		}
		
		public function get active():Boolean 
		{
			return _active;
		}
		
		public function set axeBlit(value:GameAxe):void 
		{
			_axeBlit = value;
			_projectile.addChild(_axeBlit);
			_sprite.addChild(_projectile);
		}
		
		public function set dir(value:String):void 
		{
			_dir = value;
			_axeBlit.dir = value;
		}
		
		public function destroy():void
		{
			_projectile.removeChild(_collider.sprite);
			_sprite.removeChild(_projectile);
			_parent.removeChild(_sprite);
			_sprite = null;
			_projectile = null;
			_collider = null;
		}
	}
	
	
	
}