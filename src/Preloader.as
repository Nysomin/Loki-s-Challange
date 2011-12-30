package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.ProgressEvent;
	import flash.utils.getDefinitionByName;
	import flash.display.Sprite;
	import com.bit101.components.NumericStepper;
	import flash.geom.Matrix;
	import flash.display.*;
	import flash.geom.*;
	import flash.media.Video;
	import flash.net.NetStream;
	import flash.net.NetConnection;
	import com.pyro.engine.sound.PeSoundEngine;
	import flash.events.AsyncErrorEvent;
	
	
	/**
	 * ...
	 * @author Mark Petro
	 */
	
	
	
	
	public class Preloader extends MovieClip 
	{
		
		private var loadBar:Sprite;
		private var myVideo:Video;
		private var ns:NetStream;
		
		private var loadpng:Bitmap;
		private var bg:Bitmap;
		
		[Embed(source = 'data/menus/nowLoading.png')]
		public static const loader:Class;
		[Embed(source = 'data/menus/logo.png')]
		public static const back:Class;
		
		public function Preloader() 
		{
			loadpng = new Preloader.loader;
			loadpng.x = 250;
			loadpng.y = 500;
			bg = new Preloader.back;
			addChild(bg);
			addChild(loadpng);
			loadBar = new Sprite();
			if (stage) {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			myVideo = new Video(800, 600);
			addChild(myVideo);
			var nc:NetConnection = new NetConnection();
			nc.connect(null);
			ns = new NetStream(nc);
			ns.client = new Object();
			ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorEventHandler);
			ns.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			myVideo.attachNetStream(ns);

			//ns.play("pyroIntro.flv");

			addChild(loadBar);
			addChild(loadpng);
			PeSoundEngine.getInstance.playSound("intro", true);
		}
		private function asyncErrorEventHandler(event:AsyncErrorEvent):void {
		// ignore
		}
		public function netStatusHandler(e:NetStatusEvent) :void
		{
			if(e.info.code == "NetStream.Play.Stop")
			ns.seek(0);
		}
		private function ioError(e:IOErrorEvent):void 
		{
			trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void 
		{
			var loaded:Number= e.target.bytesLoaded;
			var total:Number = e.target.bytesTotal;
			var pct:Number = loaded / total;
			loadBar.graphics.clear();
			var fillType:String = GradientType.LINEAR;
			var alphas:Array = [1, 1, 1];
			var ratios:Array = [0, 127, 255];
			var matr:Matrix = new Matrix();
			matr.createGradientBox((pct * 80), 8, (Math.PI/2), 0, 0);
			var spreadMethod:String = SpreadMethod.PAD;
			loadBar.graphics.lineStyle(0, 0x000000, 0);
			loadBar.graphics.beginFill(0x00ff00, .78);
			//loadBar.graphics.beginGradientFill(fillType, 0x00ff00, alphas, ratios, matr, spreadMethod);
			loadBar.graphics.drawRoundRect(360, 580, (pct * 80), 8, 3);
			loadBar.graphics.endFill();
			loadBar.graphics.lineStyle(2, 0xFFFFFF, .85);
			loadBar.graphics.beginFill(0xFFFFFF, .0);
			loadBar.graphics.drawRoundRect(359, 579, 82, 10, 4);
			loadBar.graphics.endFill();
		}
		
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				stop();
				loadingFinished();
			}
		}
		
		private function loadingFinished():void 
		{
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			removeChild(myVideo);
			removeChild(loadBar);
			removeChild(loadpng);
			
			startup();
		}
		
		private function startup():void 
		{
			var mainClass:Class = getDefinitionByName("theGameTest") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
	}
	
}