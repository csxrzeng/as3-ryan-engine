package view.property 
{
	import controller.Dispatcher;
	import controller.GameController;
	import controller.GameEvent;
	import flash.events.MouseEvent;
	import model.ItemVo;
	import org.aswing.ASColor;
	import org.aswing.event.AWEvent;
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
			_color = e.getColor();
			_settingVo.colorTransform = ColorUtil.color2ColorTransform(_color, sliderColor.getValue() / 100);
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.UpdateSelectItem, _settingVo));
		}
		
		private function onSliderColor(e:InteractiveEvent):void 
		{
			_color = colorMixer.getSelectedColor();
			_settingVo.colorTransform = ColorUtil.color2ColorTransform(_color, sliderColor.getValue() / 100);
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.UpdateSelectItem, _settingVo));
		}
		
		private function onSliderAlpha(e:InteractiveEvent):void 
		{
			_color = colorMixer.getSelectedColor();
			_color = _color.changeAlpha(sliderAlpha.getValue() / 100);
			colorMixer.setSelectedColor(_color);
			_settingVo.colorTransform = ColorUtil.color2ColorTransform(_color, sliderColor.getValue() / 100);
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.UpdateSelectItem, _settingVo));
		}
		
		private function onSliderRotation(e:InteractiveEvent):void 
		{
			_settingVo.rotation = sliderRotation.getValue();
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.UpdateSelectItem, _settingVo));
		}
		
		private function update():void
		{
			var rgb:uint = _settingVo.colorTransform.color;
			var alpha:int = (_settingVo.colorTransform.alphaOffset + 255) * 100 / 255;
			_color = new ASColor(rgb, alpha / 100);
			
			colorMixer.setSelectedColor(_color);
			
			var multi:int = _settingVo.colorTransform.redMultiplier * 100;
			
			txtColor.setText("变色(" + multi + ")");
			sliderColor.setValue(multi);
			
			txtAlpha.setText("透明(" + alpha + ")");
			sliderAlpha.setValue(alpha);
			
			txtRotation.setText("旋转(" + _settingVo.rotation + "°)");
			sliderRotation.setValue(_settingVo.rotation);
		}
	}
}