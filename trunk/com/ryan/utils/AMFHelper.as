package com.ryan.utils
{
	import flash.utils.ByteArray;
	
	public class AMFHelper
	{
		public function AMFHelper()
		{
			
		}
		/**
		 *  byteArray 对象 转换成 object对象
		 * @param byteArray
		 * @return 
		 * 
		 */		
		public static function readObject(byteArray:ByteArray):Object
		{
			var obj:Object;
			if(byteArray)
			{ 
				byteArray.position = 0;
				byteArray.uncompress();
				obj = byteArray.readObject();
			}
			return obj;
		}
		/** 
		 * object 对象转换成 byteArray 对象 
		 * @param object
		 * @return 
		 * 
		 */		
		public static function writeObject(object:Object):ByteArray
		{
			var byteArray:ByteArray = new ByteArray();
			byteArray.position = 0;
			byteArray.writeObject(object);
			byteArray.compress();
			return byteArray;
		}
	}
}