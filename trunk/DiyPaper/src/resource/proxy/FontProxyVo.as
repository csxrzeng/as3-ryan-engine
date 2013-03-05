package resource.proxy 
{
	import com.ryan.resource.info.DataInfo;
	import com.ryan.resource.loader.LoaderErrorEvent;
	import com.ryan.resource.LoaderManager;
	import flash.display.DisplayObject;
	import model.ItemVo;
	import resource.Config;
	
	/**
	 * 加载通过php_ming生成的包含特效文字的swf
	 * @author xr.zeng
	 */
	public class FontProxyVo 
	{
		public var onComplete:Function;
		public var onError:Function;
		public var extData:Object;
		public var url:String;
		
		public function FontProxyVo(item:ItemVo) 
		{
			url = Config.FONT_PROXY + "?font=" + encodeURIComponent(item.font) + "&text=" + encodeURIComponent(item.text);
		}
		
		public function start():void
		{
			LoaderManager.instance.load(url, onLoaded, 3, null, null, onFailed);
		}
		
		private function onLoaded(info:DataInfo):void 
		{
			if (info && info.byteArray)
			{
				Convertor.convert(info.byteArray, onConverterComplete, dealError);
			}
			else
			{
				dealError("加载特效字失败，请重试");
			}
		}
		
		private function onFailed(error:LoaderErrorEvent):void
		{
			dealError("加载失败：" + error.text);
		}
		
		private function onConverterComplete(display:DisplayObject):void
		{
			if (display)
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
			else
			{
				dealError("转换特效文字失败，php问题");
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