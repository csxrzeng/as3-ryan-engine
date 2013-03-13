package view.thumb
{
	import controller.Dispatcher;
	import controller.GameEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import model.ItemVo;
	import view.paper.IItemView;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class ThumbIcon extends Sprite
	{
		public static const SIZE:int = 40;
		
		[Embed(source="../../assets/close.png")]
		static private const CLOSE_CLASS:Class;
		static private const CLOSE_BMD:BitmapData = new CLOSE_CLASS().bitmapData;
		
		private var bmp:Bitmap;
		private var closeBtn:Sprite;
		
		private var _view:IItemView;
		
		public function ThumbIcon()
		{
			buttonMode = true;
			
			drawBorder();
			
			bmp = new Bitmap();
			bmp.x = 1;
			bmp.y = 1;
			addChild(bmp);
			
			closeBtn = new Sprite()
			closeBtn.addChild(new Bitmap(CLOSE_BMD));
			closeBtn.x = SIZE - CLOSE_BMD.width - 1;
			closeBtn.y = 1;
			addChild(closeBtn);
			closeBtn.addEventListener(MouseEvent.CLICK, onCloseBtnClick);
		}
		
		private function onCloseBtnClick(e:MouseEvent):void 
		{
			if (_view)
			{
				Dispatcher.dispatchEvent(new GameEvent(GameEvent.DeleteSelectedItem, _view.vo));
			}
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
			graphics.lineStyle(1, 0xafaba8);
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