package com.pyro.gui.chat 
{
	/**
	 * ...
	 * @author Leland Ede
	 * 
	 * TODO: Add list of user in room
	 * TODO: Change room feature
	 * TODO: Create game
	 * TODO: List Games waiting for players
	 * TODO: Fix text scrolling in message history window
	 * TODO: Join game
	 * TODO: Enter game password to join game window
	 * TODO: Report to user to select game to join
	 */
	import com.pyro.engine.gfx2d.style.PeStyle;
	import com.pyro.engine.objects.UserObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import com.pyro.engine.objects.PePoint;
	import com.pyro.engine.networking.EventGameNet;
	
	public class PeGameRoom extends PeChat 
	{
		private var gameRoom:Sprite;
		private var bkgDrop:Sprite;
		private var stage:Sprite;
		
		private var roomList:PeRoomList;
		private var userList:PeUserList;
		private var crRoom:PeCreateRoom;
		
		private var style:PeStyle;
		private var btnStyle:PeStyle;
		
		public function PeGameRoom(cStage:Sprite, netType:String) 
		{
			gameRoom = new Sprite();
			stage = cStage;
			super(gameRoom, netType);
			
			// Create style for room
			btnStyle = new PeStyle();
				btnStyle.backgroundColor = 0xff6000;
				btnStyle.lineColor = 0x202020;
				btnStyle.shapeCurve = 8;
				btnStyle.textColor = 0xf0f0f0;
				btnStyle.textSize = 16;
			
			style = new PeStyle();
				style.backgroundColor = 0xf0f0f0;
				style.lineColor = 0x000000;
				style.shapeCurve = 0;
				style.textColor = 0x000000;
				style.textSize = 16;
				
			var pos:PePoint = new PePoint(300, 100);
			bkgDrop = new Sprite();
				bkgDrop.graphics.beginFill(0x2c3552);
				bkgDrop.graphics.drawRect(0, 0, 800, 600);

			gameRoom.addChild(bkgDrop);
			
			addUserBox(pos, btnStyle);
			
			stage.addChild(gameRoom);
		}// End PeGameRoom
		
		public function addUserList(pos:PePoint):void
		{
			var size:PePoint = new PePoint(150, 400);
			userList = new PeUserList(style, size, pos);
			userList.addUser(conNet.user);
			gameRoom.addChild(userList.uSprite);
		}// End method addUserList
		
		override public function onConnect(e:MouseEvent):void 
		{
			// Create position variable for placing items on screen
			var pos:PePoint = new PePoint(180, 10);

			// Set username
			if (setUserName())
			{
				addUserInfo(pos);
				pos.y = 35;
				addChatBox(pos);
				pos.y += 455;
				addMessageBox(pos);
				pos.setXY(590, 35);
				roomList = new PeRoomList(gameRoom, pos, conNet, btnStyle);
				
				// Connect roomList events
				roomList.addEventListener(EventGameNet.NET_ONCREATE, onCreate);
				roomList.addEventListener(EventGameNet.NET_ONJOIN, onJoin);
				pos.setXY(10, 35);
				addUserList(pos);
				super.onConnect(e);
			}// Endif setUserName
		}// End method onConnect
		
		override public function onNotify(e:EventGameNet):void 
		{
			switch(e.data.task)
			{
				case EventGameNet.NET_ADDUSER:
					{
						var user:UserObject = new UserObject();
						user.userName = e.data.userName;
						user.address = e.data.sender;
						userList.addUser(user);
					}
					break;
				case EventGameNet.NET_REMOVEUSER:
					{
						userList.removeUser(e.data.userName);
					}
					break;
				default:
					{
						super.onNotify(e);
					}
					break;
			}// Endif task
		}// End method onNotify
		
		public function onRoomEvents(e:RoomEvents):void
		{
			switch(e.type)
			{
				case RoomEvents.CANCEL:
					{
						crRoom.destroy();
						var obj:Object = new Object();
						obj.msg = "Cancel";
						conNet.sendText("Cancel window", true);
					}
					break;
				default:
					sendMessage("Code: " + e.type);
					break;
			}
		}// End method onRoomEvents
		
		public function onCreate(e:EventGameNet):void
		{
			crRoom = new PeCreateRoom(gameRoom, conNet, btnStyle);
			crRoom.addEventListener(RoomEvents.CANCEL, onCancelRoom);
			//crRoom.addEventListener(RoomEvents.CREATE, onRoomEvents);
		}// End method onCreate
		
		public function onCancelRoom(e:RoomEvents):void
		{
			crRoom.destroy();
		}
		
		public function onJoin(e:EventGameNet):void
		{
			sendMessage("Join Game");
		}// End method onJoin
	}

}