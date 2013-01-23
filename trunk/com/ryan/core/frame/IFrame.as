package com.ryan.core.frame
{
	public interface IFrame
	{
		/**
		 * 开始运行
		 *
		 */
		function play():void;
		/**
		 * 停止运行
		 *
		 */
		function stop():void;
		/**
		 * 添加计时器
		 * @param timer
		 *
		 */
		function addTimer(timer:IBaseTimer):void;
	}
}