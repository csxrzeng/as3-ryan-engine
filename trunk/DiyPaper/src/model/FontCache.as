package model
{
	import com.ryan.resource.ResourceManager;
	import flash.text.Font;
	import flash.utils.Dictionary;
	import resource.Config;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class FontCache
	{
		private var fontMap:Dictionary = new Dictionary();
		private var swfMap:Dictionary = new Dictionary();
		private var specialFonts:Array = [];
		private var staticFonts:Array = [];
		
		public function FontCache()
		{
			init();
		}
		
		public function init():void
		{
			onSpecialXmlComplete(XML(ResourceManager.getInfoByName(Config.SPECIAL_FONT_XML).data));
			onStaticXmlComplete(XML(ResourceManager.getInfoByName(Config.STATIC_FONT_XML).data));
		}
		
		public function getSpecialFontList():Array
		{
			return specialFonts;
		}
		
		public function getStaticFontList():Array 
		{
			return staticFonts;
		}
		
		public function getFont(name:String):String
		{
			return !fontMap[name] ? "" : fontMap[name].font;
		}
		
		public function getStaticFontByFont(font:String):FontVo 
		{
			for each (var item:FontVo in staticFonts) 
			{
				if (item.font == font)
				{
					return item;
				}
			}
			return staticFonts[0];
		}
		
		public function getSpecialFontByFont(font:String):FontVo 
		{
			for each (var item:FontVo in specialFonts) 
			{
				if (item.font == font)
				{
					return item;
				}
			}
			return specialFonts[0];
		}
		
		private function hasLoadedFont(fontName:String):Boolean
		{
			return fontMap[fontName] && (fontMap[fontName] as FontVo).state == 2;
		}
		
		private function onSpecialXmlComplete(xml:XML):void
		{
			var items:XMLList = xml.children();
			for each (var item:XML in items)
			{
				var vo:FontVo = new FontVo(item.@name, item.@font, item.@url);
				fontMap[vo.name] = vo;
				specialFonts.push(vo);
			}
		}
		
		private function onStaticXmlComplete(xml:XML):void
		{
			var items:XMLList = xml.children();
			for each (var item:XML in items)
			{
				var vo:FontVo = new FontVo(item.@name, item.@font, null);
				if (hasSystemFont(vo.name)) // 系统有才加进去
				{
					staticFonts.push(vo);
				}
			}
			if (!staticFonts.length)
			{
				staticFonts.push("_sans"); // 没有字体
			}
		}
		
		private function hasSystemFont(name:String):Boolean
		{
			var ary:Array = Font.enumerateFonts(true);
			for each (var item:Font in ary)
			{
				if (item.fontName == name)
				{
					return true;
				}
			}
			return false;
		}
	}
}