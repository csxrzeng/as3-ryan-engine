package view.property
{
	import controller.Dispatcher;
	import controller.GameController;
	import controller.GameEvent;
	import flash.text.TextFormatAlign;
	import model.ItemVo;
	import org.aswing.ASColor;
	import org.aswing.colorchooser.JColorMixer;
	import org.aswing.Component;
	import org.aswing.event.AWEvent;
	import org.aswing.event.ColorChooserEvent;
	import org.aswing.geom.IntPoint;
	import org.aswing.JPopup;
	import org.aswing.JToggleButton;
	import view.cases.ColorIcon;
	import view.gui.StaticTextProperty;
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class StaticTextPane extends StaticTextProperty
	{
		private var toggleAlign:JToggleButton;
		private var pop:JPopup;
		private var colorMixer:JColorMixer;
		private var mixerOwner:Component;
		
		private var _settingVo:ItemVo;
		
		public function StaticTextPane()
		{
			configUI();
		}
		
		private function configUI():void
		{
			colorMixer = new JColorMixer();
			pop = new JPopup(this);
			pop.append(colorMixer);
			colorMixer.setOpaque(true);
			colorMixer.setBackground(new ASColor(0xeeeeee, 1));
			pop.pack();
			
			colorMixer.addEventListener(ColorChooserEvent.COLOR_ADJUSTING, onColorAdjusting);
			pop.addEventListener(AWEvent.HIDDEN, onPopHidden);
			
			btnStatic.setSelected(true);
			btnStatic.addEventListener(AWEvent.ACT, onStatic);
			btnSpecial.addEventListener(AWEvent.ACT, onSpecial);
			
			btnAdd.addActionListener(onAddClick);
			btnLeft.addActionListener(onAlignChange);
			btnRight.addActionListener(onAlignChange);
			btnCenter.addActionListener(onAlignChange);
			
			btnBold.addActionListener(onBoldChange);
			btnItalic.addActionListener(onItalicChange);
			btnUnderline.addActionListener(onUnderlineChange);
			
			sliderSize.addStateListener(onTextSizeChange);
			sliderBlur.addStateListener(onGlowBlurChange);
			sliderBlurAlpha.addStateListener(onGlowAlphaChange);
			sliderDrop.addStateListener(onShadowBlurChange);
			sliderDropAlpha.addStateListener(onShadowAlphaChange);
			sliderDropAngle.addStateListener(onShadowAngleChange);
			sliderDropDistance.addStateListener(onShadowDistanceChange);
			
			txtInput.addStateListener(onTextChange);
			
			btnBlur.addActionListener(onGlowColorChange);
			btnDrop.addActionListener(onShadowColorChange);
			
			settingVo = new ItemVo(ItemVo.STATIC_TEXT);
		}
		
		private function onPopHidden(e:AWEvent):void
		{
			mixerOwner = null;
		}
		
		private function onColorAdjusting(e:ColorChooserEvent):void
		{
			var color:ASColor = e.getColor();
			if (mixerOwner == btnBlur)
			{
				_settingVo.glowFilter.color = color.getRGB();
				btnBlur.setIcon(new ColorIcon(color, 16, 16));
				Dispatcher.dispatchEvent(new GameEvent(GameEvent.STATIC_TEXT_PROPERTY_CHANGE, _settingVo));
			}
			else if (mixerOwner == btnDrop)
			{
				_settingVo.shadowFilter.color = color.getRGB();
				btnDrop.setIcon(new ColorIcon(color, 16, 16));
				Dispatcher.dispatchEvent(new GameEvent(GameEvent.STATIC_TEXT_PROPERTY_CHANGE, _settingVo));
			}
		}
		
		private function onShadowColorChange(e:AWEvent):void
		{
			if (mixerOwner != btnDrop)
			{
				mixerOwner = btnDrop;
				colorMixer.setSelectedColor(new ASColor(_settingVo.shadowFilter.color));
				showMixer();
			}
			else
			{
				pop.hide();
			}
		}
		
		private function onGlowColorChange(e:AWEvent):void
		{
			if (mixerOwner != btnBlur)
			{
				mixerOwner = btnBlur;
				colorMixer.setSelectedColor(new ASColor(_settingVo.glowFilter.color));
				showMixer();
			}
			else
			{
				pop.hide();
			}
		}
		
		private function onTextChange(e:AWEvent):void
		{
			_settingVo.text = txtInput.getText();
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.STATIC_TEXT_PROPERTY_CHANGE, _settingVo));
		}
		
		private function onBoldChange(e:AWEvent):void
		{
			_settingVo.bold = btnBold.isSelected();
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.STATIC_TEXT_PROPERTY_CHANGE, _settingVo));
		}
		
		private function onItalicChange(e:AWEvent):void
		{
			_settingVo.italic = btnItalic.isSelected();
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.STATIC_TEXT_PROPERTY_CHANGE, _settingVo));
		}
		
		private function onUnderlineChange(e:AWEvent):void
		{
			_settingVo.underline = btnUnderline.isSelected();
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.STATIC_TEXT_PROPERTY_CHANGE, _settingVo));
		}
		
		private function onShadowDistanceChange(e:AWEvent):void
		{
			txtDropDistance.setText("距离(" + sliderDropDistance.getValue() + ")");
			_settingVo.shadowFilter.distance = sliderDropDistance.getValue();
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.STATIC_TEXT_PROPERTY_CHANGE, _settingVo));
		}
		
		private function onShadowAngleChange(e:AWEvent):void
		{
			txtDropAngle.setText("角度(" + sliderDropAngle.getValue() + ")");
			_settingVo.shadowFilter.angle = sliderDropAngle.getValue();
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.STATIC_TEXT_PROPERTY_CHANGE, _settingVo));
		}
		
		private function onShadowAlphaChange(e:AWEvent):void
		{
			txtDropAlpha.setText("透明(" + sliderDropAlpha.getValue() + ")");
			_settingVo.shadowFilter.alpha = sliderDropAlpha.getValue() / 100;
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.STATIC_TEXT_PROPERTY_CHANGE, _settingVo));
		}
		
		private function onShadowBlurChange(e:AWEvent):void
		{
			txtDrop.setText("效果(" + sliderDrop.getValue() + ")");
			_settingVo.shadowFilter.strength = _settingVo.shadowFilter.blurX = _settingVo.shadowFilter.blurY = sliderDrop.getValue();
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.STATIC_TEXT_PROPERTY_CHANGE, _settingVo));
		}
		
		private function onGlowAlphaChange(e:AWEvent):void
		{
			txtBlurAlpha.setText("透明(" + sliderBlurAlpha.getValue() + ")");
			_settingVo.glowFilter.alpha = sliderBlurAlpha.getValue() / 100;
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.STATIC_TEXT_PROPERTY_CHANGE, _settingVo));
		}
		
		private function onGlowBlurChange(e:AWEvent):void
		{
			txtBlur.setText("粗细(" + sliderBlur.getValue() + ")");
			_settingVo.glowFilter.blurX = _settingVo.glowFilter.blurY = sliderBlur.getValue();
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.STATIC_TEXT_PROPERTY_CHANGE, _settingVo));
		}
		
		private function onTextSizeChange(e:AWEvent):void
		{
			txtSize.setText("字号(" + sliderSize.getValue() + ")");
			_settingVo.size = sliderSize.getValue();
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.STATIC_TEXT_PROPERTY_CHANGE, _settingVo));
		}
		
		private function onAlignChange(e:AWEvent):void
		{
			setTxtAlign(e.currentTarget as JToggleButton);
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.STATIC_TEXT_PROPERTY_CHANGE, _settingVo));
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
			GameController.paper.addItem(_settingVo);
		}
		
		private function onStatic(e:AWEvent):void
		{
			btnStatic.setSelected(true);
		}
		
		private function onSpecial(e:AWEvent):void
		{
			btnSpecial.setSelected(false);
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.ShowProperty, {winType:PropertyWin.SPECIAL_TEXT}));
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
		
		private function showMixer():void
		{
			if (mixerOwner)
			{
				var p:IntPoint = mixerOwner.getGlobalLocation();
				pop.setGlobalLocationXY(p.x + mixerOwner.width - pop.width, p.y + mixerOwner.height);
				pop.show();
			}
		}
	}
}