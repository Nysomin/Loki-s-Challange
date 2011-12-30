package data.GUI 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	import com.pyro.engine.core.IPeObject;
	import com.pyro.engine.core.PeGroup;
	import com.pyro.engine.objects.PePoint;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import com.pyro.engine.gfx2d.gui.PeHUD;
	import flash.text.TextFormat;
	
	public class PlayerHUD implements IPeObject
	{
		private var _sprite:Sprite;
		private var _parent:DisplayObjectContainer;
		
		private var _playerLife:Sprite;
		private var _playerExp:Sprite;
		
		private var lifePotion:TextField;
		private var levelNum:TextField;
		private var textDecor:TextFormat;
		
		private var _name:String;
		private var _layer:int;
		private var _owningGroup:PeGroup;
		
		private var _graph:PeHUD;
		
		public function PlayerHUD() 
		{
			_sprite = new Sprite();
			lifePotion = new TextField();
			levelNum = new TextField();
			levelNum.text = "0";
			lifePotion.text = "x 0";
			textDecor = new TextFormat();
			textDecor.color = 0xffffff;
			textDecor.font = "Pericles";
			textDecor.size = 18;
			
			lifePotion.setTextFormat(textDecor);
			levelNum.setTextFormat(textDecor);
		}
		
		public function init(name:String):Boolean
		{
			_name = name;
			expereince(0);
			life(1);
			return true;
		}
		
		public function onFrame(e:Event):void
		{
			
		}
		
		public function move(pos:PePoint):void
		{
			
		}
		
		public function get sprite():Sprite 
		{
			return _sprite;
		}
		
		public function set sprite(value:Sprite):void 
		{
			_sprite = value;
		}
		
		public function get parent():DisplayObjectContainer 
		{
			return _parent;
		}
		
		public function expereince(exp:Number):void
		{
			if (_playerExp != null)
			{
				_sprite.removeChild(_playerExp);
				_playerExp = null;
			}
			_playerExp = new Sprite();
			var bar:Sprite = new Sprite;
			bar.graphics.beginFill(0xd8c622, .2);
				bar.graphics.lineStyle(2, 0x202020, 1);
				bar.graphics.drawRoundRect(0, 0, 140, 6, 2, 2);
			bar.graphics.endFill();
			var barFill:Sprite = new Sprite();
			var expSize:int = 138 * exp + 2;
			if (expSize < 1)
			{
				expSize = 1;
			}
			
			barFill.graphics.beginFill(0xd8c622, 1);
				barFill.graphics.drawRoundRect(0, 0, expSize, 6, 2, 2);
			bar.graphics.endFill();
			levelNum.x = 160;
			levelNum.y = -8;
			
			_playerExp.y = 50;
			_playerExp.x = 80;
			_playerExp.addChild(barFill);
			_playerExp.addChild(bar);
			_playerExp.addChild(levelNum);
			_sprite.addChild(_playerExp);
		}
		
		public function life(pl:Number):void
		{
			_graph.change(pl);
			lifePotion.x = 60;
			lifePotion.y = 80;
			_sprite.addChild(lifePotion);
		}
		
		public function startHUD():void
		{
			_graph.init();
			_sprite.addChild(_graph);
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
			return _owningGroup;
		}
		
		public function set owningGroup(value:PeGroup):void 
		{
			_owningGroup = value;
		}
		
		public function set parent(value:DisplayObjectContainer):void 
		{
			_parent = value;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function setPotions(pnts:int):void
		{
			lifePotion.text = "x " + pnts.toString();
			lifePotion.setTextFormat(textDecor);
		}
		
		public function setLevel(lvl:int):void
		{
			levelNum.text = lvl.toString();
			levelNum.setTextFormat(textDecor);
		}
		
		public function set graph(value:PeHUD):void 
		{
			_graph = value;
		}
		
		public function destroy():void
		{
			_parent.removeChild(_sprite);
			_sprite.removeChild(_playerExp);
			_sprite.removeChild(_playerLife);
			
			_playerExp = null;
			_playerLife = null;
			_sprite = null;
		}
		
	}

}