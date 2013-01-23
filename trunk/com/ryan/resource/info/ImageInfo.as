package com.ryan.resource.info
{
	import flash.display.BitmapData;

	public class ImageInfo extends ResourceInfo
	{
		private var _bitmapData:BitmapData;
		
		public function ImageInfo(object:Object = null)
		{
			super(object);
		}
		
		public function get bitmapData():BitmapData
		{
			return _bitmapData;
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			_bitmapData = this.data as BitmapData;
		}
		
		override public function unload():void
		{
			if( _bitmapData )
			{
				_bitmapData.dispose();
			}
			super.data = null;
			_bitmapData = null;
			isLoaded = false;
			isLoading = false;
		}
	}
}