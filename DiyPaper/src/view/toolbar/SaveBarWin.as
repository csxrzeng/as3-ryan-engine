package view.toolbar
{
	import org.aswing.event.AWEvent;
	import view.gui.SaveBar;
	import view.MainWindow;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class SaveBarWin extends SaveBar
	{
		
		public function SaveBarWin()
		{
			super();
			configEvents();
		}
		
		private function configEvents():void
		{
			btnPreview.addActionListener(onPreviewAction);
			btnLink.addActionListener(onLinkAction);
		}
		
		private function onPreviewAction(e:AWEvent):void
		{
			MainWindow.previewWin.previewPaper(MainWindow.paper);
			MainWindow.instance.getContentPane().append(MainWindow.previewWin);
		}
		
		private function onLinkAction(e:AWEvent):void
		{
			
		}
		
	}

}