package com.pyro.engine.physics 
{
	import com.pyro.engine.core.IPeObject;
	import com.pyro.engine.core.IPeTicked;
	import com.pyro.engine.debug.PeLogger;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Leland Ede
	 */
	public class PeBoxCollider extends Sprite implements IPeCollider
	{
		public static const UPLEFT:uint		= 1;
		public static const UPRIGHT:uint	= 2;
		public static const LOWRIGHT:uint	= 4;
		public static const LOWLEFT:uint	= 8;
		
		private var _ul:PeVector2D;			// Upper Left Point
		private var _ur:PeVector2D;			// Upper Right Point
		private var _lr:PeVector2D;			// Lower Right Point
		private var _ll:PeVector2D;			// Lower Left Point
		private var dir:PeVector2D;			// Direction object is travaling
		private var _vector:PeVector2D;
		
		private var _whatHit:IPeCollider;	// What hit on the other object
		private var _dirHit:uint;			// What direction was hit on the box
		private var _debug:Boolean;			// Do we run debug, draw hit areas
		private var predictor:Sprite;		// Predictor sprite
		
		private var _resolution:Number;		// Iterations used in predictor point
		private var _cdp:PeVector2D;		// Collision distance predicted
		
		
		/**
		 * Build a vector based collision object with four points in local space
		 * @param	p1
		 * @param	p2
		 */
		public function PeBoxCollider(p1:PeVector2D, p2:PeVector2D) 
		{
			_ul = new PeVector2D(p1.x, p1.y);
			_ur = new PeVector2D(p2.x, p1.y);
			_lr = new PeVector2D(p2.x, p2.y);
			_ll = new PeVector2D(p1.x, p2.y);
			
			var width:int = Math.abs(p1.x - p2.x);
			var height:int = Math.abs(p1.y - p2.y);
			graphics.beginFill(0xafdc81, 1);
				graphics.lineStyle(1, 0x669988, 1);
				graphics.drawRect(p1.x, p1.y, width, height);
			graphics.endFill();
			graphics.beginFill(0x000000, 1);
				graphics.drawCircle(ul.x, ul.y, 3);
				graphics.drawCircle(ur.x, ur.y, 3);
				graphics.drawCircle(lr.x, lr.y, 3);
				graphics.drawCircle(ll.x, ll.y, 3);
			graphics.endFill();
			
			dir = new PeVector2D();
			_resolution = 10;
		}
		
		public function set direction(inDir:PeVector2D):void
		{
			dir = inDir;
		}
		
		public function set debug(dbg:Boolean):void 
		{
			_debug = dbg;
			if (_debug) {
				alpha = 0.45;
			}else
			{
				alpha = 0;
			}
		}
		
		public function get ul():PeVector2D 
		{
			return _ul;
		}
		
		public function get ur():PeVector2D 
		{
			return _ur;
		}
		
		public function get lr():PeVector2D 
		{
			return _lr;
		}
		
		public function get ll():PeVector2D 
		{
			return _ll;
		}
		
		public function get whatHit():IPeCollider 
		{
			return _whatHit;
		}

		public function get dirHit():uint
		{
			return _dirHit;
		}
		
		public function set dirHit(hit:uint):void 
		{
			if (hit & UPLEFT && !(_dirHit & UPLEFT))
			{
				_dirHit += UPLEFT;
			}
			if (hit & UPRIGHT && !(_dirHit & UPRIGHT))
			{
				_dirHit += UPRIGHT;
			}
			if (hit & LOWRIGHT && !(_dirHit & LOWRIGHT))
			{
				_dirHit += LOWRIGHT;
			}
			if (hit & LOWLEFT && !(_dirHit & LOWLEFT))
			{
				_dirHit += LOWLEFT;
			}
		}
		
		public function hitTestCollider(obj:IPeCollider):Boolean
		{
			var retBool:Boolean = false;
			_dirHit = 0;
			
			// Convert all values to world coordinates
			var localP1:PeVector2D = convertToWorld(ul);
			var localP2:PeVector2D = convertToWorld(ur);
			var localP3:PeVector2D = convertToWorld(lr);
			var localP4:PeVector2D = convertToWorld(ll);
			var otherP1:PeVector2D = obj.convertToWorld(PeBoxCollider(obj).ul);
			var otherP2:PeVector2D = obj.convertToWorld(PeBoxCollider(obj).ur);
			var otherP3:PeVector2D = obj.convertToWorld(PeBoxCollider(obj).lr);
			var otherP4:PeVector2D = obj.convertToWorld(PeBoxCollider(obj).ll);
			
			
			// Check upper left point
			if (compareVectors(localP1, otherP1, otherP3))
			{
				dirHit = UPLEFT;
				retBool = true;
			}
			// Check upper right point
			if (compareVectors(localP2, otherP1, otherP3))
			{
				dirHit = UPRIGHT;
				retBool = true;
			}
			// Check lower right point
			if (compareVectors(localP3, otherP1, otherP3))
			{
				dirHit = LOWRIGHT;
				retBool = true;
			}
			// Check lower left point
			if (compareVectors(localP4, otherP1, otherP3))
			{
				dirHit = LOWLEFT;
				retBool = true;
			}
			
			var start:PeVector2D;
			var end:PeVector2D;
			var calcResolution:Number;
			// Clear any old predictors for new frame
			clearPredictor();
			
			if (vector.x < 0)
			{
				// Predict point 1 collision distance
				end = new PeVector2D(localP1.x, localP1.y);
				start = add(localP1, new PeVector2D(vector.x * _resolution, 0));
				drawPreditcor(convertToLocal(start), convertToLocal(end));

				// Predict point 4 collision distance
				end = new PeVector2D(localP4.x, localP4.y);
				start = add(localP4, new PeVector2D(vector.x * _resolution, 0));
				drawPreditcor(convertToLocal(start), convertToLocal(end));
				start = null;
				end = null;
			}
			if (vector.x > 0)
			{
				// Predict point 2 collision distance
				start = new PeVector2D(localP2.x, localP2.y);
				end = add(localP2, new PeVector2D(vector.x * _resolution, 0));
				drawPreditcor(convertToLocal(start), convertToLocal(end));
				
				// Predict point 3 collision distance
				start = new PeVector2D(localP3.x, localP3.y);
				end = add(localP3, new PeVector2D(vector.x * _resolution, 0));
				drawPreditcor(convertToLocal(start), convertToLocal(end));
				
				// Log and clean up
				PeLogger.getInstance.log("Pos Vector: " + convertToLocal(start).toString() + " x " + end.toString());
				start = null;
				end = null;
			}
		
			/*var calcPoint:PeVector2D = localP2;
			var calc:PeVector2D = new PeVector2D(calcPoint.x - otherP1.x, calcPoint.y - otherP1.y);
			PeLogger.getInstance.log("Point: " + calcPoint.toString());
			PeLogger.getInstance.log("Obj.P1: " + otherP1.toString() + " = " + calc.toString());
			calc.setXY(calcPoint.x - otherP3.x, calcPoint.y - otherP3.y);
			PeLogger.getInstance.log("Obj.P3: " + otherP3.toString() + " = " + calc.toString());
			PeLogger.getInstance.log("-----------------------------");
			
			calc = null;
			calcPoint = null;*/
			
			// Cleanup
			localP1 = null;
			localP2 = null;
			localP3 = null;
			localP4 = null;
			otherP1 = null;
			otherP2 = null;
			otherP3 = null;
			otherP4 = null;
			
			return retBool;
		}
		
		private function compareVectors(p1:PeVector2D, p2:PeVector2D, p3:PeVector2D):Boolean
		{
			var retBool:Boolean = false;
			if (p1.x - p2.x >= 0 && p1.x - p3.x <= 0
				&& p1.y - p2.y >= 0 && p1.y - p3.y <= 0)
			{
				retBool = true;
			}
			return retBool;
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
		
		public function pointToVector(pnt:Point):PeVector2D
		{
			return new PeVector2D(pnt.x, pnt.y);
		}
		
		public function clearPredictor():void
		{
			if (predictor != null)
			{
				removeChild(predictor);
				predictor = null;
			}			
			predictor = new Sprite();
			addChild(predictor);
		}
		
		public function drawPreditcor(stPnt:PeVector2D, enPnt:PeVector2D):void
		{

			predictor.graphics.lineStyle(2, 0x990000, 1);
				predictor.graphics.moveTo(stPnt.x, stPnt.y);
				predictor.graphics.lineTo(enPnt.x, enPnt.y);
			predictor.graphics.lineStyle(0, 000000, 0);
			predictor.graphics.beginFill(0x222222, 1);
				predictor.graphics.drawCircle(stPnt.x, stPnt.y, 5);
				predictor.graphics.drawCircle(enPnt.x, enPnt.y, 5);
			predictor.graphics.endFill();
		}
		
		public function get sprite():Sprite
		{
			return this;
		}
		
		public function get vector():PeVector2D 
		{
			return _vector;
		}
		
		public function set vector(value:PeVector2D):void 
		{
			_vector = value;
		}
	}

}