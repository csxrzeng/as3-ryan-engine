package com.ryan.resource.info
{
	import flash.display.BitmapData;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	public class SWFInfo extends ResourceInfo
	{
		private var _clip:MovieClip;
		
		private var _bitmapData:BitmapData;
		
		private var _loaderInfo:LoaderInfo;
		
		public function SWFInfo(object:Object)
		{
			super(object);
		}
		
		public function get clip():MovieClip
		{
			return _clip;
		}
		
		public function get bitmapData():BitmapData
		{
			if( _bitmapData == null && _clip )
			{
				_clip.gotoAndStop(1);
				var rect:Rectangle = _clip.getBounds(_clip);
				if(rect.height==0 || rect.width==0)
				{
					
				}
				else
				{
					_bitmapData=new BitmapData(rect.width, rect.height, true, 0);
					_bitmapData.draw(_clip, new Matrix(1,0,0,1,-rect.x,-rect.y),null,null,null,false);
					_clip = null;
				}
			}
			return _bitmapData;
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			if( value is MovieClip )
			{
				_clip = this.data as MovieClip ;
			}
			else if( value is LoaderInfo )
			{
				_loaderInfo = value as LoaderInfo;
				if( _loaderInfo.swfVersion >= 9 )
				{
					_clip = _loaderInfo.content as MovieClip;
				}
				else
				{
					throw new Error( _loaderInfo.url+"版本："+ _loaderInfo.swfVersion);
				}
			}
		}
		
		override public function dispose():void
		{
			_clip = null;
			data = null;
			isLoaded = false;
			isLoading = false;
			if( _bitmapData )
			{
				_bitmapData.dispose();
			}
			if( _loaderInfo && _loaderInfo.loader )
			{
				_loaderInfo.loader.unloadAndStop();
			}
		}
	}
}