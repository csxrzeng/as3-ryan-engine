package com.ryan.debug
{
	import com.ryan.core.frame.FlashFrame;
	import com.ryan.core.frame.FrameTimer;
	import com.ryan.core.frame.TimerType;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getTimer;

	/**
	 * 这个类提供了FPS监控功能，可以用作性能优化的标准
	 * 
	 * @author flashyiyi
	 */	
	public class FPS extends Sprite
	{
		/**
		 * 采样次数
		 */		
		public var sampling:int = 30;
		
		/**
		 * 默认帧频，为0时则取舞台帧频
		 */		
		public var frameRate:int = 0;
		
		private var fpsTextField:TextField;
		private var bitmap:Bitmap;
		private var intervalArr:Array=[];
		
		private var _totalFrame:int=0;
		
		private var _totalTimer:int = 0;
		
		private static var _instance:FPS = new FPS();
		
		public function FPS()
		{
			
			if( _instance )
			{
				throw new Error(" FPS单例");
			}
//			var b:Bitmap = new Bitmap(new BitmapData(80,20,false,0x0));
//			addChild(b);
			
			mouseEnabled = mouseChildren = false;
        	
			fpsTextField = new TextField();
			fpsTextField.mouseEnabled = false;
			fpsTextField.width = 350;
			fpsTextField.autoSize = TextFieldAutoSize.CENTER;
			fpsTextField.height = 20;
			fpsTextField.selectable = false;
			fpsTextField.defaultTextFormat = new TextFormat(null,null,0xFFFFFF);
			addChild(fpsTextField);
			
			this.x = 600;
			
			this.graphics.beginFill(0x000000,0.3);
			this.graphics.drawRect(0,0,350,25);
			this.graphics.endFill();
//			bitmap = new Bitmap(new BitmapData(20,20,true,0x00FFFFFF));
//			bitmap.x = 300;
//			addChild(bitmap);
			var timer:FrameTimer = new FrameTimer(10);
			timer.addListener(TimerType.ENTERFRAME,tickHandler);
			timer.start();
		}
		
		public static function get instance():FPS
		{
			return _instance;
		}
		
		public var entityNum:int;
		
		public var countFrames:int;
		
		
		private function tickHandler(event:FrameTimer):void
		{
			if (stage==null) 
				return;
			fpsTextField.text = "FPS：" + int(1000/FlashFrame.AverageTime) +" | Memory："+currentMem.toFixed(3)+" | 帧数："+countFrames+ " | 对象："+entityNum;
		}
		
		public static function get currentMem() : Number 
		{
			return (System.totalMemory / 1024) / 1024;
		}
	}
}