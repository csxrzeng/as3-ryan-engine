package view.paper
{
	import com.greensock.events.TransformEvent;
	import com.greensock.transform.TransformItem;
	import controller.Dispatcher;
	import controller.GameEvent;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import model.ItemVo;
	import resource.proxy.ResourceProxy;
	import resource.proxy.SwfFileVo;
	import utils.XMLUtil;
	import view.MainWindow;
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class ImageView extends Sprite implements IItemView
	{
		private var display:DisplayObject;
		private var _vo:ItemVo;
		private var _item:TransformItem;
		private var _lastRotation:int = 0;
		
		public function ImageView()
		{
		}
		
		/* INTERFACE view.paper.IItemView */
		
		public function update():void
		{
			if (!_vo.display)
			{
				ResourceProxy.loadSwf(_vo.url, onLoadComplete);
				return;
			}
			if (display && display != _vo.display && display.parent == this)
			{
				removeChild(display);
			}
			display = _vo.display;
			if (display && display.parent != this)
			{
				addChild(display);
				_item.origin = _item.center;
			}
			var degree:int = _vo.rotation - _lastRotation;
			_item.rotate(degree * Math.PI / 180);
			_lastRotation = _vo.rotation;
			transform.colorTransform = _vo.colorTransform;
		}
		
		private function onLoadComplete(vo:SwfFileVo):void 
		{
			_vo.display = vo.display;
			update();
			MainWindow.layerWin.updateLayer(this);
		}
		
		public function get item():TransformItem 
		{
			return _item;
		}
		
		public function set item(value:TransformItem):void 
		{
			_item = value;
			_item.addEventListener(TransformEvent.ROTATE, onUpdate);
			_item.addEventListener(TransformEvent.SCALE, onUpdate);
			_item.addEventListener(TransformEvent.MOVE, onUpdate);
		}
		
		private function onUpdate(e:TransformEvent):void 
		{
			//_vo.x = _item.x;
			//_vo.y = _item.y;
			//_vo.scaleX = _item.scaleX;
			//_vo.scaleY = _item.scaleY;
			_lastRotation = Math.round(_item.rotation + 360) % 360;
			_vo.rotation = _lastRotation;
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.UpdateSelectItem, _vo));
		}
		
		public function get vo():ItemVo
		{
			return _vo;
		}
		
		public function set vo(value:ItemVo):void
		{
			_vo = value;
			update();
		}
		
		public function toXML():XML
		{
			var xml:XML = <item/>;
			xml.type = _vo.type;
			xml.url = _vo.url;
			xml.scaleX = _item.scaleX;
			xml.scaleY = _item.scaleY;
			xml.centerX = _item.center.x;
			xml.centerY = _item.center.y;
			xml.rotation = _item.rotation;
			xml.appendChild(XMLUtil.colorTransformToXML(_vo.colorTransform));
			return xml;
		}
	}
}