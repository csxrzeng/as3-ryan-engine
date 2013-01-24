package com.ryan.resource.loader
{
	import com.ryan.resource.info.ResourceInfo;
	import flash.events.ErrorEvent;

	public class BaseLoader extends StreamLoader
	{
		public var data:*;
		public var resourceInfo:ResourceInfo;

		public function getClass():Class
		{
			return BaseLoader;
		}

		public function BaseLoader()
		{
			super();
		}

		override protected function onIOErrorHandler(event:ErrorEvent):void
		{
			if (resourceInfo)
			{
				resourceInfo.isLoaded = false;
				resourceInfo.isLoading = false;
			}
			super.onIOErrorHandler(event);
		}

		override protected function onLoadCompleteHandler():void
		{
			if (resourceInfo)
			{
				resourceInfo.isLoaded = true;
				resourceInfo.isLoading = false;
			}
			super.onLoadCompleteHandler();
		}
	}
}
