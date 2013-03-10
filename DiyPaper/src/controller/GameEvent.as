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
		///**
		 //* 向上一层
		 //*/
		//static public const UP_LAYER:String = "up_layer";
		///**
		 //* 向下一层
		 //*/
		//static public const DOWN_LAYER:String = "down_layer";
		/**
		 * 重排层次
		 */
		static public const RESORT_LAYER:String = "resort_layer";
		/**
		 * 显示预览
		 */
		static public const ShowPreview:String = "ShowPreview";
		/**
		 * 显示编辑
		 */
		static public const ShowNormal:String = "ShowNormal";
		
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