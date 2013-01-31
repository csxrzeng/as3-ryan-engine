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
		static public const LoadPaper:String = "LoadPaper";
		static public const SaveToPng:String = "SaveToPng";
		/**
		 * 把图片添加到工作区
		 */
		static public const AddImageToPaper:String = "AddImageToPaper";
		/**
		 * 基本属性改变
		 */
		static public const BasePropertyChange:String = "BasePropertyChange";
		/**
		 * 添加在线图片到工作区
		 */
		static public const AddLibraryImage:String = "AddLibraryImage";
		
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