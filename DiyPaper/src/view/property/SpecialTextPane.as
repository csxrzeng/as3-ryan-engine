package view.property
{
	import controller.Dispatcher;
	import controller.GameEvent;
	import org.aswing.event.AWEvent;
	import view.gui.SpecialTextProperty;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class SpecialTextPane extends SpecialTextProperty
	{
		
		public function SpecialTextPane()
		{
			configUI();
		}
		
		private function configUI():void
		{
			btnSpecial.setSelected(true);
			btnSpecial.addEventListener(AWEvent.ACT, onSpecial);
			btnStatic.addEventListener(AWEvent.ACT, onStatic);
			btnAdd.addEventListener(AWEvent.ACT, onAdd);
		}
		
		private function onSpecial(e:AWEvent):void
		{
			btnSpecial.setSelected(true);
		}
		
		private function onStatic(e:AWEvent):void
		{
			btnStatic.setSelected(false);
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.ShowProperty, PropertyWin.STATIC_TEXT));
		}
		
		private function onAdd(e:AWEvent):void
		{
			// 向服务器请求数据
		}
	}
}