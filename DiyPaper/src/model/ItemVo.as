package model
{
	import flash.display.DisplayObject;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.text.TextFormatAlign;
	import org.aswing.ASColor;
	import utils.ColorUtil;
	import utils.XMLUtil;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class ItemVo
	{
		static public const DEFAULT_TEXT:String = "点击编辑文字";
		static public const IMAGE:String = "image";
		static public const SPECIAL_TEXT:String = "special_text";
		static public const STATIC_TEXT:String = "static_text";
		public var type:String = IMAGE;
		public var centerX:Number = 100;
		public var centerY:Number = 100;
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
		public var colorTransform:ColorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
		//文字
		public var width:int = 100;
		public var height:int = 100;
		public var text:String = DEFAULT_TEXT;
		public var font:String = "宋体";
		public var letterSpacing:int = 0;
		public var leading:int = 0;
		public var color:uint = 0;
		public var bold:Boolean = false;
		public var italic:Boolean = false;
		public var size:int = 50;
		public var align:String = TextFormatAlign.LEFT;
		public var underline:Boolean;
		public var glowFilter:GlowFilter = new GlowFilter(0x0, 1, 1, 1, 1, 1);
		public var shadowFilter:DropShadowFilter = new DropShadowFilter(1, 45, 0, 1, 1, 1, 1, 1);
		
		public function ItemVo(type:String = IMAGE)
		{
			this.type = type;
		}
		
		public function fromXML(xml:XML):void
		{
			type = xml.type;
			switch (type)
			{
				case IMAGE: 
					setImage(xml);
					break;
				case SPECIAL_TEXT: 
					setSpecialText(xml);
					break;
				case STATIC_TEXT: 
					setStaticText(xml);
					break;
				default: 
					throw new Error("错误的ItemVo类型");
					break;
			}
		}
		
		private function setSpecialText(xml:XML):void
		{
			type = xml.type;
			text = xml.text;
			font = xml.font;
			size = xml.size;
			bold = xml.bold == "true";
			italic = xml.italic == "true";
			leading = xml.leading;
			letterSpacing = xml.letterSpacing;
			align = xml.align;
			underline = xml.underline == "true";
			colorTransform = XMLUtil.colorTransformFromXML(xml.colortransform[0]);
			scaleX = xml.scaleX;
			scaleY = xml.scaleY;
			rotation = xml.rotation;
			centerX = xml.centerX;
			centerY = xml.centerY;
		}
		
		private function setStaticText(xml:XML):void
		{
			x = xml.x;
			y = xml.y;
			width = xml.width;
			height = xml.height;
			text = xml.text;
			font = xml.font;
			color = parseInt(xml.color, 16); 
			alpha = xml.alpha;
			align = xml.align;
			bold = xml.bold == "true";
			italic = xml.italic == "true";
			underline = xml.underline == "true";
			glowFilter = XMLUtil.glowFilterFromXML(xml.glowfilter[0]);
			shadowFilter = XMLUtil.dropShadowFilterFromXML(xml.dropshadowfilter[0]);
		}
		
		private function setImage(xml:XML):void
		{
			url = xml.url;
			scaleX = xml.scaleX;
			scaleY = xml.scaleY;
			centerX = xml.centerX;
			centerY = xml.centerY;
			rotation = xml.rotation;
			colorTransform = XMLUtil.colorTransformFromXML(xml.colortransform[0]);
		}
	}
}