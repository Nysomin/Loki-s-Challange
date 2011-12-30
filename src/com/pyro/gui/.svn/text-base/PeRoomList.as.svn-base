package com.pyro.gui 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import com.pyro.engine.objects.PePoint;
	import com.pyro.engine.networking.EventGameNet;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class PeRoomList extends EventDispatcher
	{
		private var stage:Sprite;
		private var txtStyle:TextFormat;
		
		public function PeRoomList(cStage:Sprite, pos:PePoint) 
		{
			txtStyle = new TextFormat();
			txtStyle.size = 18;
			txtStyle.color = 0xf1d9cb;
			
			stage = cStage;
			addList(pos);
			pos.y += 500;
			addJoin(pos);
			pos.x += 55;
			addCreate(pos);
		}
		
		public function addList(pos:PePoint):void
		{
			
		}
		
		public function addJoin(pos:PePoint):void
		{
			var btn:Sprite = new Sprite();
			btn.graphics.beginFill(0xff6000)
			btn.graphics.drawRoundRect(0, 0, 50, 30, 5, 5);
			btn.graphics.endFill();
			btn.addEventListener(MouseEvent.CLICK, onJoin);
			btn.x = pos.x;
			btn.y = pos.y;
			
			var btnTxt:TextField = new TextField();
			btnTxt.text = "Join";
			btnTxt.setTextFormat(txtStyle);
			btnTxt.x = 8;
			btnTxt.y = 4;
			
			btn.addChild(btnTxt);
			
			stage.addChild(btn);
		}
		
		public function addCreate(pos:PePoint):void
		{
			var btnTxt:TextField = new TextField();
			btnTxt.text = "Create";
			btnTxt.setTextFormat(txtStyle);
			btnTxt.x = 8;
			btnTxt.y = 4;
			
			
			var btn:Sprite = new Sprite();
			btn.graphics.beginFill(0xff6000);
			btn.graphics.drawRoundRect(0, 0, 70, 30, 5, 5);
			btn.graphics.endFill();
			btn.addEventListener(MouseEvent.CLICK, onCreate);
			btn.x = pos.x;
			btn.y = pos.y;

			btn.addChild(btnTxt);
			
			stage.addChild(btn);			
		}
		
		public function onCreate(e:MouseEvent):void
		{
			dispatchEvent(new EventGameNet(EventGameNet.NET_ONCREATE, null));
		}
		
		public function onJoin(e:MouseEvent):void
		{
			dispatchEvent(new EventGameNet(EventGameNet.NET_ONJOIN, null));
		}
	}

}