package com.pyro.gui.chat 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	import com.pyro.engine.gfx2d.gui.PeButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;

	import com.pyro.engine.objects.PePoint;
	import com.pyro.engine.networking.EventGameNet;
	import com.pyro.engine.networking.p2plocal;
	import com.pyro.engine.gfx2d.style.PeStyle;

	public class PeRoomList extends EventDispatcher
	{
		private var stage:Sprite;
		private var txtStyle:TextFormat;
		private var rooms:Sprite;
		private var roomData:Array;
		private var net:p2plocal;
		
		public function PeRoomList(cStage:Sprite, pos:PePoint, cNet:p2plocal, style:PeStyle) 
		{
			net = cNet;
			
			txtStyle = new TextFormat();
			txtStyle.size = 18;
			txtStyle.color = 0xf1d9cb;
			
			loadRooms();
			
			stage = cStage;
			addList(pos);
			pos.y += 410;
			var btnJoin:PeButton = new PeButton("Join", pos, 50, 25, style);
			btnJoin.button.addEventListener(MouseEvent.CLICK, onJoin);
			pos.x += 55;
			var btnCreate:PeButton = new PeButton("Create", pos, 70, 25, style);
			btnCreate.button.addEventListener(MouseEvent.CLICK, onCreate);

			stage.addChild(btnJoin.button);
			stage.addChild(btnCreate.button);
		}// End PeRoomList constructor
		
		public function addList(pos:PePoint):void
		{
			rooms = new Sprite();
				rooms.graphics.beginFill(0xf0f0f0, .85);
				rooms.graphics.drawRect(0, 0, 200, 400);
				rooms.graphics.endFill();
				rooms.x = pos.x;
				rooms.y = pos.y;
			
				
			stage.addChild(rooms);
		}// End addList
		
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
		}// End addJoin
		
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
		}// End addCreate
		
		public function onCreate(e:MouseEvent):void
		{
			dispatchEvent(new EventGameNet(EventGameNet.NET_ONCREATE, null));
		}// End onCreate
		
		public function onJoin(e:MouseEvent):void
		{
			dispatchEvent(new EventGameNet(EventGameNet.NET_ONJOIN, null));
		}// End onJoin
		
		public function loadRooms():void
		{
			
		}// End method loadRooms
	}

}