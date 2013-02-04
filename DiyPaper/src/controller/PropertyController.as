package controller
{
	import model.ItemVo;
	import model.UserStatus;
	import view.MainWindow;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class PropertyController extends Controller
	{
		public function PropertyController()
		{
		}
		
		override protected function initServer():void
		{
			Dispatcher.addEventListener(GameEvent.ShowProperty, showPropertyWin);
			Dispatcher.addEventListener(GameEvent.BasePropertyChange, basePropertyChange);
			Dispatcher.addEventListener(GameEvent.UpdateSelectItem, onSelectedItemUpdate);
		}
		
		private function onSelectedItemUpdate(e:GameEvent):void
		{
			MainWindow.propertyWin.update(e.data);
		}
		
		private function basePropertyChange(e:GameEvent):void
		{
			for (var key:String in e.data)
			{
				cache.paper[key] = e.data[key];
			}
			MainWindow.paper.updateBase();
		}
		
		private function showPropertyWin(e:GameEvent):void
		{
			if (UserStatus.curStatus == UserStatus.NORMAL)
			{
				var winType:int = e.data.winType;
				var vo:ItemVo = e.data.vo;
				MainWindow.toolBar.propertyBar.setButtonType(winType);
				MainWindow.propertyWin.setType(winType, vo);
			}
		}
	}
}