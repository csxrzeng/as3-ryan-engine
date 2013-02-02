package view.property 
{
	import com.ryan.debug.Log;
	import com.ryan.resource.info.ImageInfo;
	import com.ryan.resource.LoaderManager;
	import controller.Dispatcher;
	import controller.GameEvent;
	import flash.events.DataEvent;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import org.aswing.event.AWEvent;
	import org.aswing.JOptionPane;
	import resource.Config;
	import view.gui.MyAssetsPane;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class AssetsPane extends MyAssetsPane 
	{
		static private const MaxFileSize:int = 500 * 1024; // 500K
		private var file:FileReference;
		private var timerId:int;
		
		public function AssetsPane() 
		{
			configUI();
		}
		
		private function configUI():void 
		{
			file = new FileReference();
			file.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, onUploadCompleteData);
			file.addEventListener(Event.COMPLETE, onUploadComplete);
			file.addEventListener(Event.SELECT, onFileSelect);
			file.addEventListener(Event.CANCEL, onCancel);
			file.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			file.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onIOError);
			file.addEventListener(ProgressEvent.PROGRESS, onProgress);
			btnBack.addEventListener(AWEvent.ACT, onBackClick);
			btnBrowse.addEventListener(AWEvent.ACT, onBrowseClick);
			btnDownload.addEventListener(AWEvent.ACT, onDownloadClick);
		}
		
		private function onUploadCompleteData(e:DataEvent):void 
		{
			clearTimer();
			btnBrowse.setEnabled(true);
			// do something
			var vars:URLVariables = new URLVariables(e.data);
			if (vars.result == "1")
			{
				//JOptionPane.showMessageDialog("上传成功", "图片上传成功");
				var file:String = vars.file;
				LoaderManager.instance.load(Config.MY_MEDIA_PATH + file, onImgLoaded);
			}
			else
			{
				JOptionPane.showMessageDialog("上传失败", vars.desc);
			}
		}
		
		private function onUploadComplete(e:Event):void 
		{
		}
		
		private function onIOError(e:ErrorEvent):void 
		{
			clearTimer();
			JOptionPane.showMessageDialog("上传失败", "服务器错误");
			Log.error("图片上传失败：", e.text);
			btnBrowse.setEnabled(true);
		}
		
		private function onFileSelect(e:Event):void 
		{
			if (file.size > MaxFileSize)
			{
				JOptionPane.showMessageDialog("错误", "不能上传超过500K的文件");
				return;
			}
			btnBrowse.setEnabled(false);
			file.upload(new URLRequest(Config.UPLOAD_IMAGE_URL));
			timerId = setTimeout(onTimeout, 30000);
		}
		
		private function onTimeout():void 
		{
			clearTimer();
			JOptionPane.showMessageDialog("错误", "上传超时，请检查网络是否通畅");
			file.cancel();
			btnBrowse.setEnabled(true);
		}
		
		private function clearTimer():void
		{
			if (timerId)
			{
				clearTimeout(timerId);
				timerId = 0;
			}
		}
		
		private function onCancel(e:Event):void 
		{
			btnBrowse.setEnabled(true);
		}
		
		private function onProgress(e:ProgressEvent):void 
		{
			
		}
		
		private function onBackClick(e:AWEvent):void
		{
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.ShowProperty, {winType:PropertyWin.LIBRARY}));
		}
		
		private function onBrowseClick(e:AWEvent):void 
		{
			file.browse([new FileFilter("图片文件(*.jpg;*.png)", "*.jpg;*.png")]);
		}
		
		private function onDownloadClick(e:AWEvent):void 
		{
			var url:String = txtDownload.getText();
			var reg:RegExp = new RegExp("http\:\/\/.+\.(jpg)|(png)", "i");
			if (!reg.test(url))
			{
				JOptionPane.showMessageDialog("错误", "只能加载jpg与png类型的网络图片");
				return;
			}
			LoaderManager.instance.load(url, onImgLoaded);
		}
		
		private function onImgLoaded(info:ImageInfo):void
		{
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.AddImageToPaper, info.bitmapData));
		}
	}
}