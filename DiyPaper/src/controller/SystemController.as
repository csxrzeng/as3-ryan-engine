package controller
{
	import model.UserStatus;
	import org.aswing.BorderLayout;
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
			UserStatus.curStatus = UserStatus.NORMAL;
			MainWindow.instance.setPreviewShow(false);
		}
		
		private function onShowPreview(e:GameEvent):void
		{
			UserStatus.curStatus = UserStatus.PREVIEW;
			MainWindow.instance.setPreviewShow(true);
			MainWindow.previewWin.previewPaper(MainWindow.paper);
		}
	}
}