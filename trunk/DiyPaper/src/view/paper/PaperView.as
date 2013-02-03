package view.paper
{
	import com.greensock.events.TransformEvent;
	import com.greensock.transform.TransformManager;
	import com.ryan.utils.ArrayUtil;
	import controller.Dispatcher;
	import controller.GameEvent;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import model.Cache;
	import model.ItemVo;
	import model.PaperVo;
	import org.aswing.border.EmptyBorder;
	import org.aswing.border.LineBorder;
	import org.aswing.CenterLayout;
	import org.aswing.EmptyLayout;
	import org.aswing.geom.IntDimension;
	import org.aswing.Insets;
	import org.aswing.JPanel;
	import view.MainWindow;
	import view.property.PropertyWin;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class PaperView extends JPanel
	{
		private var _vo:PaperVo;
		private var _list:Vector.<IItemView> = new Vector.<IItemView>();
		private var _tool:TransformManager;
		private var _perfersize:IntDimension;
		private var _paper:JPanel;
		private var _bg:Shape;
		private var itemViewContainer:Sprite;
		
		private var selectedItem:IItemView;
		
		public function PaperView()
		{
			setBorder(new EmptyBorder(null, new Insets(100, 150, 100, 150)));
			setClipMasked(false);
			setLayout(new CenterLayout());
			_vo = Cache.instance.paper;
			_perfersize = new IntDimension(_vo.width, _vo.height);
			_paper = new JPanel(new EmptyLayout());
			_paper.setOpaque(true);
			_paper.setClipMasked(false);
			_bg = new Shape();
			_paper.addChild(_bg);
			itemViewContainer = new Sprite();
			_paper.addChild(itemViewContainer);
			append(_paper);
			_tool = new TransformManager();
			_tool.forceSelectionToFront = false;
			_tool.autoDeselect = false;
			_tool.allowMultiSelect = false;
			_tool.addEventListener(TransformEvent.SELECTION_CHANGE, onSelectChange);
			addEventListener(MouseEvent.CLICK, onMouseClick);
			updateBase();
			
			Dispatcher.addEventListener(GameEvent.STATIC_TEXT_PROPERTY_CHANGE, onStaticTextPropertyChange);
			Dispatcher.addEventListener(GameEvent.UP_LAYER, onItemLayerChange);
			Dispatcher.addEventListener(GameEvent.DOWN_LAYER, onItemLayerChange);
		}
		
		public function updateBase():void
		{
			_perfersize.setSizeWH(_vo.width, _vo.height);
			_paper.setPreferredSize(_perfersize);
			_paper.setBackground(_vo.background);
			_paper.setBorder(new LineBorder(null, _vo.background, 1));
			_bg.graphics.clear();
			if (_vo.border > 0)
			{
				_bg.graphics.beginFill(_vo.borderColor.getRGB(), _vo.borderColor.getAlpha());
				_bg.graphics.drawRect(0, 0, _vo.width, _vo.height);
				_bg.graphics.drawRect(_vo.border, _vo.border, _vo.width - _vo.border * 2, _vo.height - _vo.border * 2);
			}
			_bg.graphics.endFill();
		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			if (e.target == _paper)
			{
				_tool.deselectAll();
			}
		}
		
		private function onSelectChange(e:TransformEvent):void
		{
			if (_tool.selectedTargetObjects.length > 0) // 暂时只处理一个的情况
			{
				selectedItem = _tool.selectedTargetObjects[0] as IItemView;
				var winType:int = getPropertyWinType(selectedItem.vo.type);
				Dispatcher.dispatchEvent(new GameEvent(GameEvent.ShowProperty, {winType:winType, vo:selectedItem.vo}));
			}
			else
			{
				Dispatcher.dispatchEvent(new GameEvent(GameEvent.ShowProperty, {winType:PropertyWin.BASE}));
			}
		}
		
		private function getPropertyWinType(type:String):int
		{
			switch (type)
			{
				case ItemVo.IMAGE:
					return PropertyWin.IMAGE;
				case ItemVo.SPECIAL_TEXT:
					return PropertyWin.SPECIAL_TEXT;
				case ItemVo.STATIC_TEXT:
					return PropertyWin.STATIC_TEXT;
			}
			return PropertyWin.BASE;
		}
		
		/**
		 * 静态文本属性面板的设置发生改变
		 * @param	e
		 */
		private function onStaticTextPropertyChange(e:GameEvent):void
		{
			if (selectedItem && selectedItem is StaticTextView)
			{
				selectedItem.vo = e.data as ItemVo;
			}
		}
		
		private function onItemLayerChange(e:GameEvent):void
		{
			var vo:ItemVo = e.data as ItemVo;
			var item:DisplayObject = itemViewContainer.getChildAt(vo.layer);
			var index:int = itemViewContainer.getChildIndex(item);
			if (e.type == GameEvent.UP_LAYER)
			{
				itemViewContainer.setChildIndex(item, index + 1);
			}
			else
			{
				itemViewContainer.setChildIndex(item, index - 1);
			}
		}
		
		public function getVo():PaperVo
		{
			_vo.width = _perfersize.width;
			_vo.height = _perfersize.height;
			_vo.items.length = 0;
			for (var i:int = 0; i < _list.length; i++)
			{
				_vo.items.push(_list[i].vo);
			}
			return _vo;
		}
		
		public function setVo(value:PaperVo):void
		{
			_tool.removeAllItems();
			for (var i:int = 0; i < _list.length; i++)
			{
				removeChild(_list[i] as DisplayObject);
			}
			_list.length = 0;
			_vo = value;
			_perfersize.setSizeWH(_vo.width, _vo.height);
			setPreferredSize(_perfersize);
			for (var j:int = 0; j < _vo.items.length; j++)
			{
				var item:ItemVo = _vo.items[j];
				addItem(item);
			}
		}
		
		private function addImage(vo:ItemVo):void
		{
			var image:ImageView = new ImageView();
			image.item = _tool.addItem(image);
			itemViewContainer.addChild(image);
			_list.push(image);
			image.vo = vo;
		}
		
		private function addText(vo:ItemVo):void
		{
			var text:TextView = new TextView();
			text.item = _tool.addItem(text);
			itemViewContainer.addChild(text);
			_list.push(text);
			text.vo = vo;
		}
		
		private function addStaticText(vo:ItemVo):void
		{
			var text:StaticTextView = new StaticTextView();
			text.item = _tool.addItem(text, TransformManager.SCALE_WIDTH_AND_HEIGHT, true);
			text.item.lockRotation = true;
			itemViewContainer.addChild(text);
			_list.push(text);
			text.vo = vo;
		}
		
		public function addItem(vo:ItemVo):void
		{
			if (vo.type == ItemVo.IMAGE)
			{
				addImage(vo);
			}
			else if (vo.type == ItemVo.SPECIAL_TEXT)
			{
				addText(vo);
			}
			else if (vo.type == ItemVo.STATIC_TEXT)
			{
				addStaticText(vo);
			}
			else
			{
				throw new ArgumentError("item type error");
			}
			MainWindow.layerWin.addLayer(vo);
			setItemSelected(vo);
		}
		
		/**
		 * 选中某个对象
		 * @param	vo
		 */
		public function setItemSelected(vo:ItemVo):void
		{
			if (selectedItem)
			{
				_tool.deselectItem(selectedItem);
			}
			var index:int = indexOf(vo);
			if (index != -1)
			{
				_tool.selectItem(_list[index]);
			}
		}
		
		public function get SeletedItemView():IItemView
		{
			return selectedItem;
		}
		
		/**
		 * 更新对象
		 * @param	data
		 */
		public function updateItem(data:ItemVo):void
		{
			if (selectedItem.vo == data)
			{
				selectedItem.update();
			}
		}
		
		/**
		 * 删除选中对象
		 * @param	data
		 */
		public function removeSelectedItem(data:*):void
		{
			if (selectedItem && selectedItem.vo == data)
			{
				_tool.removeItem(selectedItem);
				ArrayUtil.removeItem(_list, selectedItem);
				var obj:DisplayObject = selectedItem as DisplayObject;
				if (obj && obj.parent == _paper)
				{
					_paper.removeChild(obj);
				}
			}
		}
		
		private function indexOf(data:ItemVo):int
		{
			for (var i:int = 0; i < _list.length; i++)
			{
				if (_list[i].vo == data)
				{
					return i;
				}
			}
			return -1;
		}
	}
}