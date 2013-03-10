package resource.proxy
{
	import com.ryan.resource.info.ImageInfo;
	import com.ryan.resource.info.ResourceInfo;
	import com.ryan.resource.info.SWFInfo;
	import com.ryan.resource.loader.LoaderErrorEvent;
	import com.ryan.resource.LoaderManager;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class SwfFileVo
	{
		public var onComplete:Function;
		public var onError:Function;
		public var extData:Object;
		public var url:String;
		public var multi:Boolean; // 是否可以多份数据
		public var display:DisplayObject;
		
		public function SwfFileVo(url:String = null, multi:Boolean = true)
		{
			this.url = url;
			this.multi = multi;
		}
		
		public function start():void
		{
			LoaderManager.instance.load(url, onLoaded, 3, null, null, onFailed);
		}
		
		private function onLoaded(info:ResourceInfo):void
		{
			if (info is SWFInfo)
			{
				if (multi)
				{
					Convertor.convert(info.data.bytes, onConverterComplete, dealError);
				}
				else
				{
					display = info.data.content;
					dealComplete();
				}
			}
			else if (info is ImageInfo)
			{
				display = new Bitmap((info as ImageInfo).bitmapData, "auto", true);
				dealComplete();
			}
			else
			{
				dealError("加载的不是图片");
			}
		}
		
		private function onConverterComplete(display:DisplayObject):void
		{
			if (display)
			{
				this.display = display;
				dealComplete();
			}
			else
			{
				dealError("加载失败");
			}
		}
		
		private function onFailed(error:LoaderErrorEvent):void
		{
			dealError("加载失败：" + error.text);
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