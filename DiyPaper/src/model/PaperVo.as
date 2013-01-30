package model 
{
	import org.aswing.ASColor;
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
		
		public var items:Array = [];
		
		public function PaperVo() 
		{
		}
		
		public function toXML():XML
		{
			var xml:XML = <paper/>;
			xml.@width = width;
			xml.@height = height;
			for (var i:int = 0; i < items.length; i++) 
			{
				var item:ItemVo = items[i];
				xml.appendChild(item.toXML());
			}
			return xml;
		}
		
		public function fromXML(xml:XML):void
		{
			width = xml.@width;
			height = xml.@height;
			var list:XMLList = xml.children();
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