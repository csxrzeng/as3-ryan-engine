package model
{
	import flash.display.DisplayObject;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.text.TextFormatAlign;
	import org.aswing.ASColor;
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class ItemVo
	{
		static public const IMAGE:String = "image";
		static public const SPECIAL_TEXT:String = "special_text";
		static public const STATIC_TEXT:String = "static_text";
		
		public var type:String = IMAGE;
		
		public var x:int = 100;
		public var y:int = 100;
		public var scaleX:Number = 1;
		public var scaleY:Number = 1;
		public var rotation:int;
		public var alpha:Number = 1;
		public var layer:int;
		
		// 图片
		public var url:String = "";
		public var display:DisplayObject; // 显示对象
		public var colorTransform:ColorTransform = new ColorTransform();
		
		//文字
		public var width:int = 100;
		public var height:int = 100;
		public var text:String = "点击编辑文字";
		public var font:String = "";
		public var letterSpacing:int = 0;
		public var leading:int = 0;
		public var color:uint;
		public var bold:Boolean;
		public var italic:Boolean;
		public var size:int = 50;
		public var align:String = TextFormatAlign.LEFT;
		public var underline:Boolean;
		public var glowFilter:GlowFilter = new GlowFilter(0x0, 1, 1, 1, 1, 1);
		public var shadowFilter:DropShadowFilter = new DropShadowFilter();
		
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
			width = xml.@width;
			height = xml.@height;
			x = xml.@x;
			y = xml.@y;
			rotation = xml.@rotation;
		}
		
		private function getMatrix(xml:XML):void
		{
			xml.@width = width;
			xml.@height = height;
			xml.@x = x;
			xml.@y = y;
			xml.@rotation = rotation;
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