package model
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.text.TextField;
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class ItemVo
	{
		static public const IMAGE:String = "image";
		static public const TEXT:String = "text";
		
		public var type:String = IMAGE;
		
		public var matrix:Matrix = new Matrix(1, 0, 0, 1, 100, 100); // 默认放在100 100 的位置
		public var alpha:Number = 1;
		
		// 图片
		public var url:String = "";
		public var bitmapData:BitmapData;
		public var colorTransform:ColorTransform = new ColorTransform();
		
		//文字
		public var text:String = "点击编辑文字";
		public var font:String = "";
		public var letterSpacing:int = 0;
		public var leading:int = 0;
		public var color:uint;
		public var bold:Boolean;
		public var italic:Boolean;
		public var size:int = 12;
		
		public function ItemVo(type:String = IMAGE)
		{
			this.type = type;
		}
		
		public function fromXML(xml:XML):void
		{
			type = xml.@type;
			setMatrix(xml);
			alpha = xml.@alpha;
			if (type == IMAGE)
			{
				url = xml.@url;
				setColorTransform(xml);
			}
			else
			{
				text = xml.@text;
				font = xml.@font;
				letterSpacing = xml.@letterSpacing;
				leading = xml.@leading;
				color = parseInt(xml.@color, 16);
				bold = String(xml.@bold) == "true";
				italic = String(xml.@italic) == "true";
				size = parseInt(xml.@size);
			}
		}
		
		public function toXML():XML
		{
			var xml:XML = <item/>;
			xml.@type = type;
			xml.@alpha = alpha;
			getMatrix(xml);
			if (type == IMAGE)
			{
				xml.@url = url;
				getColorTransform(xml);
			}
			else
			{
				xml.@text = text;
				xml.@font = font;
				xml.@letterSpacing = letterSpacing;
				xml.@leading = leading;
				xml.@color = "0x" + color.toString(16);
				xml.@bold = bold;
				xml.@italic = italic;
				xml.@size = size;
			}
			return xml;
		}
		
		private function setMatrix(xml:XML):void
		{
			matrix.a = xml.@a;
			matrix.b = xml.@b;
			matrix.c = xml.@c;
			matrix.d = xml.@d;
			matrix.tx = xml.@tx;
			matrix.ty = xml.@ty;
		}
		
		private function getMatrix(xml:XML):void
		{
			xml.@a = matrix.a;
			xml.@b = matrix.b;
			xml.@c = matrix.c;
			xml.@d = matrix.d;
			xml.@tx = matrix.tx;
			xml.@ty = matrix.ty;
		}
		
		private function setColorTransform(xml:XML):void
		{
			with (colorTransform)
			{
				redMultiplier = xml.@rm;
				greenMultiplier = xml.@gm;
				blueMultiplier = xml.@bm;
				alphaMultiplier = xml.@am;
				redOffset = xml.@ro;
				greenOffset = xml.@go;
				blueOffset = xml.@bo;
				alphaOffset = xml.@ao;
			}
		}
		
		private function getColorTransform(xml:XML):void
		{
			with (colorTransform)
			{
				xml.@rm = redMultiplier;
				xml.@gm = greenMultiplier;
				xml.@bm = blueMultiplier;
				xml.@am = alphaMultiplier;
				xml.@ro = redOffset;
				xml.@go = greenOffset;
				xml.@bo = blueOffset;
				xml.@ao = alphaOffset;
			}
		}
	}
}