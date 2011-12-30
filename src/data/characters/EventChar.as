package data.characters 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Mark Petro
	 */
	
	public class EventChar extends Event
	{
		public static const LOAD_COMPLETE:String			=	"LoadComplete";
		
		public function EventChar(e:String) 
		{
			super(e);
		}
		
	}

}