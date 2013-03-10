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
		public var bmd:BitmapData;
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
				bmd = info.bitmapData;
				dealComplete();
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
				bmd = (display as Bitmap).bitmapData;
				dealComplete();
			}
			else
			{
				dealError("加载的不是图片");
			}
		}
		
		private function dealComplete():void
		{
			if (onComplete != null)
			{
				onComplete(this);
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