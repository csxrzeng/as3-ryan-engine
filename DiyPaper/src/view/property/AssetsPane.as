package view.property 
{
	import com.ryan.resource.info.ImageInfo;
	import com.ryan.resource.LoaderManager;
	import controller.Dispatcher;
	import controller.GameEvent;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.FileReference;
	import org.aswing.event.AWEvent;
	import org.aswing.JOptionPane;
	import view.gui.MyAssetsPane;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class AssetsPane extends MyAssetsPane 
	{
		private var file:FileReference;
		
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
			file.addEventListener(ProgressEvent.PROGRESS, onProgress);
			btnBack.addEventListener(AWEvent.ACT, onBackClick);
			btnBrowse.addEventListener(AWEvent.ACT, onBrowseClick);
			btnDownload.addEventListener(AWEvent.ACT, onDownloadClick);
		}
		
		private function onUploadCompleteData(e:DataEvent):void 
		{
			
		}
		
		private function onUploadComplete(e:Event):void 
		{
			
		}
		
		private function onFileSelect(e:Event):void 
		{
			
		}
		
		private function onCancel(e:Event):void 
		{
			
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			
		}
		
		private function onProgress(e:ProgressEvent):void 
		{
			
		}
		
		private function onBackClick(e:AWEvent):void
		{
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.ShowProperty, PropertyWin.LIBRARY));
		}
		
		private function onBrowseClick(e:AWEvent):void 
		{
			
		}
		
		private function onDownloadClick(e:AWEvent):void 
		{
			var url:String = txtDownload.getText();
			var reg:RegExp = new RegExp("http\:\/\/[a-zA-z0-9./]+\.(jpg)|(png)", "i");
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