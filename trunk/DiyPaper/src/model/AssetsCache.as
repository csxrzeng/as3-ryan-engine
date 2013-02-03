package model
{
	import com.ryan.resource.ResourceManager;
	import resource.Config;
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class AssetsCache
	{
		private var assets:Vector.<String> = new Vector.<String>();
		
		public function AssetsCache()
		{
			init();
		}
		
		public function init():void
		{
			onXmlComplete(XML(ResourceManager.getInfoByName(Config.LIBRARY_XML).data));
		}
		
		public function get assetsList():Vector.<String>
		{
			return assets;
		}
		
		private function onXmlComplete(xml:XML):void
		{
			var items:XMLList = xml.children();
			for each (var item:XML in items)
			{
				assets.push(item.text());
			}
		}
	}
}