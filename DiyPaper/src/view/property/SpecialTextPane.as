package view.property
{
	import controller.Dispatcher;
	import controller.GameController;
	import controller.GameEvent;
	import model.ItemVo;
	import org.aswing.event.AWEvent;
	import view.gui.SpecialTextProperty;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class SpecialTextPane extends SpecialTextProperty
	{
		private var _settingVo:ItemVo;
		
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
			
			settingVo = new ItemVo(ItemVo.SPECIAL_TEXT);
		}
		
		private function onSpecial(e:AWEvent):void
		{
			btnSpecial.setSelected(true);
		}
		
		private function onStatic(e:AWEvent):void
		{
			btnStatic.setSelected(false);
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.ShowProperty, {winType:PropertyWin.STATIC_TEXT}));
		}
		
		private function onAdd(e:AWEvent):void
		{
			GameController.paper.addItem(_settingVo);
		}
		
		public function get settingVo():ItemVo
		{
			return _settingVo;
		}
		
		public function set settingVo(value:ItemVo):void
		{
			_settingVo = value;
			if (_settingVo)	//根据VO设置按钮和文本的状态
			{
				txtInput.setText(_settingVo.text);
				
				//switch(_settingVo.align)
				//{
					//case TextFormatAlign.LEFT:
						//setTxtAlign(btnLeft);
						//break;
					//case TextFormatAlign.CENTER:
						//setTxtAlign(btnCenter);
						//break;
					//case TextFormatAlign.RIGHT:
						//setTxtAlign(btnRight);
						//break;
				//}
				//btnBold.setSelected(_settingVo.bold);
				//btnItalic.setSelected(_settingVo.italic);
				//btnUnderline.setSelected(_settingVo.underline);
				//sliderSize.setValue(_settingVo.size);
				//sliderBlur.setValue(_settingVo.glowFilter.blurX);
				//sliderBlurAlpha.setValue(_settingVo.glowFilter.alpha * 100);
				//
				//sliderDrop.setValue(_settingVo.shadowFilter.blurX);
				//sliderDropAlpha.setValue(_settingVo.shadowFilter.alpha * 100);
				//sliderDropAngle.setValue(_settingVo.shadowFilter.angle);
				//sliderDropDistance.setValue(_settingVo.shadowFilter.distance);
			}
		}
	}
}