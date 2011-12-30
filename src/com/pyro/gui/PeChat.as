package com.pyro.gui 
{
	/**
	 * Chat system example of how to connect the network and gui togehter.
	 * @author Leland Ede
	 */
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
	import com.bit101.components.VScrollBar;
	
	import com.pyro.engine.networking.p2plocal;
	import com.pyro.engine.networking.p2pInternet;
	import com.pyro.engine.networking.eventGameNet;
	import com.pyro.engine.networking.NetTypes;
	
	public class peChat 
	{
		// Sprite stage that was passed from parent
		private var _cstage:Sprite;
		
		// Defined chat fields
		private var chatDsp:TextField;
		private var msgBox:TextField;
		private var uName:TextField;
		private var debug:Boolean = true;
		
		// Network Connection
		private var net:p2plocal;
		
		// Chat state
		private var inChat:Boolean = false;
		
		// Chat window scroll
		private var scroll:Number = 1;
		
		public function peChat(cStage:Sprite, netType:String) 
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
			}
			
			_cstage = cStage;
			
			// Create GUI for chat window
			addUserBox();
			addChatBox();
			addMessageBox();
			
			// Register methods with network notifications
			net.addEventListener(eventGameNet.NET_NOTIFY, onNotify);
		}// End function peChat
		
		public function get cStage():Sprite
		{
			return _cstage;
		}// End function get cStage
		
		public function addChatBox():void
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

			chatDsp.x = 100;
			chatDsp.y = 40;
			
			cStage.addChild(chatDsp);
		} // End function addChatBox
		
		public function addMessageBox():void
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
			msgBox.addEventListener(KeyboardEvent.KEY_UP, onMsgKeyUp);

			msgBox.x = 100;
			msgBox.y = 450+45;
			
			cStage.addChild(msgBox);			
		}
		
		public function addUserBox():void
		{
			// Create a place to enter the user name
			uName = new TextField();
				uName.type = TextFieldType.INPUT;
				uName.multiline = false;
				uName.wordWrap = false;
				uName.border = true;
				uName.borderColor = 0x0000000;
				uName.width = 120;
				uName.height = 20;
				uName.x = 100;
				uName.y = 10;
			// Add event listener so user can press return to submit message
			uName.addEventListener(KeyboardEvent.KEY_UP, onMsgKeyUp);
			
			// Add username to stage
			cStage.addChild(uName);
			
			// Create User Label
			var uDesc:TextField = new TextField();
			uDesc.type = TextFieldType.DYNAMIC;
			uDesc.text = "User Name";
			uDesc.x = 30;
			uDesc.y = 10;
			cStage.addChild(uDesc);
			
			// Create connect button
			var uBtn:Sprite = new Sprite();
			uBtn.x = 225;
			uBtn.y = 10;
			
			var uBtnShape:Shape = new Shape();
				uBtnShape.graphics.lineStyle(1, 0x000000);
				uBtnShape.graphics.beginFill(0xf0f0f0);
				uBtnShape.graphics.drawRoundRect(0, 0, 80, 18, 5, 5);
				uBtnShape.graphics.endFill();
			var uBtnTxt:TextField = new TextField();
				uBtnTxt.width = 80;
				uBtnTxt.height = 20;
				uBtnTxt.text = "Connect";
				uBtnTxt.mouseEnabled = false;
				
			// TODO: Why isn't the text getting centered
			var uBtnStyle:TextFormat = new TextFormat("Helvetica");
				uBtnStyle.align = TextFormatAlign.CENTER;
				uBtnStyle.size = 14;
				uBtnTxt.defaultTextFormat = uBtnStyle;
			
			// Add Button shape and text to button asset
			uBtn.addChild(uBtnShape);
			uBtn.addChild(uBtnTxt);
			

			uBtn.addEventListener(MouseEvent.CLICK, onConnect);
			
			// Add user button to stage
			cStage.addChild(uBtn);
		}// End function addUserBox
		
		public function get chatWindow():TextField
		{
			return chatDsp;
		}
		
		public function onConnect(e:MouseEvent):void
		{
			if (inChat) {
				// Disconnect from chat server
			}else
			{
				if (uName.text.length > 0)
				{
					chatWindow.appendText("Connecting...\n");
					net.user.userName = uName.text;
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
						net.addEventListener(eventGameNet.NET_CONNECTED, sendEntry);
						net.addEventListener(eventGameNet.NET_NEIGHBOR_CONNECT, sendHello);
					}// Endif inChat
				}// Endif uName 
			}// Endif inChat
		}// End function onConnect
		
		public function onMsgKeyUp(e:KeyboardEvent):void
		{
			
			if (13 == e.keyCode)
			{
				if(inChat) net.sendText(msgBox.text);
				msgBox.text = "";
			}// Endif e.keyCode
		}// End function onMsgKeyUp
		
		public function onNotify(e:eventGameNet):void
		{
			var msg:String = e.data.userName + ": " + e.data.msg + "\n";
			chatWindow.appendText(msg);
			// Check to see if we need to scroll messages
			if (scroll++ > 28)
			{
				chatWindow.scrollV = scroll - 28;
			}
		}
		
		public function sendEntry(e:Event):void
		{
			net.sendText(net.user.userName + " has entered the room", true);
			net.removeEventListener(eventGameNet.NET_CONNECTED, sendEntry);
		}
		
		public function sendHello(e:eventGameNet):void
		{
			
			net.sendText(net.user.userName + " is in the room", false);
		}

	}// End of peChat class
}