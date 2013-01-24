package com.ryan.resource.loader
{
	import flash.utils.ByteArray;

	public class MapDataLoader extends BaseLoader
	{
		public function MapDataLoader()
		{
			super();
		}
		
		/**
		 * The loaded data. This will be null until loading of the resource has completed.
		 */
		public function get mapInfo():Object
		{
			return _mapInfo;
		}
		
		override public function getClass():Class
		{
			return MapDataLoader;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function initialize(data:*):void
		{
			if(!(data is ByteArray))
				throw new Error("DataResource can only handle ByteArrays.");
			
			var info:Object = new Object();
			info.read(data);
			_mapInfo = info;
			
			if( resourceInfo )
			{
				resourceInfo.data = _mapInfo;
			}
			onLoadCompleteHandler();
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function onContentReady(content:*):Boolean 
		{
			return _mapInfo != null;
		}
		
		private var _mapInfo:Object = null;
	}
}