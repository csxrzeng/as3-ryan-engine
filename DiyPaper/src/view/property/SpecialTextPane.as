package view.property
{
	import controller.Dispatcher;
	import controller.GameController;
	import controller.GameEvent;
	import flash.events.FocusEvent;
	import model.Cache;
	import model.FontVo;
	import model.ItemVo;
	import org.aswing.ASColor;
	import org.aswing.event.AWEvent;
	import org.aswing.event.ColorChooserEvent;
	import org.aswing.JOptionPane;
	import org.aswing.VectorListModel;
	import resource.proxy.ResourceProxy;
	import resource.proxy.SwfFileVo;
	import utils.ColorUtil;
	import view.gui.SpecialTextProperty;
	import view.MainWindow;
	import view.paper.IItemView;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class SpecialTextPane extends SpecialTextProperty
	{
		private var _settingVo:ItemVo;
		private var _isAdd:Boolean = true;
		
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
			btnDelete.addEventListener(AWEvent.ACT, onDelete);
			colormixer.addEventListener(ColorChooserEvent.COLOR_ADJUSTING, onColorAdjusting);
			
			var model:VectorListModel = new VectorListModel(Cache.instance.font.getSpecialFontList());
			combobox.setModel(model);
			combobox.setSelectedIndex(0);
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
		
		private function onColorAdjusting(e:ColorChooserEvent):void
		{
			var color:ASColor = e.getColor();
			//trace("开始：", color);
			_settingVo.colorTransform = ColorUtil.color2ColorTransform(color, 100);
			dispachPropertyChange();
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
		
		private function onDelete(e:AWEvent):void
		{
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.DeleteSelectedItem, _settingVo));
		}
		
		private function onAdd(e:AWEvent):void
		{
			var text:String = txtInput.getText();
			if (text == "")
			{
				return; // 不允许空字符
			}
			var vo:FontVo = combobox.getSelectedItem();
			if (vo)
			{
				_settingVo.text = txtInput.getText();
				_settingVo.font = vo.font;
				var curVo:ItemVo = _settingVo;
				if (_isAdd)
				{
					_settingVo.colorTransform = ColorUtil.color2ColorTransform(colormixer.getSelectedColor(), 100);
					_settingVo = new ItemVo(ItemVo.SPECIAL_TEXT);
				}
				ResourceProxy.loadFont(vo, onFontComplete, onFontError, curVo);
			}
		}
		
		private function onFontComplete(swfVo:SwfFileVo):void
		{
			var vo:ItemVo = swfVo.extData as ItemVo;
			var item:IItemView = MainWindow.paper.getItemView(vo);
			if (!item)
			{
				GameController.paper.addItem(vo);
			}
			else
			{
				Dispatcher.dispatchEvent(new GameEvent(GameEvent.UpdateSelectItem, vo));
			}
		}
		
		private function onFontError(text:String):void
		{
			JOptionPane.showMessageDialog("下载字体失败", text);
		}
		
		public function get settingVo():ItemVo
		{
			return _settingVo;
		}
		
		private function dispachPropertyChange():void
		{
			if (!_isAdd)
			{
				Dispatcher.dispatchEvent(new GameEvent(GameEvent.UpdateSelectItem, _settingVo));
			}
		}
		
		public function set settingVo(value:ItemVo):void
		{
			if (!value)
			{
				value = new ItemVo(ItemVo.SPECIAL_TEXT);
				btnAdd.setText("添加文字");
				btnDelete.setVisible(false);
				_isAdd = true;
			}
			else
			{
				btnAdd.setText("编辑文字");
				btnDelete.setVisible(true);
				_isAdd = false;
			}
			_settingVo = value;
			if (_settingVo)	//根据VO设置按钮和文本的状态
			{
				combobox.setSelectedItem(Cache.instance.font.getSpecialFontByFont(_settingVo.font));
				txtInput.setText(_settingVo.text);
				colormixer.setSelectedColor(ColorUtil.transform2Color(_settingVo.colorTransform));
				//trace("结束：", ColorUtil.transform2Color(_settingVo.colorTransform));
			}
		}
	}
}