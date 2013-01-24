/**
 * @date	2012-4-23 上午11:39:53
 * @author  xr.zeng
 */
package com.ryan.resource.info
{
	import flash.utils.ByteArray;
	public class SharedInfo
	{
		public var url:String;
		public var version:String;
		public var data:ByteArray; // String or ByteArray
		
		public function SharedInfo()
		{
		}
		
		public function read(o:Object):void
		{
			url = o.url;
			version = o.version;
			data = o.data;
		}
	}
}