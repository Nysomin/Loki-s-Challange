package com.pyro.engine.character 
{
	import com.pyro.engine.gfx2d.gui.PeHUD;
	import flash.display.*;
	import flash.geom.*;
	import flash.geom.Matrix;
	import Math;
	
	import com.pyro.engine.objects.PePoint;
	/**
	 * ...
	 * @author Mark Petro
	 */
	public class PeCharacterTracker
	{
		//Define all player statistics
		private var _pos:PePoint;
		private var _jumpPos:Number;
		private var _dead:Boolean;
		private var _type:String;
		private var _life:int;
		private var _lifePotions:int;
		private var _speed:int;
		private var _attack:int;
		private var _exp:int;
		private var _level:int;
		private var _meleeRange:int;
		private var _colChar:Sprite;
		private var _colMelee:Point;
		private var _bar:Sprite;
		private var _maxLife:int;
		private var _gotHit:Boolean;
		private var _powerUp:Boolean;
		private var _HUD:PeHUD;
		
		private var _attackSpeed:int;
		private var _blockSpeed:int;
		
		private var _updateLife:Function;
		private var _updateExp:Function;
		private var _updatePotions:Function;
		private var _updateLevel:Function;
		
		
		public function PeCharacterTracker():void
		{
			/*
					This will create a new character using information from the spawn point.  Oh, and it's not quite dead yet.
			*/
			_bar = new Sprite();
			_bar.x = 24;
			_bar.y = -15;
			_dead = false;
			_exp = 0;
			_level = 1;
			_gotHit = false;
			_powerUp = false;
			_jumpPos = 0.0;
			_lifePotions = 5;
			_blockSpeed = 38;
			_attackSpeed = 40;
		}
		
		
		//All of your getter and setter fuctions
		public function get pos():PePoint 
		{
			return _pos;
		}
		
		public function set pos(value:PePoint):void 
		{
			_pos = value;
		}
		
		public function get life():int 
		{
			return _life;
		}
		
		public function set life(value:int):void 
		{
			if (value < _life)
			{
				_gotHit = true;
			}else
			{
				_powerUp = true;
			}
			if (value < 0)
			{
				value = 0;
			}
			if (value <= _maxLife)
			{
				_life = value;
			}else
			{
				_life = _maxLife;
			}
			if (_updateLife != null)
			{
				var graph:Number = _life / _maxLife;
				_updateLife(graph);
			}
			if (_life <= 0)//Did I get 'em?
			{
				_dead = true; //The reaper awaits...
			}
		}
		
		public function showHealth():void
		{
			if (_type != "player")
			{
				var colors:Array = new Array();
				if ((_life / _maxLife) > .75)
				{
					colors = [0x1a972c, 0xd3fbc5, 0x11510c];
				}else if ((_life / _maxLife) > .5)
				{
					colors = [0x97961a, 0xfbfac5, 0x50510c];
				}else if ((_life / _maxLife) > .25)
				{
					colors = [0xcf6a18, 0xf9c273, 0xb74e00];
				}else
				{
					colors = [0x971a1a, 0xff3838, 0x510c0c];
				}
				_bar.graphics.clear();
				var fillType:String = GradientType.LINEAR;
				var alphas:Array = [1, 1, 1];
				var ratios:Array = [0, 127, 255];
				var matr:Matrix = new Matrix();
				matr.createGradientBox(((_life/_maxLife) * 80), 8, (Math.PI/2), 0, 0);
				var spreadMethod:String = SpreadMethod.PAD;
				_bar.graphics.lineStyle(0, 0x000000, 0);
				//_bar.graphics.beginFill(color, .78);
				_bar.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);
				_bar.graphics.drawRoundRect(0, 0, ((_life/_maxLife) * 80), 8, 3);
				_bar.graphics.endFill();
				_bar.graphics.lineStyle(2, 0x000000, .85);
				_bar.graphics.beginFill(0x980000, .0);
				_bar.graphics.drawRoundRect(-1, -1, 82, 10, 4);
				_bar.graphics.endFill();
				if (_updateLife != null)
				{
					_updateLife(_life / _maxLife);
				}
			}
		}
		
		public function get speed():int 
		{
			return _speed;
		}
		
		public function set speed(value:int):void 
		{
			_speed = value;
		}
		
		public function get exp():int 
		{
			return _exp;
		}
		
		public function set exp(value:int):void 
		{
			var nextLevel:int = 1000 + (((_level - 1) * 2) * 1000);
			_exp = value;
			if (_exp > nextLevel)
			{
				_level++;
				_maxLife += 15;
				life = _maxLife;
				_attack += 2;
				if (_updateLevel != null)
				{
					_updateLevel(_level);
				}
			}
			
			if (_updateExp != null)
			{
				var currLevel:int = 1000 + (((_level - 2) * 2) * 1000);
				if (currLevel < 0) currLevel = 0;
				var graph:Number = (_exp - currLevel)/ (nextLevel - currLevel);
				_updateExp(graph);
			}
		}		
		
		public function get dead():Boolean 
		{
			return _dead;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function set type(value:String):void 
		{
			_type = value;
		}
		
		public function get attack():int 
		{
			return _attack;
		}
		
		public function set attack(value:int):void 
		{
			_attack = value;
		}
		
		public function get meleeRange():int 
		{
			return _meleeRange;
		}
		
		public function set meleeRange(value:int):void 
		{
			_meleeRange = value;
		}

		public function get bar():Sprite 
		{
			return _bar;
		}
		
		public function set bar(value:Sprite):void 
		{
			_bar = value;
		}
		
		public function get maxLife():int 
		{
			return _maxLife;
		}
		
		public function set maxLife(value:int):void 
		{
			_maxLife = value;
		}
		
		public function get colChar():Sprite 
		{
			return _colChar;
		}
		
		public function set colChar(value:Sprite):void 
		{
			_colChar = value;
		}
		
		public function get colMelee():Point 
		{
			return _colMelee;
		}
		
		public function set colMelee(value:Point):void 
		{
			_colMelee = value;
		}
		
		public function get gotHit():Boolean 
		{
			return _gotHit;
		}
		
		public function set gotHit(value:Boolean):void 
		{
			_gotHit = value;
		}
		
		public function get powerUp():Boolean 
		{
			return _powerUp;
		}
		
		public function set powerUp(value:Boolean):void 
		{
			_powerUp = value;
		}
		
		public function get HUD():PeHUD 
		{
			return _HUD;
		}
		
		public function set HUD(value:PeHUD):void 
		{
			_HUD = value;
			_HUD.init();
		}
	
		public function get expereince():int
		{
			return _maxLife * 5;
		}
		
		public function get jumpPos():Number 
		{
			return _jumpPos;
		}
		
		public function set jumpPos(jump:Number):void 
		{
			_jumpPos = jump;
		}
		
		public function get lifePotions():int 
		{
			return _lifePotions;
		}
		
		public function set lifePotions(value:int):void 
		{
			_lifePotions = value;
			if (_lifePotions < 0)
			{
				_lifePotions = 0;
			}
			if (_lifePotions > 15)
			{
				_lifePotions = 15;
			}
			if (_updatePotions != null)
			{
				_updatePotions(_lifePotions);
			}
		}
		
		public function get attackSpeed():int 
		{
			return _attackSpeed;
		}
		
		public function set attackSpeed(value:int):void 
		{
			_attackSpeed = value;
		}
		
		public function get blockSpeed():int 
		{
			return _blockSpeed;
		}
		
		public function set blockSpeed(value:int):void 
		{
			_blockSpeed = value;
		}
		
		public function set updateLife(value:Function):void 
		{
			_updateLife = value;
		}
		
		public function set updateExp(value:Function):void 
		{
			_updateExp = value;
		}
		
		public function set updatePotions(value:Function):void 
		{
			_updatePotions = value;
			_updatePotions(_lifePotions);
		}
		
		public function set updateLevel(value:Function):void 
		{
			_updateLevel = value;
			_updateLevel(_level);
		}
	}

}