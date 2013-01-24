package controller
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class GameEvent extends Event
	{
		static public const AddImage:String = "AddImage";
		static public const AddText:String = "AddText";
		static public const SavePaper:String = "SavePaper";
		static public const NewPaper:String = "NewPaper";
		static public const LoadPaper:String = "LoadPaper";
		static public const ShowProperty:String = "ShowProperty";
		
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