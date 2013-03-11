package view.toolbar 
{
	import controller.Dispatcher;
	import controller.GameEvent;
	import org.aswing.event.AWEvent;
	import org.aswing.JToolBar;
	import view.gui.SaveBar;
	
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
			btnLink.visible = false;
		}
		
		private function configEvents():void 
		{
			btnPreview.addActionListener(onPreviewAction);
			btnLink.addActionListener(onLinkAction);
		}
		
		private function onPreviewAction(e:AWEvent):void 
		{
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.ShowPreview));
		}
		
		private function onLinkAction(e:AWEvent):void 
		{
			
		}
		
	}

}