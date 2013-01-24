package com.ryan.core.call
{
	import com.ryan.core.IDispose;

	public interface ICaller extends IDispose
	{
		/**
		 *  添加一个回调
		 * @param type
		 * @param value
		 * 
		 */		
		function addCall( type:Object,value:Function ):void; 
		
		/**
		 *  删除一个回调
		 * @param type 
		 * @param value
		 * 
		 */		
		function removeCall( type:Object,value:Function ):void;
		
		/**
		 * 删除一类回调 
		 * @param type
		 * 
		 */		
		function removeCallByType(type:Object):void;
		
		/**
		 * 执行回调 
		 * @param type
		 * 
		 */		
		function call(type:Object, ...rect ):Boolean;
		
	}
}