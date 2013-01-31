package view.property
{
	import controller.Dispatcher;
	import controller.GameController;
	import controller.GameEvent;
	import flash.text.TextFormatAlign;
	import model.ItemVo;
	import org.aswing.event.AWEvent;
	import org.aswing.JToggleButton;
	import view.gui.StaticTextProperty;
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class StaticTextPane extends StaticTextProperty
	{
		private var toggleAlign:JToggleButton;
		
		private var _settingVo:ItemVo;
		
		public function StaticTextPane()
		{
			configUI();
		}
		
		private function configUI():void
		{
			btnStatic.setSelected(true);
			btnStatic.addEventListener(AWEvent.ACT, onStatic);
			btnSpecial.addEventListener(AWEvent.ACT, onSpecial);
			
			btnAdd.addActionListener(onAddClick);
			btnLeft.addActionListener(onAlignChange);
			btnRight.addActionListener(onAlignChange);
			btnCenter.addActionListener(onAlignChange);
			
			sliderSize.addStateListener(onTextSizeChange);
			
			settingVo = new ItemVo(ItemVo.TEXT);
		}
		
		private function onTextSizeChange(e:AWEvent):void
		{
			txtSize.setText("字号(" + sliderSize.getValue() + ")");
		}
		
		private function onAlignChange(e:AWEvent):void
		{
			setTxtAlign(e.currentTarget as JToggleButton);
		}
		
		private function setTxtAlign(btn:JToggleButton):void
		{
			if (toggleAlign)
			{
				toggleAlign.setSelected(false);
			}
			toggleAlign = btn;
			toggleAlign.setSelected(true);
			switch(toggleAlign)
			{
				case btnLeft:
					_settingVo.align = TextFormatAlign.LEFT;
					break;
					
				case btnCenter:
					_settingVo.align = TextFormatAlign.CENTER;
					break;
					
				case btnRight:
					_settingVo.align = TextFormatAlign.RIGHT;
					break;
			}
		}
		
		private function onAddClick(e:AWEvent):void
		{
			GameController.paper.addText(_settingVo);
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
				switch(_settingVo.align)
				{
					case TextFormatAlign.LEFT:
						setTxtAlign(btnLeft);
						break;
					case TextFormatAlign.CENTER:
						setTxtAlign(btnCenter);
						break;
					case TextFormatAlign.RIGHT:
						setTxtAlign(btnRight);
						break;
				}
				btnBold.setSelected(_settingVo.bold);
				btnItalic.setSelected(_settingVo.italic);
				btnUnderline.setSelected(_settingVo.underline);
				sliderSize.setValue(_settingVo.size);
				sliderBlur.setValue(_settingVo.glowFilter.blurX);
				sliderBlurAlpha.setValue(_settingVo.glowFilter.alpha * 100);
				
				sliderDrop.setValue(_settingVo.shadowFilter.blurX);
				sliderDropAlpha.setValue(_settingVo.shadowFilter.alpha * 100);
				sliderDropAngle.setValue(_settingVo.shadowFilter.angle);
				sliderDropDistance.setValue(_settingVo.shadowFilter.distance);
			}
		}
	}
}