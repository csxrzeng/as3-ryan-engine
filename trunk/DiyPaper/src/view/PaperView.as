package view
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
		
		public function PaperView()
		{
			_vo = new PaperVo();
			_tool = new TransformManager();
			setBackground(new ASColor(0xCCE8CC, 1));
			setSizeWH(500, 200);
			//var tool:TransformManager = new TransformManager( { targetObjects:[tf, bmp] } );
			_tool.addEventListener(TransformEvent.SELECTION_CHANGE, onSelectChange);
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
		
		public function get vo():PaperVo
		{
			_vo.width = this.width;
			_vo.height = this.height;
			_vo.items.length = 0;
			for (var i:int = 0; i < _list.length; i++)
			{
				_vo.items.push(_list[i].vo);
			}
			return _vo;
		}
		
		public function set vo(value:PaperVo):void
		{
			_tool.removeAllItems();
			for (var i:int = 0; i < _list.length; i++)
			{
				removeChild(_list[i] as DisplayObject);
			}
			_list.length = 0;
			_vo = value;
			setSizeWH(_vo.width, _vo.height);
			for (var j:int = 0; j < _vo.items.length; j++)
			{
				var item:ItemVo = _vo.items[j];
				addItem(item);
			}
		}
		
		public function addImage(vo:ItemVo):void
		{
			var image:ImageView = new ImageView();
			vo.type = ItemVo.IMAGE;
			image.vo = vo;
			addChild(image);
			_list.push(image);
			_tool.addItem(image);
		}
		
		public function addText(vo:ItemVo):void
		{
			var text:TextView = new TextView();
			vo.type = ItemVo.TEXT;
			text.vo = vo;
			addChild(text);
			_list.push(text);
			_tool.addItem(text, TransformManager.SCALE_WIDTH_AND_HEIGHT, true);
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