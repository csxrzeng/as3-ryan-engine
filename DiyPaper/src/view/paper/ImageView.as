package view.paper
{
	import com.greensock.events.TransformEvent;
	import com.greensock.transform.TransformItem;
	import controller.Dispatcher;
	import controller.GameEvent;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import model.ItemVo;
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
			//_item.scaleX = _vo.scaleX;
			//_item.scaleY = _vo.scaleY;
			//_item.x = _vo.x
			//_item.y = _vo.y;
			transform.colorTransform = _vo.colorTransform;
			alpha = _vo.alpha;
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
	}
}