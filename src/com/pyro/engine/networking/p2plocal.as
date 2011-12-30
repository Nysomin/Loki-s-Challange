/***
 * This package require the playerglobal.swc library so that
 * NetGroup is available for use.
 ***/

 package com.pyro.engine.networking 
{
	/**
	 * P2P connection through broadcast network
	 * 
	 * @author Leland Ede
	 */
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.NetGroup;
	import flash.net.GroupSpecifier;
	import flash.text.TextField;
	import com.pyro.engine.networking.EventGameNet;
	import com.pyro.engine.objects.UserObject;
	
	public class p2plocal extends EventDispatcher
	{
		private var _msgBox:TextField = null;
		private var _debugMode:Boolean = false;
		
		private var _connServer:String = "rtmfp:";
		private var _devKey:String = "";
		private var _groupRoom:String = "Beacon/Room1";
		
		private var _nc:NetConnection;
		private var _ng:NetGroup;
		private var _seq:int;
		
		private var _user:UserObject = new UserObject();
		private var connected:Boolean = false;
		
		public function connect(msgBox:TextField = null):Boolean
		{
			_seq = 0;
			// Create network connection
			var connectStr:String = _connServer + _devKey;
			nc = new NetConnection();
			nc.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			nc.addEventListener(Event.CLOSE, destroy);
			nc.connect(connectStr);
			
			// Check to see if we have a valid message box
			if (msgBox)
			{
				// This is used to report network related messages
				debugMode = true;
				_msgBox = msgBox;
				networkMessage("Connecting to " + connectStr);
			}// Endif msgBox
			return true;
		}// End function connect
		
		// Handles basic netowrk connection and dispatch events
		public function onNetStatus(e:NetStatusEvent):void
		{
			switch(e.info.code)
			{
				case "NetConnection.Connect.Success":
					networkMessage("Network connected now building group.");
					setupGroup();
					break;
				case "NetGroup.Connect.Success":
					networkMessage("Group built and network ready.");
					connected = true;
					dispatchEvent(new Event(EventGameNet.NET_CONNECTED));
					break;
				case "NetGroup.Connect.Rejected":
					var err:Object = new Object();
					err.userName = "ERROR";
					err.msg = "Connection Rejected!";
					dispatchEvent(new EventGameNet(EventGameNet.NET_NOTIFY, err));
					break;
				case "NetGroup.Neighbor.Connect":
					networkMessage("Neighbor connected displatching event.");
					dispatchEvent(new EventGameNet(EventGameNet.NET_NEIGHBOR_CONNECT, e.info.message));
					break;
				case "NetGroup.Neighbor.Disconnect":
					networkMessage("Neighbor disconnected displatching event.");
					dispatchEvent(new EventGameNet(EventGameNet.NET_NEIGHBOR_DISCONNECT, e.info.message));
					break;
				case "NetGroup.Posting.Notify":
					networkMessage("Posting notification to dispatcher.");
					dispatchEvent(new EventGameNet(EventGameNet.NET_NOTIFY, e.info.message));
					break;
				default:
					if (debugMode)
					{
						networkMessage(e.info.code);
					}
					break;
			}// End switch e.info.code
		}// End function OnNetStatus
		
		public function networkMessage(msg:String):void
		{
			if (debugMode)
			{
				_msgBox.appendText(msg + "\n");
			}
		}// End networkMessage
		
		public function setupGroup():void
		{
			// Define group specifier and settings for local broadcast
			var gps:GroupSpecifier = new GroupSpecifier(groupRoom);
			gps.postingEnabled = true;
			gps.ipMulticastMemberUpdatesEnabled = true;
			// 225.225.x.x is used for a broadcast address not 255.255.x.x
			gps.addIPMulticastAddress("225.225.0.1:7976");
			
			// Create NetGroup
			ng = new NetGroup(nc, gps.groupspecWithAuthorizations());
			ng.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
		}// End setupGroup
		
		public function sendText(msg:String, postBack:Boolean = true):void
		{
			if (true == connected)
			{
				var postObj:Object = new Object();
				postObj.sender = ng.convertPeerIDToGroupAddress(nc.nearID);
				postObj.sequence = _seq++;
				postObj.msg = msg;
				postObj.userName = userName;
				
				ng.post(postObj);
				if (postBack)
				{
					dispatchEvent(new EventGameNet(EventGameNet.NET_NOTIFY, postObj));
				}
			}else
			{
				networkMessage("Not Connected!\n");
			}// Endif connected
		}// End sendText
		
		public function sendObject(obj:Object):void
		{
			if (true == connected)
			{
				obj.sender = ng.convertPeerIDToGroupAddress(nc.nearID);
				obj.sequence = _seq++;
				obj.userName = userName;
				
				ng.post(obj);
			}else {
				
			}// Endif connected
		}// End method sendObject
		
		public function sendStatus(msg:String):void
		{
			if (true == connected)
			{
				var postObj:Object = new Object();
				postObj.msg = msg;
				postObj.sender = ng.convertPeerIDToGroupAddress(nc.nearID);
				
				ng.post(postObj);
				dispatchEvent(new EventGameNet(EventGameNet.NET_NOTIFY, postObj));
			}// Endif connected
		}// End sendStatus
		
		public function destroy(e:Event):void
		{
			nc.close();
		}
		
		public function get userName():String
		{
			return _user.userName;
		}
		
		public function set userName(name:String):void
		{
			_user.userName = name;
		}
		
		public function get nc():NetConnection
		{
			return _nc;
		}
		
		public function set nc(inNc:NetConnection):void
		{
			_nc = inNc;
		}
		
		public function get ng():NetGroup
		{
			return _ng;
		}
		
		public function set ng(inNg:NetGroup):void
		{
			_ng = inNg;
		}
		
		public function get groupRoom():String
		{
			return _groupRoom;
		}
		
		public function get debugMode():Boolean
		{
			return _debugMode;
		}
		
		public function set debugMode(debug:Boolean):void
		{
			_debugMode = debug;
		}
		
		public function set connServer(svr:String):void
		{
			_connServer = svr;
		}
		
		public function set devKey(key:String):void
		{
			_devKey = key;
		}
		
		public function get user():UserObject
		{
			return _user;
		}
		
		public function get msgBox():TextField
		{
			return _msgBox;
		}
	}
}