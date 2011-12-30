package com.pyro.engine.gfx2d.sprites 
{
	
	/**
	 * ...
	 * @author Mark Petro
	 * @author Leland Ede
	 * 
	 * This class is designed to give us a blitting sprite animation.  It is NOT an allpurpose blit animator.
	 * 
	 * Usage:  A state machine can change the animation by using the function setAnim(action:String, direction:String) 
	 * 
	 */
	
	import com.pyro.engine.core.PeFPS;
	import com.pyro.engine.debug.PeLogger;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.events.Event
	import flash.display.Sprite;
	
	public class PeBlitter extends Sprite
	{
		
		private var blitData:Array;
		private var blitImage:BitmapData;
		private var canvas:Bitmap;
		private var canvasBD:BitmapData;
		private var _direction:String;
		private var _action:String;
		
		private var _speed:int;
		private var frameInc:Number;
		private var frameCnt:Number;
		
		private var pos:Point;
		private var _frame:int;
		private var count:int;
		private var _done:Boolean = false;
		private var _start:Boolean = true;
		private var _hold:Boolean = false;
		private var prevAction:String;
		private var _loop:Boolean = false;
		
		public function PeBlitter(data:Array, image:BitmapData) 
		{
			/*
			 *  Setting evertyhing up, we need a fresh bitmap to display with it's data exposed so that we may change it.
			 * 
			 * 	Notes:  Variables frame and count are used to animate out sprites, and pos is a point so thet we fill the entire canvas bitmap.
			 * 			
			 */
			blitImage = image;
			blitData = data;
			pos = new Point(0, 0);
			frame = 0;
			count = 0;
			_done = false;
			speed = 45;
			calcSpeed();
			frameCnt = 0.0;
		}
		
		public function init():void
		{
			/*
			 *  Once the animation has been sent to the character, the character must call this function in order for the proper sprite dimensions to  be used
			 */
			var rec:Rectangle = blitData[_action][_direction][0];
			var x:int = rec.width;
			var y:int = rec.height;
			canvasBD = new BitmapData(x, y, true, 0x000000ff);
			canvas = new Bitmap(canvasBD);
			addChild(canvas);
		}
		
		public function onFrame(e:Event):void
		{
			/*
			 * This is where we do all of our animating.
			 */
			// Get blitData information from master array
			var tempArray:Array = blitData[_action][_direction];
			// Validate we have a valid animation
			if(tempArray != null)
			{
				if (frame >= tempArray.length-1)
				{
					frame = tempArray.length - 1;
					if (_loop)
					{
						frame = 0;
						frameCnt = 0.0;
					}
					_done = true;
					_start = false;
					
				}else
				{
					frameCnt += frameInc;
					frame = frameCnt;
					_done = false;
				}
				if (tempArray[frame] != null)
				{
					var rect:Rectangle = tempArray[frame];
					canvasBD.copyPixels(blitImage, rect, pos);
				}// Endif check tempArray frame is not null
			}else
			{
				PeLogger.getInstance.log("Animation error on action: " + _action + " direction: " + _direction);
			}// Endif check tempArray to be valid
		}
		
		public function calcSpeed():void
		{
			frameInc = speed / PeFPS.getInstance.fps;
			
		}
		
		public function get direction():String 
		{
			return _direction;
		}
		
		public function set direction(value:String):void 
		{
			_direction = value;
		}
		
		public function set loop(value:Boolean):void 
		{
			_loop = value;
		}
		
		public function get loop():Boolean
		{
			return _loop;
		}
		
		public function get action():String 
		{
			return _action;
		}
		
		public function set action(value:String):void 
		{
			if (value != _action)
			{
				frame = 0;
				frameCnt = 0.0;
				_action = value;
			}
		}
		
		public function get speed():int 
		{
			return _speed;
		}
		
		public function set speed(spd:int):void 
		{
			_speed = spd;
			calcSpeed();
		}
		
		public function get done():Boolean 
		{
			return _done;
		}
		
		public function get frame():int 
		{
			return _frame;
		}
		
		public function set frame(value:int):void 
		{
			_frame = value;
		}
		
		public function set start(value:Boolean):void 
		{
			_start = value;
		}
		
		public function set hold(value:Boolean):void 
		{

			_hold = value;
		}
		
		public function get hold():Boolean 
		{
			return _hold;
		}
		
		public function reset():void
		{
			frame = 0;
			frameCnt = 0.0;
			_done = false;
		}
		
	}

}