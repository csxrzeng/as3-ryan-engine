package com.ryan.utils
{
	public class ArrayUtil
	{
		public function ArrayUtil()
		{
		}
		
		/**
		 * 删除数组项
		 * @param array
		 * @param item
		 */
		public static function removeItem(array:Object, item:Object):void
		{
			var index:int = array.indexOf(item);
			if (index != -1)
			{
				array.splice(index, 1);
			}
		}
	}
}