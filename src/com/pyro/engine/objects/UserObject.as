package com.pyro.engine.objects 
{
	/**
	 * Network user object
	 * @author Leland Ede
	 */
	public class UserObject 
	{
		public var id:String;
		public var address:String;
		public var serverAddress:String;
		public var userName:String;
		public var label:String;
		public var group:String;
		public var stamp:Number;
		public var idle:Date;
		/**
		 * Store any extra data needed in the data object for passing through the network
		 */
		public var data:Object;
	}

}