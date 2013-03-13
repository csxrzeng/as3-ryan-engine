package model
{
	import com.ryan.resource.ResourceManager;
	import flash.utils.Dictionary;
	import model.library.AssetVo;
	import model.library.TypeVo;
	import resource.Config;
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class AssetsCache
	{
		private var typeList:Array = [];
		private var cache:Dictionary = new Dictionary();
		public var pageSize:int = 20; // 可以读取xml配置
		
		public function AssetsCache()
		{
			init();
		}
		
		public function init():void
		{
			onXmlComplete(XML(ResourceManager.getInfoByName(Config.LIBRARY_XML).data));
		}
		
		public function getTypeList():Array
		{
			return typeList;
		}
		
		public function getAssetsList(type:int):Vector.<AssetVo>
		{
			return cache[type] as Vector.<AssetVo>;
		}
		
		private function onXmlComplete(xml:XML):void
		{
			var ps:int = parseInt(xml.@pagesize);
			if (!isNaN(ps))
			{
				pageSize = ps;
			}
			var types:XMLList = xml.children();
			for each (var type:XML in types)
			{
				var typeVo:TypeVo = new TypeVo();
				typeVo.id = type.@id;
				typeVo.name = type.@name;
				typeList.push(typeVo);
				var itemList:Vector.<AssetVo> = new Vector.<AssetVo>();
				cache[typeVo.id] = itemList;
				var items:XMLList = type.children();
				for each (var item:XML in items)
				{
					var assetVo:AssetVo = new AssetVo();
					assetVo.id = item.@id;
					assetVo.thumb = item.@thumb;
					assetVo.file = item.@file;
					itemList.push(assetVo);
				}
			}
		}
	}
}