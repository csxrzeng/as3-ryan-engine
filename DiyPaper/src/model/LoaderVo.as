package model 
{
	import flash.display.Loader;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class LoaderVo extends Loader 
	{
		public var url:String;
		
		public function LoaderVo(url:String = null) 
		{
			this.url = url;
		}
		
	}

}