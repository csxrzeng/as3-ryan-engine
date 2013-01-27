package view.toolbar 
{
	import com.ryan.global.Global;
	import controller.Dispatcher;
	import controller.GameEvent;
	import flash.display.StageDisplayState;
	import org.aswing.event.AWEvent;
	import view.gui.PropertyBar;
	import view.property.PropertyWin;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class PropertyBarWin extends PropertyBar 
	{
		
		public function PropertyBarWin() 
		{
			super();
			configEvents();
		}
		
		public function setButtonType(data:*):void 
		{
			btnBase.setSelected(false)
			btnImage.setSelected(false)
			btnText.setSelected(false)
			switch (data)
			{
				case PropertyWin.BASE:
					btnBase.setSelected(true);
					break;
				case PropertyWin.IMAGE:
				case PropertyWin.LIBRARY:
				case PropertyWin.ASSETS:
					btnImage.setSelected(true);
					break;
				case PropertyWin.SPECIAL_TEXT:
				case PropertyWin.STATIC_TEXT:
					btnText.setSelected(true);
					break;
			}
		}
		
		private function configEvents():void 
		{
			btnBase.addEventListener(AWEvent.ACT, onBaseAction);
			btnText.addEventListener(AWEvent.ACT, onTextAction);
			btnImage.addEventListener(AWEvent.ACT, onImageAction);
			btnFullscreen.addEventListener(AWEvent.ACT, onFullscreenAction);
		}
		
		private function onBaseAction(e:AWEvent):void 
		{
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.ShowProperty, PropertyWin.BASE));
		}
		
		private function onTextAction(e:AWEvent):void 
		{
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.ShowProperty, PropertyWin.SPECIAL_TEXT));
		}
		
		private function onImageAction(e:AWEvent):void 
		{
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.ShowProperty, PropertyWin.LIBRARY));
		}
		
		private function onFullscreenAction(e:AWEvent):void 
		{
			if (Global.stage.displayState == StageDisplayState.NORMAL)
			{
				Global.stage.displayState = StageDisplayState.FULL_SCREEN;
				btnFullscreen.setText("普通");
			}
			else
			{
				Global.stage.displayState = StageDisplayState.NORMAL;
				btnFullscreen.setText("全屏");
			}
		}
	}
}