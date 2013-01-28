package view.paper
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import model.ItemVo;
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class ImageView extends Sprite
	{
		private var display:DisplayObject;
		private var _vo:ItemVo;
		
		public function ImageView()
		{
			_vo = new ItemVo(ItemVo.IMAGE);
		}
		
		public function get vo():ItemVo
		{
			return _vo;
		}
		
		public function set vo(value:ItemVo):void
		{
			if (display && display.parent == this)
			{
				removeChild(display);
			}
			_vo = value;
			display = value.display;
			addChild(display);
			transform.matrix = _vo.matrix;
			transform.colorTransform = _vo.colorTransform;
			alpha = _vo.alpha;
		}
	}
}