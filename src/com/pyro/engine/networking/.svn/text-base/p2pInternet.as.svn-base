package com.pyro.engine.networking 
{
	/**
	 * ...
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

	public class p2pInternet extends p2plocal
	{
		
		public override function connect(msgBox:TextField = null):Boolean
		{
			devKey = "97d344461bd29c7585bed247-fe944bfafc14";
			connServer = "rtmfp://p2p.rtmfp.net/";
			
			return super.connect(msgBox);
		}
		
		public override function setupGroup():void
		{
			// Define group specifier and settings for local broadcast
			var room:GroupSpecifier = new GroupSpecifier(groupRoom);
			room.postingEnabled = true;
			room.serverChannelEnabled = true;

			// Create NetGroup
			ng = new NetGroup(nc, room.groupspecWithAuthorizations());
			ng.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
		}		
	}

}