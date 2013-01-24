package model 
{
	import flash.utils.Dictionary;
	import resource.MediaProxy;
	import resource.SMedia;
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class FontCache 
	{
		static private const FontXMLPath:String = "fonts/fonts.xml";
		private var fontMap:Dictionary;
		private var fontNameList:Array;
		private var swfMap:Dictionary;
		
		public function FontCache() 
		{
			fontMap = new Dictionary();
			swfMap = new Dictionary();
			init();
		}
		
		public function init():void
		{
			MediaProxy.Instance().PushArray([FontXMLPath]);
			MediaProxy.Instance().start(onXmlComplete);
		}
		
		public function getFontNameList():Array
		{
			if (!fontNameList)
			{
				fontNameList = [];
				for each (var item:FontVo in fontMap) 
				{
					fontNameList.push(item.name);
				}
			}
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
				MediaProxy.Instance().PushArray(["fonts/" + (fontMap[fontName] as FontVo).url]);
				MediaProxy.Instance().start(function():void
				{
					swfMap[fontName] = MediaProxy.Instance().GetData("fonts/" + (fontMap[fontName] as FontVo).url);
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
		
		private function onXmlComplete():void 
		{
			var text:String = MediaProxy.Instance().GetData(FontXMLPath);
			if (text)
			{
				var xml:XML = XML(text);
				var items:XMLList = xml.children();
				for each (var item:XML in items) 
				{
					fontMap[String(item.@name)] = new FontVo(item.@name, item.@font, item.@url);
				}
			}
		}
	}
}
