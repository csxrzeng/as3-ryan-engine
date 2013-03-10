package model 
{
	import org.aswing.ASColor;
	import utils.ColorUtil;
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class PaperVo 
	{
		public var id:int;
		public var width:int = 600; // 默认宽度
		public var height:int = 300; // 默认高度
		public var background:ASColor = new ASColor(0xffffff, 1);
		public var border:int = 0;
		public var borderColor:ASColor = new ASColor(0x000000, 1);
		
		public var items:Array = []; // LinkVo
	
		public var links:Array = []; // 
		
		public function PaperVo() 
		{
		}
		
		public function fromXML(xml:XML):void
		{
			width = xml.@width;
			height = xml.@height;
			var argb:uint = parseInt(xml.@background, 16);
			background = ColorUtil.getASColor(argb);
			border = xml.@border;
			borderColor = ColorUtil.getASColor(parseInt(xml.@borderColor, 16));
			var list:XMLList = xml.item;
			var len:int = list.length();
			for (var i:int = 0; i < len; i++) 
			{
				var item:ItemVo = new ItemVo();
				item.fromXML(list[i]);
				items.push(item);
			}
		}
	}
}