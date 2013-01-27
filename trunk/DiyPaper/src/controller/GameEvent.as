package controller
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class GameEvent extends Event
	{
		/**
		 * 显示特定类型的属性面板
		 */
		static public const ShowProperty:String = "ShowProperty";
		
		static public const SavePaper:String = "SavePaper";
		static public const NewPaper:String = "NewPaper";
		static public const LoadPaper:String = "LoadPaper";
		static public const SaveToPng:String = "SaveToPng";
		static public const BgColorChange:String = "BgColorChange";
		static public const BorderColorChange:String = "BorderColorChange";
		static public const WidthChange:String = "WidthChange";
		
		public var data:*;
		
		public function GameEvent(type:String, data:* = null)
		{
			this.data = data;
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new GameEvent(type, data);
		}
	}
}