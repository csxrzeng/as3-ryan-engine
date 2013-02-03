package model
{
	import com.ryan.resource.ResourceManager;
	import flash.utils.Dictionary;
	import resource.Config;
	import resource.MediaProxy;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class FontCache
	{
		private var fontMap:Dictionary = new Dictionary();
		private var swfMap:Dictionary = new Dictionary();
		private var fontNameList:Array = [];
		private var staticFonts:Array = [];
		
		public function FontCache()
		{
			init();
		}
		
		public function init():void
		{
			onStaticXmlComplete(XML(ResourceManager.getInfoByName(Config.SPECIAL_FONT_XML).data));
			onSpecialXmlComplete(XML(ResourceManager.getInfoByName(Config.STATIC_FONT_XML).data));
		}
		
		public function getFontNameList():Array
		{
			return fontNameList;
		}
		
		public function hasLoadedFont(fontName:String):Boolean
		{
			return fontMap[fontName] && (fontMap[fontName] as FontVo).state == 2;
		}
		
		public function loadFont(fontName:String, onComplete:Function = null):void
		{
			if (fontMap[fontName] && fontMap[fontName].state == 0)
			{
				fontMap[fontName].state = 1;
				MediaProxy.Instance().PushArray([Config.FONT_PATH + (fontMap[fontName] as FontVo).url]);
				MediaProxy.Instance().start(function():void
					{
						swfMap[fontName] = MediaProxy.Instance().GetData(Config.FONT_PATH + (fontMap[fontName] as FontVo).url);
						fontMap[fontName].state = 2;
						onComplete && onComplete();
					});
				return;
			}
			onComplete();
		}
		
		public function getFont(name:String):String
		{
			return !fontMap[name] ? "" : fontMap[name].font;
		}
		
		private function onSpecialXmlComplete(xml:XML):void
		{
			var items:XMLList = xml.children();
			for each (var item:XML in items)
			{
				var vo:FontVo = new FontVo(item.@name, item.@font, item.@url);
				fontMap[vo.name] = vo;
				fontNameList.push(vo);
			}
		}
		
		private function onStaticXmlComplete(xml:XML):void
		{
			var items:XMLList = xml.children();
			for each (var item:XML in items)
			{
				staticFonts.push(item.@name);
			}
		}
	}
}