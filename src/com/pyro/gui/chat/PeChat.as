package com.pyro.gui.chat 
{
	/**
	 * Chat system example of how to connect the network and gui togehter.
	 * @author Leland Ede
	 */
	import com.pyro.engine.gfx2d.gui.PeButton;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.KeyboardType;
	import flash.ui.Keyboard;
	
	import com.pyro.engine.networking.p2plocal;
	import com.pyro.engine.networking.p2pInternet;
	import com.pyro.engine.networking.EventGameNet;
	import com.pyro.engine.networking.NetTypes;
	import com.pyro.engine.objects.PePoint;
	import com.pyro.engine.gfx2d.style.PeStyle;
	import com.pyro.engine.objects.UserObject;
	
	public class PeChat 
	{
		// Sprite stage that was passed from parent
		private var _cstage:Sprite;
		
		// Defined chat fields
		private var chatDsp:TextField;			// Chat message log
		private var msgBox:TextField;			// New message box
		private var uName:TextField;			// User name field
		private var debug:Boolean = false;		// Run debug code
		private var userBox:Sprite;				// User box
		private var uDesc:TextField				// User infromation field
		
		// Network Connection
		private var net:p2plocal;
		
		// Chat state
		private var inChat:Boolean = false;
		
		// Chat window scroll
		private var scroll:Number = 1;
		
		public function PeChat(cStage:Sprite, netType:String) 
		{
			if (null == cStage)
			{
				// TODO: Set chat system to false
				return;
			}// Endif cStage is null
			switch(netType)
			{
				case NetTypes.INTERNET:
					net = new p2pInternet();
					break;
				default:
					net = new p2plocal();
					break;
			}// End switch netType
			
			_cstage = cStage;

			// Register methods with network notifications
			net.addEventListener(EventGameNet.NET_NOTIFY, onNotify);
			net.addEventListener(Event.CLOSE, destory);
		}// End function peChat
		
		public function get cStage():Sprite
		{
			return _cstage;
		}// End function get cStage
		
		public function addChatBox(pos:PePoint):void
		{
			// Create a chat window for displaying messages
			chatDsp = new TextField();
				chatDsp.type = TextFieldType.DYNAMIC;
				chatDsp.multiline = true;
				chatDsp.wordWrap = true;
				chatDsp.border = true;
				chatDsp.borderColor = 0x0000000;
				chatDsp.width = 400;
				chatDsp.height = 450;
				chatDsp.background = true;
				chatDsp.backgroundColor = 0xd6d9e5;
				chatDsp.x = pos.x;
				chatDsp.y = pos.y;
			
			cStage.addChild(chatDsp);
		} // End function addChatBox
		
		public function addMessageBox(pos:PePoint):void
		{
			// Create text area to enter new messages
			msgBox = new TextField();
				msgBox.type = TextFieldType.INPUT;
				msgBox.multiline = true;
				msgBox.wordWrap = true;
				msgBox.border = true;
				msgBox.borderColor = 0x0000000;
				msgBox.width = 400;
				msgBox.height = 50;
				msgBox.background = true;
				msgBox.backgroundColor = 0xd6d9e5;
				msgBox.addEventListener(KeyboardEvent.KEY_UP, onMsgKeyUp);
				msgBox.x = pos.x;
				msgBox.y = pos.y;
			
			cStage.addChild(msgBox);			
		}
		
		public function addUserBox(pos:PePoint, style:PeStyle):void
		{	
			userBox = new Sprite();
				userBox.graphics.beginFill(0x202020, 0.75);
				userBox.graphics.drawRoundRect(0, 0, 200, 90, 8, 8);
				userBox.graphics.endFill();
				userBox.x = pos.x;
				userBox.y = pos.y;

			// Create a place to enter the user name
			uName = new TextField();
				uName.type = TextFieldType.INPUT;
				uName.multiline = false;
				uName.wordWrap = false;
				uName.border = true;
				uName.borderColor = 0x0000000;
				uName.background = true;
				uName.width = 190;
				uName.height = 20;
				uName.x = 5;
				uName.y = 30;
			
			// Create User Label
			uDesc = new TextField();
				uDesc.type = TextFieldType.DYNAMIC;
				uDesc.text = "User Name";
				uDesc.textColor = 0xf0f0ff;
				uDesc.x = 20;
				uDesc.y = 5;
			
			// Create login button
			pos.setXY(125, 60);
			var uBtn:PeButton = new PeButton("Login", pos, 70, 23, style);
			
			// Add Button shape and text to button asset
			uBtn.button.addEventListener(MouseEvent.CLICK, onConnect);
			
			// Add user button to stage
			userBox.addChild(uDesc);
			userBox.addChild(uName);
			userBox.addChild(uBtn.button);
			
			// Now add userBox to stage
			cStage.addChild(userBox);
		}// End function addUserBox
		
		public function addUserInfo(pos:PePoint):void
		{
			uDesc = new TextField();4
				uDesc.type = TextFieldType.DYNAMIC;
				uDesc.text = "User Name: " + net.user.userName;
				uDesc.x = pos.x;
				uDesc.y = pos.y;
				uDesc.textColor = 0xf0f0ff;
			
			cStage.addChild(uDesc);
		}
		
		public function get chatWindow():TextField
		{
			return chatDsp;
		}// End chatWindow
		
		public function get conNet():p2plocal
		{
			return net;
		}
		
		public function destory(e:Event):void
		{
			var obj:Object = new Object();
			obj.task = EventGameNet.NET_REMOVEUSER;
			net.sendObject(obj);
		}// End destory

		public function onConnect(e:MouseEvent):void
		{
			if (inChat) {
				// Disconnect from chat server
			}else
			{
				if (uName.text.length > 0)
				{
					chatWindow.appendText("Connecting...\n");
					if (debug)
					{
						inChat = net.connect(chatWindow);
					}else
					{
						inChat = net.connect();
					}// Endif debug
					// Check to see if connection was successful
					if (inChat)
					{
						net.addEventListener(EventGameNet.NET_CONNECTED, sendEntry);
						net.addEventListener(EventGameNet.NET_NEIGHBOR_CONNECT, sendHello);
					}// Endif inChat
				}// Endif uName 
			}// Endif inChat
		}// End onConnect
		
		public function onMsgKeyUp(e:KeyboardEvent):void
		{
			// Converted 13 to Keyboard code from flash library to make Jesse happy.
			if (Keyboard.ENTER == e.keyCode)
			{
				if(inChat) net.sendText(msgBox.text);
				msgBox.text = "";
			}// Endif e.keyCode
		}// End onMsgKeyUp
		
		public function onNotify(e:EventGameNet):void
		{
			switch(e.data.task)
			{
				default:
					var msg:String = e.data.userName + ": " + e.data.msg + "\n";
					chatWindow.appendText(msg);
					// Check to see if we need to scroll messages
					if (scroll++ > 24)
					{
						chatWindow.scrollV = scroll - 24;
					}
					break;
			}
		}// End onNotify
		
		public function sendEntry(e:Event):void
		{
			var obj:Object = new Object();
			obj.task = EventGameNet.NET_ADDUSER;
			net.sendObject(obj);
		}// End sendEntry
		
		public function sendHello(e:EventGameNet):void
		{
			var obj:Object = new Object();
			obj.task = EventGameNet.NET_ADDUSER;
			net.sendObject(obj);
		}// End sendHello
		
		public function sendMessage(msg:String):void
		{
			net.sendText(msg, true);
		}// End method sendMessage
		
		public function setUserName():Boolean
		{
			var retValue:Boolean = false;
			if(uName.text.length > 0)
			{
				net.user.userName = uName.text;
				cStage.removeChild(userBox);
				retValue = true;
			}// Endif uName length
			return retValue;
		}// End setUserName
		
	}// End of peChat class
}