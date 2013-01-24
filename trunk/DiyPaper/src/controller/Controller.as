package controller 
{
	import model.Cache;
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class Controller 
	{
		protected var cache:Cache = Cache.instance;
		
		public function Controller() 
		{
			initServer();
		}
		
		protected function initServer():void 
		{
			
		}
		
	}

}