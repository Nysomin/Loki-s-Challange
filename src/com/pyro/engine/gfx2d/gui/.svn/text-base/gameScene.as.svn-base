package com.pyro.engine.gfx2d.gui 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	import flash.display.Sprite;
	
	import com.pyro.engine.PE;
	
	public class gameScene extends Sprite 
	{
		private var _width:Number;
		private var _height:Number;
		
		public function gameScene() 
		{
			if (PE.gameStage)
			{
				PE.gameStage.addChild(this);
				width = PE.gameStage.stage.stageWidth;
				height = PE.gameStage.stage.stageHeight;
				name = "SceneViewer";
			}
		}
		
		override public function get width():Number
		{
			return _width;
		}
		
		override public function set width(width:Number):void
		{
			_width = width;
		}
		
		override public function get height():Number
		{
			return _height;
		}
		
		override public function set height(height:Number):void
		{
			_height = height;
		}
		
	}

}