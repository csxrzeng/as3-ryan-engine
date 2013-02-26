package resource.proxy 
{
	import com.ryan.resource.info.ImageInfo;
	import com.ryan.resource.info.SWFInfo;
	import com.ryan.resource.loader.LoaderErrorEvent;
	import com.ryan.resource.LoaderManager;
	import flash.display.DisplayObject;
	import flash.utils.ByteArray;
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
		
		public function SwfFileVo(url:String = null, multi:Boolean = true) 
		{
			this.url = url;
			this.multi = multi;
		}
		
		public function start():void
		{
			LoaderManager.instance.load(url, onLoaded, 3, null, null, onFailed);
		}
		
		private function onLoaded(info:SWFInfo):void 
		{
			if (info && info.data)
			{
				if (multi)
				{
					Convertor.convert(info.data.bytes, onConverterComplete, onError);
				}
				else
				{
					dealComplete(info.data.content);
				}
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
				dealComplete(display);
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
		
		private function dealComplete(display:DisplayObject):void
		{
				if (onComplete != null)
				{
					if (extData)
					{
						onComplete(display, extData);
					}
					else
					{
						onComplete(display);
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