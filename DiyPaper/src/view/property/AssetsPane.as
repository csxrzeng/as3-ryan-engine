package view.property 
{
	import controller.Dispatcher;
	import controller.GameEvent;
	import flash.display.BitmapData;
	import org.aswing.event.AWEvent;
	import org.aswing.JOptionPane;
	import resource.proxy.ResourceProxy;
	import view.gui.MyAssetsPane;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class AssetsPane extends MyAssetsPane 
	{
		public function AssetsPane() 
		{
			configUI();
		}
		
		private function configUI():void 
		{
			btnBack.addEventListener(AWEvent.ACT, onBackClick);
			btnBrowse.addEventListener(AWEvent.ACT, onBrowseClick);
			btnDownload.addEventListener(AWEvent.ACT, onDownloadClick);
		}
		
		private function onBackClick(e:AWEvent):void
		{
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.ShowProperty, {winType:PropertyWin.LIBRARY}));
		}
		
		private function onBrowseClick(e:AWEvent):void 
		{
			btnBrowse.setEnabled(false);
			ResourceProxy.loadLocalImage(onLocalComplete, onLocalError, null);
		}
		
		private function onLocalComplete(bmd:BitmapData):void 
		{
			btnBrowse.setEnabled(true);
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.AddImageToPaper, bmd));
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
			ResourceProxy.loadRemoteImage(url, onRemoteComplete, onRemoteError, null);
		}
		
		private function onRemoteComplete(bmd:BitmapData):void
		{
			btnDownload.setEnabled(true);
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.AddImageToPaper, bmd));
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