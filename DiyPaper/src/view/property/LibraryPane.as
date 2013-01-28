package view.property 
{
	import controller.Dispatcher;
	import controller.GameEvent;
	import org.aswing.event.AWEvent;
	import view.gui.ImageLibrary;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class LibraryPane extends ImageLibrary 
	{
		
		public function LibraryPane() 
		{
			configUI();
		}
		
		private function configUI():void 
		{
			btnOnline.setSelected(true);
			btnOnline.addEventListener(AWEvent.ACT, onOnlineClick);
			btnMyAssets.addEventListener(AWEvent.ACT, onMyAssetsClick);
		}
		
		private function onOnlineClick(e:AWEvent):void 
		{
			btnOnline.setSelected(true);
		}
		
		private function onMyAssetsClick(e:AWEvent):void 
		{
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.ShowProperty, PropertyWin.ASSETS));
		}
		
	}

}