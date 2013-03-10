package view.property
{
	import controller.Dispatcher;
	import controller.GameController;
	import controller.GameEvent;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import model.Cache;
	import model.FontVo;
	import model.ItemVo;
	import org.aswing.ASColor;
	import org.aswing.colorchooser.JColorMixer;
	import org.aswing.Component;
	import org.aswing.event.AWEvent;
	import org.aswing.event.ColorChooserEvent;
	import org.aswing.event.InteractiveEvent;
	import org.aswing.geom.IntPoint;
	import org.aswing.JPopup;
	import org.aswing.JToggleButton;
	import org.aswing.VectorListModel;
	import view.cases.ColorIcon;
	import view.gui.StaticTextProperty;
	import view.MainWindow;
	
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
		private var _isAdd:Boolean = true;
		
		public function StaticTextPane()
		{
			super();
			configUI();
		}
		
		private function configUI():void
		{
			btnLtr.setVisible(false);
			btnTtb.setVisible(false);
			
			sliderBlur.setMaximum(5);
			sliderBlurAlpha.setMaximum(100);
			
			sliderDrop.setMaximum(5);
			sliderDropAlpha.setMaximum(100);
			sliderDropAngle.setMaximum(359);
			sliderDropDistance.setMaximum(5);
			
			var listModel:VectorListModel = new VectorListModel(Cache.instance.font.getStaticFontList());
			combobox.setModel(listModel);
			combobox.setSelectedIndex(0);
			combobox.addEventListener(InteractiveEvent.SELECTION_CHANGED, onComboBoxChange);
			colorMixer = new JColorMixer();
			pop = new JPopup(MainWindow.propertyWin);
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
			txtInput.addEventListener(Event.CHANGE, onTextChange);
			btnBlur.addActionListener(onGlowColorChange);
			btnDrop.addActionListener(onShadowColorChange);
			btnColor.addEventListener(AWEvent.ACT, onColorChange);
			txtInput.addEventListener(FocusEvent.FOCUS_IN, onFocusHandler);
			txtInput.addEventListener(FocusEvent.FOCUS_OUT, onFocusHandler);
		}
		
		private function onFocusHandler(e:FocusEvent):void 
		{
			if (e.type == FocusEvent.FOCUS_IN && txtInput.getText() == ItemVo.DEFAULT_TEXT)
			{
				txtInput.setText("");
			}
			else if (e.type == FocusEvent.FOCUS_OUT && txtInput.getText() == "")
			{
				txtInput.setText(ItemVo.DEFAULT_TEXT);
			}
		}
		
		private function onComboBoxChange(e:InteractiveEvent):void
		{
			var font:FontVo = combobox.getSelectedItem();
			_settingVo.font = font.font;
			updateInputFont();
			dispachPropertyChange();
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
				_settingVo.glowFilter.alpha = color.getAlpha();
				dispachPropertyChange();
			}
			else if (mixerOwner == btnDrop)
			{
				_settingVo.shadowFilter.color = color.getRGB();
				_settingVo.shadowFilter.alpha = color.getAlpha();
				dispachPropertyChange();
			}
			else if (mixerOwner == btnColor)
			{
				_settingVo.color = color.getRGB();
				_settingVo.alpha = color.getAlpha();
				dispachPropertyChange();
			}
		}
		
		private function onShadowColorChange(e:AWEvent):void
		{
			if (mixerOwner != btnDrop)
			{
				mixerOwner = btnDrop;
				colorMixer.setSelectedColor(new ASColor(_settingVo.shadowFilter.color, _settingVo.shadowFilter.alpha));
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
				colorMixer.setSelectedColor(new ASColor(_settingVo.glowFilter.color, _settingVo.glowFilter.alpha));
				showMixer();
			}
			else
			{
				pop.hide();
			}
		}
		
		private function onColorChange(e:AWEvent):void
		{
			if (mixerOwner != btnColor)
			{
				mixerOwner = btnColor;
				colorMixer.setSelectedColor(new ASColor(_settingVo.color, _settingVo.alpha));
				showMixer();
			}
			else
			{
				pop.hide();
			}
		}
		
		private function onTextChange(e:Event):void
		{
			_settingVo.text = txtInput.getText();
			dispachPropertyChange();
		}
		
		private function onBoldChange(e:AWEvent):void
		{
			_settingVo.bold = btnBold.isSelected();
			dispachPropertyChange();
		}
		
		private function onItalicChange(e:AWEvent):void
		{
			_settingVo.italic = btnItalic.isSelected();
			dispachPropertyChange();
		}
		
		private function onUnderlineChange(e:AWEvent):void
		{
			_settingVo.underline = btnUnderline.isSelected();
			dispachPropertyChange();
		}
		
		private function onShadowDistanceChange(e:AWEvent):void
		{
			txtDropDistance.setText("距离(" + sliderDropDistance.getValue() + ")");
			_settingVo.shadowFilter.distance = sliderDropDistance.getValue();
			dispachPropertyChange();
		}
		
		private function onShadowAngleChange(e:AWEvent):void
		{
			txtDropAngle.setText("角度(" + sliderDropAngle.getValue() + ")");
			_settingVo.shadowFilter.angle = sliderDropAngle.getValue();
			dispachPropertyChange();
		}
		
		private function onShadowAlphaChange(e:AWEvent):void
		{
			txtDropAlpha.setText("透明(" + sliderDropAlpha.getValue() + ")");
			_settingVo.shadowFilter.alpha = sliderDropAlpha.getValue() / 100;
			dispachPropertyChange();
		}
		
		private function onShadowBlurChange(e:AWEvent):void
		{
			txtDrop.setText("效果(" + sliderDrop.getValue() + ")");
			_settingVo.shadowFilter.strength = _settingVo.shadowFilter.blurX = _settingVo.shadowFilter.blurY = sliderDrop.getValue();
			dispachPropertyChange();
		}
		
		private function onGlowAlphaChange(e:AWEvent):void
		{
			txtBlurAlpha.setText("透明(" + sliderBlurAlpha.getValue() + ")");
			_settingVo.glowFilter.alpha = sliderBlurAlpha.getValue() / 100;
			dispachPropertyChange();
		}
		
		private function onGlowBlurChange(e:AWEvent):void
		{
			txtBlur.setText("粗细(" + sliderBlur.getValue() + ")");
			_settingVo.glowFilter.blurX = _settingVo.glowFilter.blurY = sliderBlur.getValue();
			dispachPropertyChange();
		}
		
		private function onTextSizeChange(e:AWEvent):void
		{
			txtSize.setText("字号(" + sliderSize.getValue() + ")");
			_settingVo.size = sliderSize.getValue();
			dispachPropertyChange();
		}
		
		private function onAlignChange(e:AWEvent):void
		{
			setTxtAlign(e.currentTarget as JToggleButton);
			dispachPropertyChange();
		}
		
		private function dispachPropertyChange():void
		{
			if (!_isAdd)
			{
				Dispatcher.dispatchEvent(new GameEvent(GameEvent.UpdateSelectItem, _settingVo));
			}
		}
		
		private function setTxtAlign(btn:JToggleButton):void
		{
			if (toggleAlign)
			{
				toggleAlign.setSelected(false);
			}
			toggleAlign = btn;
			toggleAlign.setSelected(true);
			switch (toggleAlign)
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
			var text:String = txtInput.getText();
			if (text == "")
			{
				return; // 不允许空字符
			}
			if (_isAdd)
			{
				var item:ItemVo = new ItemVo(ItemVo.STATIC_TEXT);
				item.text = txtInput.getText();
				item.font = combobox.getSelectedItem();
				GameController.paper.addItem(item);
			}
			else
			{
				Dispatcher.dispatchEvent(new GameEvent(GameEvent.DeleteSelectedItem, _settingVo));
			}
		}
		
		private function onStatic(e:AWEvent):void
		{
			btnStatic.setSelected(true);
		}
		
		private function onSpecial(e:AWEvent):void
		{
			btnSpecial.setSelected(false);
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.ShowProperty, {winType: PropertyWin.SPECIAL_TEXT}));
		}
		
		public function get settingVo():ItemVo
		{
			return _settingVo;
		}
		
		public function set settingVo(value:ItemVo):void
		{
			if (!value)
			{
				value = new ItemVo(ItemVo.STATIC_TEXT);
				btnAdd.setText("添加文字");
				_isAdd = true;
			}
			else
			{
				btnAdd.setText("删除文字");
				_isAdd = false;
			}
			_settingVo = value;
			if (_settingVo) //根据VO设置按钮和文本的状态
			{
				combobox.setSelectedItem(Cache.instance.font.getStaticFontByFont(_settingVo.font));
				txtInput.setText(_settingVo.text);
				updateInputFont();
				switch (_settingVo.align)
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
				btnColor.setIcon(new ColorIcon(new ASColor(_settingVo.color, _settingVo.alpha), 16, 16));
				btnBlur.setIcon(new ColorIcon(new ASColor(_settingVo.glowFilter.color, _settingVo.glowFilter.alpha), 16, 16));
				btnDrop.setIcon(new ColorIcon(new ASColor(_settingVo.shadowFilter.color, _settingVo.shadowFilter.alpha), 16, 16));
			}
		}
		
		private function updateInputFont():void
		{
			var formate:TextFormat = txtInput.getDefaultTextFormat();
			formate.font = _settingVo.font;
			txtInput.setDefaultTextFormat(formate);
			if (txtInput.getLength())
			{
				txtInput.setTextFormat(formate, 0, txtInput.getLength());
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