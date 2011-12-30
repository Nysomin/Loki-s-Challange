package data.levels.mapData 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.utils.ByteArray;

	import com.pyro.engine.gfx2d.MapLoader;
	import com.pyro.engine.objects.PeBitmap;
	import com.pyro.engine.debug.PeLogger;

	public class testLevel extends MapLoader
	{
		// Load all external level information
		[Embed(source = "testLevel/testmap.xml", mimeType="application/octet-stream")]
		public static const mapData:Class;
		[Embed(source = "testLevel/clouds.png")]
		public static const mapLayer1:Class;
		[Embed(source = "testLevel/rock.png")]
		public static const mapLayer2:Class;
		[Embed(source = "testLevel/testsheet.png")]
		public static const mapLayer3:Class;
		
		// Create some basic needed data structuires to load loevel
		public var file:ByteArray;
		public var str:String;
		
		public var keys:Array;
		
		public function testLevel(cStage:Sprite) 
		{
			// Moved all initialization to the init function so we can add event handlers
			super("Test Level", cStage);
		}// End method constructor
		
		public function init():void
		{
			file = new testLevel.mapData;
			str = file.readUTFBytes(file.length);
			var lvlXml:XML = new XML(str);
			
			// Create array of img data for loadmap
			var imgData:Array = new Array();
			imgData['clouds.png'] = mapLayer1;
			imgData['rock.png'] = mapLayer2;
			imgData['testsheet.png'] = mapLayer3
			
			addImgData(imgData);
			
			loadMapXML(lvlXml);
			PeLogger.getInstance.log("<-----End Load Test Level------>");
		}
	}
	

}