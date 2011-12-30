package com.pyro.gui.chat 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;

	import com.pyro.engine.networking.p2plocal;
	import com.pyro.engine.objects.PePoint;
	import com.pyro.engine.gfx2d.style.PeStyle;
	import com.pyro.engine.gfx2d.gui.PeButton;

	public class PeCreateRoom extends EventDispatcher
	{
		private var cStage:Sprite;
		private var createBox:Sprite;
		private var cNet:p2plocal;
		private var style:PeStyle;
		private var _cancel:PeButton;
		private var _create:PeButton;
		
		public function PeCreateRoom(stage:Sprite, net:p2plocal, inStyle:PeStyle = null) 
		{
			// TODO: Verify these are valid objects before storing them
			cStage = stage;
			cNet = net;
			if (inStyle)
			{
				style = inStyle;
			}else
			{
				// Default style probably should be removed at some point
				style = new PeStyle();
				style.backgroundColor = 0xff6000;
				style.lineColor = 0x202020;
				style.shapeCurve = 8;
				style.textColor = 0xf0f0f0;
				style.textSize = 16;
			}
			
			createScreen(new PePoint(100, 50));
			
			cStage.addChild(createBox);
		}// End PeCreateRoom constructor
		
		public function createScreen(pos:PePoint):void
		{
			var pos:PePoint = new PePoint(50, 52);
			// Create backdrop for create room area
			createBox = new Sprite();
				createBox.graphics.beginFill(0x202020, 0.90);
				createBox.graphics.drawRect(0, 0, 500, 500);
				createBox.graphics.endFill();
				createBox.x = pos.x;
				createBox.y = pos.y;
			
			var roomName:TextField = new TextField();
				roomName.type = TextFieldType.INPUT;
				roomName.multiline = false;
				roomName.wordWrap = false;
				roomName.border = true;
				roomName.borderColor = 0x000000;
				roomName.background = true;
				roomName.backgroundColor = 0xf0f0f0;
				roomName.height = 20;
				roomName.width = 300;
				roomName.x = 10;
				roomName.y = 30;
				
			create = new PeButton("Create", pos, 80, 25, style);
			pos.setXY(150, 52);
			cancel = new PeButton("Cancel", pos, 80, 25, style);
			cancel.button.addEventListener(MouseEvent.CLICK, onCancel);
			
			createBox.addChild(roomName);
			createBox.addChild(create.button);
			createBox.addChild(cancel.button);
		}
		
		public function onCancel(e:MouseEvent):void
		{
			dispatchEvent(new RoomEvents(RoomEvents.CANCEL, e));
		}
		
		public function get create():PeButton
		{
			return _create;
		}
		
		public function set create(btn:PeButton):void
		{
			_create = btn;
		}
		
		public function get cancel():PeButton
		{
			return _cancel;
		}
		
		public function set cancel(btn:PeButton):void
		{
			_cancel = btn;
		}
		
		public function destroy():void
		{
			cStage.removeChild(createBox);
		}
		
	}

}