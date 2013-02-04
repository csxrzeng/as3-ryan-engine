package controller
{
	import view.MainWindow;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class SystemController extends Controller
	{
		public function SystemController()
		{
		}
		
		override protected function initServer():void
		{
			Dispatcher.addEventListener(GameEvent.ShowNormal, onShowNormal);
			Dispatcher.addEventListener(GameEvent.ShowPreview, onShowPreview);
		}
		
		private function onShowNormal(e:GameEvent):void
		{
			MainWindow.toolBar.setVisible(true);
			MainWindow.mapLayer.setVisible(true);
			MainWindow.layerWin.show();
			MainWindow.propertyWin.show();
			MainWindow.previewWin.setVisible(false);
		}
		
		private function onShowPreview(e:GameEvent):void
		{
			MainWindow.toolBar.setVisible(false);
			MainWindow.mapLayer.setVisible(false);
			MainWindow.layerWin.hide();
			MainWindow.propertyWin.hide();
			MainWindow.previewWin.setVisible(true);
		}
	}
}