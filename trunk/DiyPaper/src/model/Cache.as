package model 
{
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class Cache 
	{
		static private var _instance:Cache;
		
		public function Cache() 
		{
			if (_instance)
			{
				throw new Error("单例");
			}
		}
		
		static public function get instance():Cache
		{
			if (!_instance)
			{
				_instance = new Cache();
			}
			return _instance;
		}
		
		public var font:FontCache = new FontCache();
		public var paper:PaperVo = new PaperVo();
	}

}