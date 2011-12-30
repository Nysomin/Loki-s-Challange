package com.pyro.engine.gfx2d.sprites 
{
	/**
	 * Class SpriteLoader which loads up a full sprite sheet and parses a text
	 * data file.
	 * 
	 * @author Leland Ede
	 */
	import com.pyro.engine.core.IPeObject;
	import com.pyro.engine.core.PeCopy;
	import com.pyro.engine.core.PeGroup;
	import com.pyro.engine.gfx2d.tiles.Tile;
	import com.pyro.engine.objects.PeBitmap;
	import com.pyro.engine.objects.PePoint;
	import flash.display.Sprite;
	import flash.events.Event;
	import data.characters.IPeCharacteraData
	
	import com.pyro.engine.debug.PeLogger;

	public class SpriteLoader implements IPeCharacteraData
	{
		// Class data structures
		private var anim:Array;
		private var sheet:SpriteSheet;
		private var gStage:Sprite;
		
		// Interface data
		private var _name:String;
		private var _group:PeGroup;
		private var pos:PePoint;
		
		public function SpriteLoader(spriteData:String, spriteImage:Class, inStage:Sprite) 
		{
			// Create a new sprite sheet
			sheet = new SpriteSheet(spriteImage, "SpriteSheet");
			// Create new array to store sprite animations
			anim = new Array();
			// Set game stage to inStage
			gStage = inStage;
			
			// Parse the text file
			parseData(spriteData);
			pos = new PePoint(0, 0,0);
		}// End method constructor
		
		public function parseData(data:String):void
		{
			// Create a data structure to store each linbe from data file
			var lineData:Array = new Array();
			// Break data up based on the line feed and charage return
			lineData = data.split("\r\n");

			// Loop through every line in file data
			for (var i:int = 0; i < lineData.length-1; i++)
			{
				// Create temp array to store lineData peices
				var tmp:Array = new Array();
				// Break line up on the equal sign
				tmp = lineData[i].split("=");
				// Create key from first array element (###_filename####)
				//var key:String = tmp[0].substring(3, (tmp[0].length - 5));
				//So BuildCharacter test will work correctly.
				var key:String = tmp[0].substring(0, (tmp[0].length - 5));
				// Get frame number for this key
				var frameKey:int = tmp[0].substring(tmp[0].length - 4, tmp[0].length - 1);
				
				// Create temp number variable
				var tmpNum:Array;
				// Split second element of tmp array based on space character
				tmpNum = tmp[1].split(" ");
				// Burn first array element since it is blank
				tmpNum.shift();
				// Create points where to get the sprite from sprite sheet location
				var pos1:PePoint = new PePoint(int(tmpNum[0]), int(tmpNum[1]), 0);
				var pos2:PePoint = new PePoint(int(tmpNum[0]) + int(tmpNum[2]), int(tmpNum[1]) + int(tmpNum[3]), 0);
				//PeLogger.getInstance.log(key + ": " + frameKey.toString());
				
				// Check to see if this key is a SpriteArray
				if (!(anim[key] is SpriteArray))
				{
					// Create sprite array object
					anim[key] = new SpriteArray();
				}// Endif anim key is SpriteArray
				// Store sprite in SpriteArray
				anim[key].addFrame(frameKey, sheet.getTile(pos1, pos2));
			}// End for loop
		}// End method parseData
		
		public function getSprite(index:String):PeSprite
		{
			// Create a default sprite
			var retSprite:PeSprite;
			if (anim[index] is SpriteArray)
			{
				retSprite = new PeSprite(anim[index]);
			}else
			{
				// TODO: Send a blank PeSprite
			}// Endif anim[index] is SpriteArray
			
			return retSprite;
		}// End getSprite
		
		public function get name():String
		{
			return _name; 
		}
		
		public function get layer():int
		{
			return _group.layer;
		}
		
		public function set layer(id:int):void
		{
			_group.layer = id;
		}
		
		public function get owningGroup():PeGroup
		{
			return _group;
		}

		public function set owningGroup(grp:PeGroup):void
		{
			_group = grp;
		}
		
		public function init(iName:String):Boolean
		{
			_name = iName;
			return true;
		}
		
		public function destroy():void
		{
			
		}

		public function set position(cPos:PePoint):void
		{
			pos = cPos;
		}
		
	}

}