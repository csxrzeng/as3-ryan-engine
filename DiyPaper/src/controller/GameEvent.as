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
		/**
		 * 切换显示面板
		 */
		static public const SWITCH_PROPERTY:String = "switch_property";
		
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
		/**
		 * 静态文本属性改变
		 */
		static public const STATIC_TEXT_PROPERTY_CHANGE:String = "static_text_property_change";
		/**
		 * 当前选中对象更新
		 */
		static public const UpdateSelectItem:String = "UpdateSelectItem";
		/**
		 * 删除选中对象
		 */
		static public const DeleteSelectedItem:String = "DeleteSelectedItem";
		/**
		 * 替换选中对象的图片
		 */
		static public const ReplaceSelectedImage:String = "ReplaceSelectedImage";
		
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