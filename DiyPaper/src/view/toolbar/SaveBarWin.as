package view.toolbar 
{
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
		}
		
		private function configEvents():void 
		{
			btnPreview.addActionListener(onPreviewAction);
			btnLink.addActionListener(onLinkAction);
		}
		
		private function onPreviewAction(e:AWEvent):void 
		{
			
		}
		
		private function onLinkAction(e:AWEvent):void 
		{
			
		}
		
	}

}