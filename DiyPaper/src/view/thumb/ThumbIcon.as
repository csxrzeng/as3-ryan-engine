package view.thumb
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import model.ItemVo;
	import view.paper.ImageView;
	import view.paper.StaticTextView;
	import view.paper.TextView;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class ThumbIcon extends Sprite
	{
		public static const SIZE:int = 45;
		
		private var bmp:Bitmap;
		
		private var _data:ItemVo;
		
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
				var orignWidth:Number = view.width;
				var orignHeight:Number = view.height;
				view.width = view.height = SIZE;
				var bmd:BitmapData = new BitmapData(SIZE - 1, SIZE - 1);
				bmd.draw(view);
				bmp.bitmapData = bmd;
				view.width = orignWidth;
				view.height = orignHeight;
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
		
		public function get data():ItemVo
		{
			return _data;
		}
		
		public function set data(value:ItemVo):void
		{
			_data = value;
			if (_data)
			{
				if (_data.type == ItemVo.IMAGE)
				{
					addImage(_data);
				}
				else if (_data.type == ItemVo.SPECIAL_TEXT)
				{
					addText(_data);
				}
				else if (_data.type == ItemVo.STATIC_TEXT)
				{
					addStaticText(_data);
				}
			}
			else
			{
				setIcon(null);
			}
		}
		
		private function addStaticText(vo:ItemVo):void
		{
			var text:StaticTextView = new StaticTextView();
			text.vo = vo;
			setIcon(text);
		}
		
		private function addText(vo:ItemVo):void
		{
			var text:TextView = new TextView();
			text.vo = vo;
			setIcon(text);
		}
		
		private function addImage(vo:ItemVo):void
		{
			var image:ImageView = new ImageView();
			image.vo = vo;
			setIcon(image);
		}
	}
}