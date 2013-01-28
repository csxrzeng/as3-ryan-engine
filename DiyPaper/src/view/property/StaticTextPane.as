package view.property 
{
	import controller.Dispatcher;
	import controller.GameEvent;
	import org.aswing.event.AWEvent;
	import view.gui.StaticTextProperty;
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class StaticTextPane extends StaticTextProperty
	{
		
		public function StaticTextPane() 
		{
			configUI();
		}
		
		private function configUI():void 
		{
			btnStatic.setSelected(true);
			btnStatic.addEventListener(AWEvent.ACT, onStatic);
			btnSpecial.addEventListener(AWEvent.ACT, onSpecial);
		}
		
		private function onStatic(e:AWEvent):void 
		{
			btnStatic.setSelected(true);
		}
		
		private function onSpecial(e:AWEvent):void 
		{
			btnSpecial.setSelected(false);
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.ShowProperty, PropertyWin.SPECIAL_TEXT));
		}
		
	}

}