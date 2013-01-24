package com.ryan.resource.info
{
	public class MapDataInfo extends ResourceInfo
	{
		/**
		 * 地图数据，暂时不能用
		 */
		private var _mapInfo:Object;
		
		public function MapDataInfo(object:Object)
		{
			super(object);
		}
		
		public function get mapInfo():Object
		{
			return _mapInfo;
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			_mapInfo = this.data as Object;
		}
	}
}