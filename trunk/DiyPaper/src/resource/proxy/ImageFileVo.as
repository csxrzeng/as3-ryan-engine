package resource.proxy 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import resource.Config;
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class ImageFileVo
	{
		public var bmd:BitmapData;
		public var url:String = "";
		public var onComplete:Function;
		public var onError:Function;
		public var extData:Object;
		private var file:FileReference;
		
		public function ImageFileVo()
		{
			file = new FileReference();
			configEvents();
		}
		
		public function start():void 
		{
			file.browse([new FileFilter("图片文件(" + Config.filterType + ")", Config.filterType)]);
		}
		
		private function configEvents():void
		{
			file.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, onUploadCompleteData);
			file.addEventListener(Event.COMPLETE, onUploadComplete);
			file.addEventListener(Event.SELECT, onFileSelect);
			file.addEventListener(Event.CANCEL, onCancel);
			file.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			file.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onIOError);
			file.addEventListener(ProgressEvent.PROGRESS, onProgress);
		}
		
		private function clearEvents():void
		{
			file.removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA, onUploadCompleteData);
			file.removeEventListener(Event.COMPLETE, onUploadComplete);
			file.removeEventListener(Event.SELECT, onFileSelect);
			file.removeEventListener(Event.CANCEL, onCancel);
			file.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			file.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			file.removeEventListener(ProgressEvent.PROGRESS, onProgress);
		}
		
		private function onCancel(e:Event):void 
		{
			dealError("");
		}
		
		private function onProgress(e:ProgressEvent):void 
		{
			
		}
		
		private function onUploadCompleteData(e:DataEvent):void 
		{
			clearEvents();
			var vars:URLVariables = new URLVariables(e.data);
			if (vars.result == "1")
			{
				url = Config.MY_MEDIA_PATH + vars.file;
				ResourceProxy.loadRemoteImage(url, onRemoteComplete, onError, extData);
			}
			else
			{
				dealError("上传失败：" + vars.desc);
			}
		}
		
		private function onRemoteComplete(image:RemoteImageVo):void
		{
			bmd = image.bmd;
			if (onComplete != null)
			{
				onComplete(this);
			}
		}
		
		private function onContentComplete(display:DisplayObject):void
		{
			if (display is Bitmap)
			{
				bmd = (display as Bitmap).bitmapData;
				if (onComplete != null)
				{
					onComplete(this);
				}
			}
			else
			{
				dealError("不是图片文件");
			}
		}
		
		private function onUploadComplete(e:Event):void 
		{
			if (!Config.isAdministrator) // 非管理员模式，已经加载到内存
			{
				if (file.data.length)
				{
					clearEvents();
					Convertor.convert(file.data, onContentComplete, dealError);
				}
				else
				{
					dealError("图片大小不能为0");
				}
			}
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			dealError("上传失败：IO错误");
		}
		
		private function onSecurityError(e:SecurityErrorEvent):void
		{
			dealError("上传失败：安全沙箱错误");
		}
		
		private function onFileSelect(e:Event):void 
		{
			if (file.size > Config.MaxFileSize)
			{
				dealError("不能上传超过" + int(Config.MaxFileSize / 1024) + "K的文件");
				return;
			}
			if (Config.isAdministrator)
			{
				file.upload(new URLRequest(Config.UPLOAD_IMAGE_URL));
			}
			else
			{
				try
				{
					file.load();
				}
				catch (e:Error)
				{
					dealError(e.message);
				}
			}
		}
		
		private function dealError(text:String):void
		{
			clearEvents();
			if (onError != null)
			{
				onError(text);
			}
		}
	}
}