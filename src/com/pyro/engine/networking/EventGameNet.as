package com.pyro.engine.networking 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leland Ede
	 */
	public class EventGameNet extends Event 
	{
		// Neighbor
		public static const NET_NOTIFY:String					= "NetNotify";
		public static const NET_CONNECTED:String				= "NetConnect";
		public static const NET_DISCONNECTED:String				= "NetDisconnect";
		public static const NET_NEIGHBOR_CONNECT:String			= "NetNeighborConnect";
		public static const NET_NEIGHBOR_DISCONNECT:String		= "NetNeighborDisConnect";
		public static const NET_ONCREATE:String					= "NetOnCreate";
		public static const NET_ONJOIN:String					= "NetOnJoin";
		public static const NET_ADDUSER:String					= "NetAddUser";
		public static const NET_REMOVEUSER:String				= "NetRemoveUser";
		
		public var data:Object;

		public function EventGameNet(type:String, inData:Object) 
		{
			data = inData;
			super(type);
		}
		
	}

}