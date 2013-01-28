package view.paper
{
	import com.greensock.events.TransformEvent;
	import com.greensock.transform.TransformItem;
	import com.greensock.transform.TransformManager;
	import controller.Dispatcher;
	import controller.GameEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import model.ItemVo;
	import model.PaperVo;
	import org.aswing.ASColor;
	import org.aswing.border.LineBorder;
	import org.aswing.BorderLayout;
	import org.aswing.CenterLayout;
	import org.aswing.EmptyLayout;
	import org.aswing.geom.IntDimension;
	import org.aswing.JPanel;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class PaperView extends JPanel
	{
		private var _vo:PaperVo;
		private var _list:Array = [];
		private var _tool:TransformManager;
		private var _perfersize:IntDimension;
		private var _paper:JPanel;
		
		public function PaperView()
		{
			_vo = new PaperVo();
			_tool = new TransformManager();
			_perfersize = new IntDimension(_vo.width, _vo.height);
			_paper = new JPanel(new EmptyLayout());
			//setLayout(new CenterLayout());
			//setPreferredSize(new IntDimension(1000, 500));
			append(_paper);
			setClipMasked(false);
			//setOpaque(true);
			//setBackground(new ASColor(0xDDDDDD, 1));
			_paper.setOpaque(true);
			_paper.setBackground(new ASColor(0xFFFFFF, 1));
			_paper.setClipMasked(false);
			_paper.setPreferredSize(_perfersize);
			_tool.forceSelectionToFront = false;
			_tool.autoDeselect = false;
			_tool.addEventListener(TransformEvent.SELECTION_CHANGE, onSelectChange);
			addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		private function onMouseClick(e:MouseEvent):void 
		{
			if (e.target == this)
			{
				_tool.deselectAll();
			}
		}
		
		private function onSelectChange(e:TransformEvent):void
		{
			if (e.items.length > 0) // 暂时只处理一个的情况
			{
				var item:TransformItem = e.items[0];
				Dispatcher.dispatchEvent(new GameEvent(GameEvent.ShowProperty, item));
			}
			else
			{
				Dispatcher.dispatchEvent(new GameEvent(GameEvent.ShowProperty));
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
			vo.type = ItemVo.IMAGE;
			image.vo = vo;
			_paper.addChild(image);
			_list.push(image);
			_tool.addItem(image);
		}
		
		private function addText(vo:ItemVo):void
		{
			var text:TextView = new TextView();
			vo.type = ItemVo.TEXT;
			text.vo = vo;
			_paper.addChild(text);
			_list.push(text);
			_tool.addItem(text, TransformManager.SCALE_WIDTH_AND_HEIGHT, true);
		}
		
		/**
		 * 删除对象
		 * @param	vo
		 */
		public function removeItem(vo:ItemVo):void
		{
			for (var i:int = 0; i < _list.length; i++) 
			{
				if (_list[i].vo == vo)
				{
					_tool.removeItem(_list[i]);
					_paper.remove(_list[i]);
					_list.splice(i, 1);
				}
			}
		}
		
		public function addItem(vo:ItemVo):void
		{
			if (vo.type == ItemVo.IMAGE)
			{
				addImage(vo);
			}
			else
			{
				addText(vo);
			}
		}
	}
}