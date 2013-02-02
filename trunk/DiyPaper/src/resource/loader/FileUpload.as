package resource.loader 
{
	import flash.events.DataEvent;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	/**
	 * 未完成
	 * @author xr.zeng
	 */
	public class FileUpload 
	{
		public var fileFilter:FileFilter;
		public var file:FileReference;
		public var onCompleteData:Function;
		
		public function FileUpload() 
		{
			fileFilter = new FileFilter("图片文件（*.jpg;*.png）", "*.jpg;*.png");
			file = new FileReference();
			addListener();
		}
		
		public function uploadImage():void
		{
			file.browse(fileFilter);
		}
		
		private function addListener():void
		{
			file.addEventListener(Event.SELECT, onSelected);
			file.addEventListener(Event.COMPLETE, onComplete);
			file.addEventListener(IOErrorEvent.IO_ERROR, onError);
			file.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
			file.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, onUploadCompleteData);
		}
		
		private function clearListener():void
		{
			file.removeEventListener(Event.SELECT, onSelected);
			file.removeEventListener(Event.COMPLETE, onComplete);
			file.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			file.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
			file.removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA, onUploadCompleteData);
		}
		
		private function onSelected(e:Event):void 
		{
			file.upload(new URLRequest("upload.php"));
		}
		
		private function onUploadCompleteData(e:DataEvent):void
		{
			trace(e.data);
			if (onCompleteData != null)
			{
				onCompleteData(e.data);
			}
		}
		
		private function onComplete(e:Event):void 
		{
			
		}
		
		private function onError(e:ErrorEvent):void 
		{
			trace("文件上传失败：", e.text);
		}
	}

}