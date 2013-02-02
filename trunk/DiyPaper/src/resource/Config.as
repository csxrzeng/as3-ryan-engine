package resource 
{
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class Config 
	{
		static public var MEDIA_PATH:String = "assets/";
		static public var MY_MEDIA_PATH:String = "images/";
		static public var UPLOAD_IMAGE_URL:String = "http://localhost/diypaper/upload.php";
		
		/**
		 * 支持的图片类型
		 */
		static public var filterType:String = "*.jpg;*.png";
		/**
		 * 是否管理员模式
		 * 管理员模式所有资源需要上传到服务器
		 * 否则直接读取到内存
		 */
		static public var isAdministrator:Boolean = true;
		
		public function Config() 
		{
			
		}
		
	}

}