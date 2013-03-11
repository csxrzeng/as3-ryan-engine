package view.property 
{
	import controller.Dispatcher;
	import controller.GameEvent;
	import flash.display.BitmapData;
	import org.aswing.event.AWEvent;
	import org.aswing.JOptionPane;
	import resource.proxy.ImageFileVo;
	import resource.proxy.RemoteImageVo;
	import resource.proxy.ResourceProxy;
	import view.gui.MyAssetsPane;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class AssetsPane extends MyAssetsPane 
	{
		private var loading:LoadPane;
		
		public function AssetsPane() 
		{
			configUI();
		}
		
		private function configUI():void 
		{
			btnBack.addEventListener(AWEvent.ACT, onBackClick);
			btnBrowse.addEventListener(AWEvent.ACT, onBrowseClick);
			btnDownload.addEventListener(AWEvent.ACT, onDownloadClick);
			loading = new LoadPane();
		}
		
		private function onBackClick(e:AWEvent):void
		{
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.ShowProperty, {winType:PropertyWin.LIBRARY}));
		}
		
		private function onBrowseClick(e:AWEvent):void 
		{
			btnBrowse.setEnabled(false);
			ResourceProxy.loadLocalImage(onLocalComplete, onLocalError, null, onProgress);
		}
		
		private function onProgress(cur:Number, total:Number):void 
		{
			if (!loading.isShowing())
			{
				append(loading);
				loading.show();
			}
			loading.setProgress(cur, total, "正在加载图片：");
		}
		
		private function onLocalComplete(image:ImageFileVo):void 
		{
			loading.hide();
			btnBrowse.setEnabled(true);
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.AddImageToPaper, image));
		}
		
		private function onLocalError(text:String):void
		{
			btnBrowse.setEnabled(true);
			dealError(text);
		}
		
		private function onDownloadClick(e:AWEvent):void 
		{
			btnDownload.setEnabled(false);
			var url:String = txtDownload.getText();
			ResourceProxy.loadRemoteImage(url, onRemoteComplete, onRemoteError, null, onProgress);
		}
		
		private function onRemoteComplete(image:RemoteImageVo):void
		{
			loading.hide();
			var imageFile:ImageFileVo = new ImageFileVo();
			imageFile.bmd = image.bmd;
			imageFile.url = image.url;
			btnDownload.setEnabled(true);
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.AddImageToPaper, imageFile));
		}
		
		private function onRemoteError(text:String):void
		{
			btnDownload.setEnabled(true);
			dealError(text);
		}
		
		private function dealError(text:String):void
		{
			if (text)
			{
				JOptionPane.showMessageDialog("错误", text);
			}
		}
	}
}