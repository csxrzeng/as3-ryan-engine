package view.property
{
	import controller.Dispatcher;
	import controller.GameEvent;
	import flash.events.MouseEvent;
	import model.ItemVo;
	import org.aswing.ASColor;
	import org.aswing.event.ColorChooserEvent;
	import org.aswing.event.InteractiveEvent;
	import utils.ColorUtil;
	import view.gui.ImageProperty;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class ImagePane extends ImageProperty
	{
		private var _settingVo:ItemVo;
		private var _color:ASColor = new ASColor();
		
		public function ImagePane()
		{
			configUI();
		}
		
		//public function get settingVo():ItemVo
		//{
			//return _settingVo;
		//}
		
		public function set settingVo(value:ItemVo):void
		{
			_settingVo = value;
			if (_settingVo)
			{
				update();
			}
		}
		
		private function configUI():void
		{
			sliderColor.setMinimum(0);
			sliderColor.setMaximum(100);
			sliderAlpha.setMinimum(0);
			sliderAlpha.setMaximum(100);
			sliderRotation.setMinimum(0);
			sliderRotation.setMaximum(359);
			btnReplace.addEventListener(MouseEvent.CLICK, onReplaceClick);
			btnDelete.addEventListener(MouseEvent.CLICK, onDeleteClick);
			colorMixer.addEventListener(ColorChooserEvent.COLOR_ADJUSTING, onColorChange);
			sliderColor.addEventListener(InteractiveEvent.STATE_CHANGED, onSliderColor);
			sliderAlpha.addEventListener(InteractiveEvent.STATE_CHANGED, onSliderAlpha);
			sliderRotation.addEventListener(InteractiveEvent.STATE_CHANGED, onSliderRotation);
		}
		
		private function onReplaceClick(e:MouseEvent):void
		{
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.ReplaceSelectedImage, _settingVo));
		}
		
		private function onDeleteClick(e:MouseEvent):void
		{
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.DeleteSelectedItem, _settingVo));
		}
		
		private function onColorChange(e:ColorChooserEvent):void
		{
			_color = colorMixer.getSelectedColor();
			_color = _color.changeAlpha(e.getColor().getAlpha());
			changeColor();
		}
		
		private function onSliderColor(e:InteractiveEvent):void
		{
			_color = colorMixer.getSelectedColor();
			_color = _color.changeAlpha(sliderAlpha.getValue() / 100);
			changeColor();
		}
		
		private function onSliderAlpha(e:InteractiveEvent):void
		{
			_color = colorMixer.getSelectedColor();
			_color = _color.changeAlpha(sliderAlpha.getValue() / 100);
			changeColor();
		}
		
		private function changeColor():void
		{
			//trace("开始：", _color, sliderColor.getValue());
			_settingVo.colorTransform = ColorUtil.color2ColorTransform(_color, sliderColor.getValue());
			//trace("变换：", ColorUtil.transform2Color(_settingVo.colorTransform), ColorUtil.transform2Multiplier(_settingVo.colorTransform));
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.UpdateSelectItem, _settingVo));
		}
		
		private function onSliderRotation(e:InteractiveEvent):void
		{
			_settingVo.rotation = sliderRotation.getValue();
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.UpdateSelectItem, _settingVo));
		}
		
		private function update():void
		{
			var multiplier:int = ColorUtil.transform2Multiplier(_settingVo.colorTransform);
			var alpha:int = ColorUtil.transform2Alpha(_settingVo.colorTransform);
			_color = ColorUtil.transform2Color(_settingVo.colorTransform);
			colorMixer.setSelectedColor(_color);

			txtColor.setText("变色(" + multiplier + ")");
			sliderColor.setValue(multiplier);
			
			txtAlpha.setText("透明(" + alpha + ")");
			sliderAlpha.setValue(alpha);
			
			txtRotation.setText("旋转(" + _settingVo.rotation + "°)");
			sliderRotation.setValue(_settingVo.rotation);
		}
	}
}