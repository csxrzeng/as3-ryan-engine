package model
{
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class FontVo
	{
		public var name:String;
		public var font:String;
		public var url:String;
		public var state:int = 0;
		
		public function FontVo(name:String, font:String, url:String = null)
		{
			this.name = name;
			this.font = font;
			this.url = url;
		}
		
		public function toString():String
		{
			return name;
		}
	}
}