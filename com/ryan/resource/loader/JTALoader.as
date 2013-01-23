package com.ryan.resource.loader
{
	import flash.utils.ByteArray;

	public class JTALoader extends BaseLoader
	{
		public function JTALoader()
		{
			super();
		}
		/**
		 * The loaded data. This will be null until loading of the resource has completed.
		 */
//		public function get modelInfo():FyModelInfo
//		{
//			return _modelInfo;
//		}
		
		override public function getClass():Class
		{
			return JTALoader;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function initialize(data:*):void
		{
			if(!(data is ByteArray))
				throw new Error("DataResource can only handle ByteArrays.");
//			
//			var info:FyModelInfo = new FyModelInfo();
//			info.read(data);
//			
//			_modelInfo = info;
//			
//			if( resourceInfo )
//			{
//				resourceInfo.data = _modelInfo;
//			}
			onLoadCompleteHandler();
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function onContentReady(content:*):Boolean 
		{
			return true;//_modelInfo != null;
		}
		
		//private var _modelInfo:FyModelInfo = null;
	}
}