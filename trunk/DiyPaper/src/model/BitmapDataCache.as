package model
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	import flash.utils.Dictionary;
	
	/**
	 * 图片加载缓存工具类
	 * @author zxr
	 */
	public class BitmapDataCache
	{
		private static var data:Object = new Object(); // 缓存
		private static var bitmaps:Dictionary = new Dictionary(true); // bmp作为key，对应url
		private static var bmps:Object = new Object(); // 储存bmp的引用
		private static var sizes:Object = new Object(); // 储存size的引用
		private static var funs:Object = new Object(); // 存储callback的引用
		private static var defBmdX:BitmapData = new BitmapData(1, 1, true, 0x0);
		
		/**
		 * 获取图片的数据
		 * @param url 图片地址
		 * @param bmp 可选，需要数据的图片，当传递了需要数据的图片时，加载完成后自动替换图片
		 * @param size 需要的图片的尺寸
		 * @param callback function():void
		 * @param needDefault 是否显示默认的问号
		 */
		public static function getBmd(url:String, bmp:Bitmap, size:Point = null, callback:Function = null, needDefault:Boolean = false):void
		{
			deleteBitmap(bmp); // 删除曾经的引用
			if (url == "" || !checkIsImage(url)) // 空图片，啥都不显示
			{
				bmp.bitmapData = null;
				return;
			}
			var bmdResult:BitmapData = data[url] as BitmapData;
			if (bmdResult) // 有缓存
			{
				setBmp(bmp, bmdResult, size);
				if (callback != null)
				{
					callback();
				}
			}
			else
			{
				bitmaps[bmp] = url;
				if (bmps[url] == null)
				{
					bmps[url] = new Vector.<Bitmap>();
				}
				bmps[url].push(bmp);
				if (sizes[url] == null)
				{
					sizes[url] = new Vector.<Point>();
				}
				sizes[url].push(size);
				if (funs[url] == null)
				{
					funs[url] = new Vector.<Function>();
				}
				funs[url].push(callback);
				if (data[url] == null) // Loader不存在才加载，不然会自动处理
				{
					var loader:LoaderVo = new LoaderVo(url);
					data[url] = loader;
					addListener(loader);
					loader.load(new URLRequest(url), new LoaderContext(false, null, SecurityDomain.currentDomain));
				}
				if (needDefault)
				{
					setBmp(bmp, defBmdX, size);
				}
			}
		}
		
		static private function deleteBitmap(bmp:Bitmap):void
		{
			var url:String = bitmaps[bmp];
			if (url)
			{
				delete bitmaps[bmp];
				var ary:Vector.<Bitmap> = bmps[url] as Vector.<Bitmap>;
				if (ary)
				{
					var index:int = ary.indexOf(bmp);
					if (index != -1)
					{
						ary.splice(index, 1);
						sizes[url].splice(index, 1);
						funs[url].splice(index, 1);
					}
				}
			}
		}
		
		/**
		 * 检查是不是图片
		 * @param url
		 * @return
		 */
		public static function checkIsImage(url:String):Boolean
		{
			if (url)
			{
				var orgUrl:String = url.split("?")[0];
				var index:int = orgUrl.lastIndexOf(".");
				if (index != -1)
				{
					var ext:String = url.substring(index).toLowerCase();
					if (ext == ".jpg" || ext == ".png" || ext == ".swf")
					{
						return true;
					}
				}
			}
			return false;
		}
		
		private static function setBmp(bmp:Bitmap, bmd:BitmapData, size:Point = null):void
		{
			bmp.smoothing = true;
			bmp.bitmapData = bmd;
			if (size && size.x != 0 && size.y != 0)
			{
				bmp.width = size.x;
				bmp.height = size.y;
				bmp.smoothing = size.x != bmd.width || size.y != bmd.height;
			}
			else
			{
				bmp.smoothing = false;
			}
		}
		
		private static function completeHandler(e:Event):void
		{
			var info:LoaderInfo = e.currentTarget as LoaderInfo;
			clearListener(info);
			var url:String = (info.loader as LoaderVo).url;
			var obj:Bitmap;
			var bmd:BitmapData = obj.bitmapData;
			if (info.content is Bitmap)
			{
				bmd = (info.content as Bitmap).bitmapData;
			}
			else
			{
				var container:Sprite = (info.content as Sprite);
				if (container.numChildren == 1 && (container.getChildAt(0) is Bitmap))
				{
					bmd = (container.getChildAt(0) as Bitmap).bitmapData;
				}
				else
				{
					bmd = new BitmapData(container.width, container.height, true, 0);
					bmd.draw(container);
				}
			}
			data[url] = bmd;
			var tmpBmps:Vector.<Bitmap> = bmps[url] as Vector.<Bitmap>;
			var tmpSizes:Vector.<Point> = sizes[url] as Vector.<Point>;
			var tmpFuns:Vector.<Function> = funs[url] as Vector.<Function>;
			for (var i:int = 0; i < tmpBmps.length; ++i)
			{
				delete bitmaps[tmpBmps[i]];
				setBmp(tmpBmps[i], bmd, tmpSizes[i]);
				if (tmpFuns[i])
				{
					tmpFuns[i]();
				}
			}
			delete sizes[url];
			delete bmps[url];
			delete funs[url];
		}
		
		private static function errorHandler(e:Event):void
		{
			var info:LoaderInfo = e.currentTarget as LoaderInfo;
			clearListener(info);
		}
		
		static private function addListener(loader:Loader):void
		{
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		}
		
		static private function clearListener(info:LoaderInfo):void
		{
			info.removeEventListener(Event.COMPLETE, completeHandler);
			info.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		}
	}
}
