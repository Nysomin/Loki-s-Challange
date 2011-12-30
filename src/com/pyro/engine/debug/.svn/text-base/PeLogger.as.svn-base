package com.pyro.engine.debug 
{
	/**
	 * PELogger class is used to log game engine errors.
	 * 
	 * @author Leland Ede
	 * @author Robbie Carrington Jr.
	 */
	//import flash.text.TextField;
	import flash.net.FileReference;
	import flash.utils.ByteArray;

	// TODO: Add in logging to file service (To save automatically requires AIR, which seems to be incompatible with flex. So, I used a FileReference object to save to a file.) (done, unless changes are needed)
	// TODO: Change the log method to support multiple logging source (done, unless more are needed)
	// TODO: Create logging mutator methods for msgLog, fileLog, trace (done)
	
	public class PeLogger 
	{
		private static var _instance:PeLogger;
		private static var _allow:Boolean = false;
		private var _debugState:Boolean = false;
		private var _msgLog:String;
		private var _fileLog:FileReference = new FileReference();
		private var _fileBA:ByteArray = new ByteArray();
		
		public function PeLogger() 
		{
			if (!_allow)
			{
				throw("ERROR: Not allowed to instantiate class directly use the getInstance method.");
			}
		}// End method constructor
		
		public static function get getInstance():PeLogger
		{
			if (_instance == null)
			{
				_allow = true;
				_instance = new PeLogger();
				_allow = false;
			}
			return _instance;
		}// End method getInstance
		
		public function set debugState(value:Boolean):void 
		{
			_debugState = value;
		}//end method debugState
		
		public function get debugState():Boolean
		{
			return _debugState;
		}// End method debugState
		
		public function get logContents():String
		{
			return _msgLog;
		}//end logContents get method
		
		public function set logContents(value:String):void 
		{
			log(value);
		}//end logContents set method
		
		public function get fileLogObject():FileReference
		{
			return _fileLog;
		}//end fileLogObject get method
		
		public function set traceText(value:String):void 
		{
			log(value, true);
		}//end traceText set method
		
		public function saveLog():void // save the log to a file. Opens a dialog box to ask where it should be saved. So, this should be linked to a key or command (such as SHIFT+F9).
		{
			if (_debugState) // don't do anything if debugging is off
			{
				fileLogObject.save(_fileBA, "debug.txt");
			}
		}// End method saveLog
		
		public function log(msg:String, outputToConsole:Boolean = true):void
		{
			if (_debugState) // don't do anything if debugging is off
			{
				if (!outputToConsole) // save log if there will be no output to the console
				{
					_msgLog += msg + "\n";
					_fileBA.writeMultiByte(_msgLog, "utf-8");
				}
				else 
				{
					trace(msg);
				}
			}
		}// End method log
		
	}

}