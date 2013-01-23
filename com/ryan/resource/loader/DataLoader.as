package com.ryan.resource.loader
{
	import flash.utils.ByteArray;

	public class DataLoader extends BaseLoader
	{
		public function DataLoader()
		{
			super();
		}

		override public function getClass():Class
		{
			return DataLoader;
		}

		public function get bytesData():ByteArray
		{
			return _data;
		}

		/**
		 * @inheritDoc
		 */
		override public function initialize(data:*):void
		{
			if (!(data is ByteArray))
			{
				throw new Error("DataResource can only handle ByteArrays.");
			}
			_data = data;
			if (resourceInfo)
			{
				resourceInfo.data = _data;
			}
			onLoadCompleteHandler();
		}

		/**
		 * @inheritDoc
		 */
		override protected function onContentReady(content:*):Boolean
		{
			return _data != null;
		}
		private var _data:ByteArray = null;
	}
}
