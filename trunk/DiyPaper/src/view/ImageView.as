package view 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import model.ItemVo;
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class ImageView extends Sprite
	{
		private var bmp:Bitmap;
		private var _vo:ItemVo;
		
		public function ImageView() 
		{
			_vo = new ItemVo(ItemVo.IMAGE);
			bmp = new Bitmap();
			addChild(bmp);
		}
		
		public function get vo():ItemVo 
		{
			return _vo;
		}
		
		public function set vo(value:ItemVo):void 
		{
			_vo = value;
		}
	}
}