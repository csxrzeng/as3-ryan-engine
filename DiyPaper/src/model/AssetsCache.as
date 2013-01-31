package model
{
	import resource.MediaProxy;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class AssetsCache
	{
		static private const ASSET_XML_PATH:String = "assets.xml";
		private var assets:Vector.<String> = new Vector.<String>();
		
		public function AssetsCache()
		{
			init();
		}
		
		public function init():void
		{
			MediaProxy.Instance().PushArray([ASSET_XML_PATH]);
			MediaProxy.Instance().start(onXmlComplete);
		}
		
		public function get assetsList():Vector.<String>
		{
			return assets;
		}
		
		private function onXmlComplete():void
		{
			var text:String = MediaProxy.Instance().GetData(ASSET_XML_PATH);
			if (text)
			{
				var xml:XML = XML(text);
				var items:XMLList = xml.children();
				for each (var item:XML in items)
				{
					assets.push(item.text());
				}
			}
		}
	}
}