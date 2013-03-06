package resource.proxy 
{
	import com.ryan.resource.FileType;
	import com.ryan.resource.info.DataInfo;
	import com.ryan.resource.info.ImageInfo;
	import com.ryan.resource.loader.LoaderErrorEvent;
	import com.ryan.resource.LoaderManager;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import resource.Config;
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
			var type:String = FileType.getType(url);
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
				dealComplete(info.bitmapData);
			}
			else
			{
				dealError("加载的不是图片");
			}
		}
		
		private function onFailed(error:LoaderErrorEvent):void 
		{
			//dealError("加载失败:" + error.text);
			// 可能有安全沙箱导致失败，通过ImageProxy加载
			LoaderManager.instance.load(Config.IMAGE_PROXY + "?imgurl=" + encodeURIComponent(url), onBinLoaded, 3, null, null, onBinFailed);
		}
		
		private function onBinLoaded(info:DataInfo):void 
		{
			if (info && info.byteArray)
			{
				Convertor.convert(info.byteArray, onConvertComplete, dealError);
			}
			else
			{
				dealError("加载失败");
			}
		}
		
		private function onBinFailed(error:LoaderErrorEvent):void
		{
			dealError("加载失败");
		}
		
		private function onConvertComplete(display:DisplayObject):void
		{
			if (display is Bitmap)
			{
				dealComplete((display as Bitmap).bitmapData);
			}
			else
			{
				dealError("加载的不是图片");
			}
		}
		
		private function dealComplete(bitmapData:BitmapData):void
		{
			if (onComplete != null)
			{
				if (extData)
				{
					onComplete(bitmapData, extData);
				}
				else
				{
					onComplete(bitmapData);
				}
			}
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