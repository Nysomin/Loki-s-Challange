package com.pyro.engine.gfx2d.sprites 
{
	/**
	 * PeSprite class is a utility to animate sprites ont the screen
	 * and used from creating any object to display on screen
	 * 
	 * @author Leland Ede
	 * @author Robbie Carrington Jr.
	 */
	
	import com.pyro.engine.core.InKey;
	import com.pyro.engine.core.PeFPS;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import com.pyro.engine.gfx2d.tiles.Tile;
	import com.pyro.engine.debug.PeLogger;

	public class PeSprite extends Tile
	{
		// Class varibles to track state
		private var length:int;				// length of frames in sprite
		private var cFrame:int;				// Current frame beign displayed
		private var lastFrame:int;			// lastFrame blitted to sprite
		private var _speed:int;				// Frames Per Second of animation
		private var _fps:int;				// Number of Frame Per Second in game engine
		private var frameInc:Number;		// Frame invrament amount
		private var frameCnt:Number;		// Frame count calulate to speed up and reduce speed of frame rate
		private var _startFrame:uint;		// Start animation at frame number
		private var anim:SpriteArray;		// Array of tiles in sprite
		private var _loopFrame:uint;		// Where to start the loop once we are at the end frame
		
		public function PeSprite(sprite:SpriteArray) 
		{
			// Assign the sprite array to animation variable
			anim = sprite;
			// Get length on animation
			length = sprite.length;
			// Set default animation speed set .5 loop per second
			speed = length/2;
			// Calculate animation speed
			calcSpeed();
			// Set start frame
			startFrame = 0;
			frameCnt = 0;
			loopFrame = 0;
			super(anim.getFrame(0).image);
		}
		
		/**
		 * Calculate the animaiton speed to fps
		 */
		
		public function calcSpeed():void
		{
			// Get current fps from class
			_fps = PeFPS.getInstance.fps;
			frameInc = speed / _fps;
		}// End method calcSpeed
		
		public function moveFrame(index:int):void
		{
			cFrame += index;
			if (cFrame >= length)
			{
				cFrame = 0;
			}
			if (cFrame < 0)
			{
				cFrame = length - 1;
			}
			changeTile(anim.getFrame(cFrame).image);
		}
		
		public override function onFrame(e:Event):void
		{
			// Calculate the frame speed of character
			frameCnt += frameInc;
			if (int(frameCnt) > cFrame)
			{
				cFrame++;
			}
			// Create a looping animation for the sprite
			if (cFrame >= length)
			{
				cFrame = _loopFrame;
				frameCnt = _loopFrame;
			}// Endif cFrame >= sprite length
			
			if (cFrame != lastFrame)
			{
				// Change tile image
				changeTile(anim.getFrame(cFrame).image);
				lastFrame = cFrame;
				// Only need to to run calcSpeed once a second
				calcSpeed();
			}// Endif cFrame not lastFrame check
		}// End method onFrame
				
		public function get frame():int
		{
			return cFrame;
		}// End method get current frame number
		
		public function get len():int
		{
			// Return number of frames in sprite
			return length;
		}// End method get len
		
		public function get speed():int 
		{
			return _speed;
		}// End method get speed
		
		public function set speed(value:int):void 
		{
			_speed = value;
		}// End method set speed
		
		public function get startFrame():uint 
		{
			return _startFrame;
		}// End method get startFrame
		
		public function set startFrame(inFrame:uint):void 
		{
			// Set default frame start
			_startFrame = 0;
			// Validate start frame is within range
			if (inFrame < length)
			{
				_startFrame = inFrame;
			}
			cFrame = _startFrame;
		}// end method set startFrame
		
		public function set loopFrame(value:uint):void 
		{
			_loopFrame = value;
		}
		/**
		 * Set the current frame, used to reset the an animation that is not loopable
		 * 
		 * @param frame:uint
		 */
		public function set currFrame(frame:uint):void
		{
			// Make sure frame in withing bounds
			if (frame < len)
			{
				cFrame = frame;
			}
		}// End method set currFrame
				
		public function get done():Boolean 
		{
			return cFrame == _loopFrame;
		}
		
	}

}