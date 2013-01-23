package com.ryan.core.frame
{
	import com.ryan.core.IDispose;
	
	public interface IBaseTimer extends IDispose
	{
		/**
		 * 是否需要渲染
		 * @return
		 *
		 */
		function get running():Boolean;
		/**
		 * 获取标识符ID
		 * @return
		 *
		 */
		function get id():int;
		/**
		 * 删除计时器
		 * @return
		 *
		 */
		function get isDelete():Boolean;
		
		/**
		 * 开始启动
		 *
		 */
		function start():void;
		
		/**
		 * 停止
		 *
		 */
		function stop():void;
		
		/**
		 * 时间间隔设置
		 * @return
		 *
		 */
		function get delay():int;
		function set delay(value:int):void;
		
		/**
		 *  重复执行次数设置
		 * @return
		 *
		 */
		function get repeatCount():Number;
		function set repeatCount(value:Number):void;
		
		function addListener(type:String, callback:Function):void;
		
		function renderer(frameAdd:int):void;
		
		function get isTimerQueue():Boolean;
		function set isTimerQueue(value:Boolean):void;
		
		function get interval():int;
		function set interval(value:int):void;
	}
}