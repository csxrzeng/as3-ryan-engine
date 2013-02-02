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
			for (var i:int = 0; i < array.length; i++) 
			{
				if (array[i] == item)
				{
					array.splice(i, 1);
				}
			}
		}
	}
}