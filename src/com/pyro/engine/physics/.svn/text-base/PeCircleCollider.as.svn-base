package com.pyro.engine.physics 
{
	import com.pyro.engine.debug.PeLogger;
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Leland Ede
	 */
	public class PeCircleCollider extends Sprite implements IPeCollider
	{
		private var _center:PeVector2D;
		private var _radius:Number;
		
		private var _hitAngle:Number;
		private var _distance:PeVector2D;
		private var _hypotenuse:Number;
		private var _hitSlope:Number;
		private var _vector:PeVector2D;
		
		private var _whatHit:IPeCollider;	// Where we hit object
		private var _debug:Boolean;			// Do we run debug, draw hit areas
		private var predictor:Sprite;		// Predictor sprite
		
		public function PeCircleCollider(center:PeVector2D, radius:Number) 
		{
			_center = center;
			_radius = radius;
			graphics.beginFill(0xafdc81, 1);
				graphics.lineStyle(1, 0x669988, 1);
				graphics.drawCircle(_center.x, _center.y, _radius);
			graphics.endFill();
			debug = false;
			_hypotenuse = 0.0;
		}
		
		public function set debug(dbg:Boolean):void
		{
			_debug = dbg;
			if (_debug)
			{
				alpha = 0.45;
			}else
			{
				alpha = 0.0;
			}
		}
		
		public function set direction(dir:PeVector2D):void
		{
			
		}
		
		public function get whatHit():IPeCollider
		{
			return _whatHit;
		}
		
		public function hitTestCollider(obj:IPeCollider):Boolean
		{
			var retBool:Boolean = false;
			var myCenter:PeVector2D = convertToWorld(_center);
			var theirCenter:PeVector2D = PeCircleCollider(obj).convertToWorld(PeCircleCollider(obj).center);
			var chkVector:PeVector2D = subtract(myCenter, theirCenter);
			// Square the raius to help avoid the expensive suqare root function
			var sumRadii:Number = (radius + PeCircleCollider(obj).radius) * (radius + PeCircleCollider(obj).radius);
			// Get the object squared distance
			var objDiff:Number = ((chkVector.x * chkVector.x) + (chkVector.y * chkVector.y)) - sumRadii;
			_distance = null;

			_hitSlope = (myCenter.y - theirCenter.y) / (myCenter.x - theirCenter.x)
			_hitAngle = (Math.atan2(theirCenter.y - myCenter.y, theirCenter.x - myCenter.x) * 180 / Math.PI) + 180;
			if (objDiff < 0)
			{
				// We have a hit so record and report collision
				_whatHit = obj;
				_distance = new PeVector2D();
				return true;
			}
			
			if (objDiff > 0)
			{
				drawPreditcor(convertToLocal(myCenter), convertToLocal(theirCenter));
				_distance = subtract(myCenter, theirCenter);
				_distance.x = Math.abs(Math.abs(_distance.x) - radius - PeCircleCollider(obj).radius);
				_distance.y = Math.abs(Math.abs(_distance.y) - radius - PeCircleCollider(obj).radius);
			}
			
			// Clean up objects
			myCenter = null;
			theirCenter = null;
			chkVector = null;
			
			return false;
		}
		
		public function convertToWorld(point:PeVector2D):PeVector2D
		{
			var tmpPoint:Point = localToGlobal(vectorToPoint(point));
			return pointToVector(tmpPoint);
		}
		
		public function convertToLocal(point:PeVector2D):PeVector2D
		{
			var tmpPoint:Point = globalToLocal(vectorToPoint(point));
			return pointToVector(tmpPoint);
		}
		
		public function add(p1:PeVector2D, p2:PeVector2D):PeVector2D
		{
			return new PeVector2D(p1.x + p2.x, p1.y + p2.y);
		}
		
		public function subtract(p1:PeVector2D, p2: PeVector2D):PeVector2D
		{
			return new PeVector2D(p1.x - p2.x, p1.y - p2.y);
		}
		
		public function vectorToPoint(pnt:PeVector2D):Point
		{
			return new Point(pnt.x, pnt.y);
		}
		
		public function vectorLength(p1:PeVector2D, p2:PeVector2D):Number
		{
			return Math.sqrt(Math.pow(p1.x - p2.x, 2) + Math.pow(p1.y - p2.y, 2));
		}
		
		public function pointToVector(pnt:Point):PeVector2D
		{
			return new PeVector2D(pnt.x, pnt.y);
		}

		public function clearPredictor():void
		{
			if (_debug)
			{
				if (predictor != null)
				{
					removeChild(predictor);
					predictor = null;
				}			
				predictor = new Sprite();
				addChild(predictor);
			}
		}
		
		public function drawPreditcor(stPnt:PeVector2D, enPnt:PeVector2D):void
		{
			if (_debug)
			{
				var rightAngle:PeVector2D = new PeVector2D(stPnt.x, enPnt.y);

				predictor.graphics.lineStyle(2, 0x990000, 1);
					predictor.graphics.moveTo(stPnt.x, stPnt.y);
					predictor.graphics.lineTo(enPnt.x, enPnt.y);
				// Draw triangle for angle calculations
				predictor.graphics.lineStyle(0, 000000, 0);
				predictor.graphics.beginFill(0x222222, 1);
					predictor.graphics.drawCircle(stPnt.x, stPnt.y, 5);
					predictor.graphics.drawCircle(enPnt.x, enPnt.y, 5);
				predictor.graphics.endFill();	
			}
		}
		
		public function get sprite():Sprite
		{
			return this;
		}
		
		public function get center():PeVector2D 
		{
			return _center;
		}
		
		public function get radius():Number 
		{
			return _radius;
		}
		
		public function get hitAngle():Number 
		{
			return _hitAngle;
		}
		
		public function get distance():PeVector2D 
		{
			return _distance;
		}
		
		public function get hitSlope():Number 
		{
			return _hitSlope;
		}
		
		public function get hypotenuse():Number 
		{
			return _hypotenuse;
		}
		
		public function set hypotenuse(hype:Number):void
		{
			_hypotenuse = hype;
		}
		
		public function get vector():PeVector2D 
		{
			return _vector;
		}
		
		public function set vector(value:PeVector2D):void 
		{
			_vector = value;
		}
		
		public function destory():void
		{
			if (_debug)
			{
				sprite.graphics.clear();
				predictor = null;
			}
		}
	}

}