package resource.proxy 
{
	import com.ryan.resource.FileType;
	import com.ryan.resource.info.ImageInfo;
	import com.ryan.resource.LoaderManager;
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class RemoteImageVo 
	{
		public var onComplete:Function;
		public var onError:Function;
		public var extData:Object;
		public var url:String;
		
		public function RemoteImageVo(url:String = null) 
		{
			this.url = url;
		}
		
		public function start():void
		{
			var type:String = url.substr(url.lastIndexOf(".")).toUpperCase();
			var infoClass:Class = FileType.getLoaderInfoByType(type);
			if (infoClass != ImageInfo)
			{
				dealError("只能加载jpg或者png图片");
				return;
			}
			LoaderManager.instance.load(url, onLoaded, 3, null, null, onFailed);
		}
		
		private function onLoaded(info:ImageInfo):void 
		{
			if (info && info.bitmapData)
			{
				if (onComplete != null)
				{
					if (extData)
					{
						onComplete(info.bitmapData, extData);
					}
					else
					{
						onComplete(info.bitmapData);
					}
				}
			}
			else
			{
				dealError("加载的不是图片");
			}
		}
		
		private function onFailed(info:ImageInfo):void 
		{
			dealError("加载失败");
		}
		
		private function dealError(text:String):void
		{
			if (onError != null)
			{
				onError(text);
			}
		}
	}

}