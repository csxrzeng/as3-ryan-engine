package com.ryan.player
{
	import com.ryan.core.IDispose;
	import flash.geom.Point;
	
	/**
	 *
	 * @author xr.zeng
	 */
	public interface IBasePlayer extends IDispose
	{
		function get isPlay():Boolean;
		function get frameCount():int;
		function set frameCount(value:int):void;
		function get delay():Number;
		function set delay(value:Number):void;
		function move(x:Number, y:Number):void;
		function moveToPoint(p:Point):void;
		function start():void;
		function stop():void;
		function reset():void;
	}
}