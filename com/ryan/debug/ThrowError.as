/**
 * @date	2011-4-20 下午02:34:55
 * @author xr.zeng
 * 
 */	

package com.ryan.debug
{
	import com.ryan.global.Global;

	public class ThrowError
	{
		public function ThrowError()
		{
			
		}
		
		public static function show( value:String ):void
		{
			if( Global.isDebugModle )
			{
//				Alert.show(value);
			}
		}
	}
}
