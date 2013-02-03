package view.thumb
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import model.ItemVo;
	import view.paper.IItemView;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class ThumbIcon extends Sprite
	{
		public static const SIZE:int = 45;
		
		private var bmp:Bitmap;
		
		private var _vo:ItemVo;
		private var _view:IItemView;
		
		public function ThumbIcon()
		{
			mouseChildren = false;
			buttonMode = true;
			
			bmp = new Bitmap();
			bmp.x = 1;
			bmp.y = 1;
			addChild(bmp);
			
			drawBorder();
		}
		
		private function setIcon(view:DisplayObject):void
		{
			if (view)
			{
				var matrix:Matrix = new Matrix();
				matrix.scale((SIZE - 1) / view.width, (SIZE - 1) / view.height);
				var bmd:BitmapData = new BitmapData(SIZE - 1, SIZE - 1);
				bmd.draw(view, matrix, view.transform.colorTransform);
				bmp.bitmapData = bmd;
			}
			else
			{
				bmp.bitmapData = null;
			}
		}
		
		private function drawBorder():void
		{
			graphics.clear();
			graphics.lineStyle(1);
			graphics.drawRect(0, 0, SIZE, SIZE);
			graphics.endFill();
		}
		
		public function get view():IItemView
		{
			return _view;
		}
		
		public function set view(value:IItemView):void
		{
			_view = value;
			setIcon(_view as DisplayObject);
		}
	}
}