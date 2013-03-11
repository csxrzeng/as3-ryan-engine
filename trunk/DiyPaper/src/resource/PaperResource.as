package resource
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import model.Cache;
	import model.FontVo;
	import model.ItemVo;
	import model.PaperVo;
	import resource.proxy.ResourceProxy;
	import resource.proxy.SwfFileVo;
	
	/**
	 * 预加载需要的资源
	 * @author 曾宪荣
	 */
	public class PaperResource
	{
		private var paperVo:PaperVo;
		private var onComplete:Function;
		private var onError:Function;
		private var onProgress:Function;
		private var totalCount:int;
		private var completeCount:int;
		private var subprogress:Number;
		
		public function PaperResource(paper:PaperVo)
		{
			paperVo = paper;
		}
		
		public function start(onComplete:Function, onError:Function = null, onProgress:Function = null):void
		{
			this.onComplete = onComplete;
			this.onError = onError;
			this.onProgress = onProgress;
			totalCount = paperVo.items.length;
			completeCount = 0;
			for each (var item:ItemVo in paperVo.items)
			{
				if (item.type == ItemVo.IMAGE)
				{
					ResourceProxy.loadSwf(item.url, onSwfComplete, onSwfError, item, progressHandler);
				}
				else if (item.type == ItemVo.SPECIAL_TEXT)
				{
					var font:FontVo = Cache.instance.font.getSpecialFontByFont(item.font);
					if (font)
					{
						ResourceProxy.loadFont(font, onFontComplete, onFontError, item, progressHandler);
					}
					else
					{
						completeCount++;
					}
				}
				else
				{
					completeCount++;
				}
			}
		}
		
		private function progressHandler(... rest):void
		{
			if (onProgress != null)
			{
				subprogress++;
				if (subprogress < 100)
				{
					onProgress(completeCount + subprogress / 100, totalCount);
				}
			}
		}
		
		private function onSwfComplete(swf:SwfFileVo):void
		{
			completeCount++;
			var item:ItemVo = swf.extData as ItemVo;
			item.display = swf.display;
			checkComplete();
		}
		
		private function onSwfError(err:String):void
		{
			completeCount++;
			checkComplete();
		}
		
		private function onFontComplete(swf:SwfFileVo):void
		{
			completeCount++;
			checkComplete();
		}
		
		private function onFontError(err:String):void
		{
			completeCount++;
			checkComplete();
		}
		
		private function checkComplete():void
		{
			if (onProgress != null)
			{
				subprogress = 0;
				onProgress(completeCount, totalCount);
			}
			if (completeCount >= totalCount)
			{
				for each (var item:ItemVo in paperVo.items)
				{
					if (item.type == ItemVo.IMAGE && !item.display)
					{
						item.display = new Bitmap(new BitmapData(100, 100, true, 0xCCCCCC)); // 替代品
					}
				}
				onComplete();
			}
		}
		
		private function checkError():void
		{
			if (onError != null)
			{
				onError();
			}
		}
	}
}