package com.ryan.resource.info
{
	public class XMLInfo extends ResourceInfo
	{
		private var _xml:XML;
		public function XMLInfo( object:Object )
		{
			super(object)
		}
		
		public function get xml():XML
		{
			return _xml;
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			_xml = this.data as XML;
		}
	}
}