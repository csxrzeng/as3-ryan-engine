package resource 
{
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class Config 
	{
		static public var XML_PATH:String = "xmls/";
		static public var MEDIA_PATH:String = "assets/";
		static public var MY_MEDIA_PATH:String = "images/";
		static public var FONT_PATH:String = "fonts/";
		static public var PAPER_PATH:String = "papers/";
		
		static public var PAPER_XML:String = ""; // 当前加载的模版的路径
		static public var SPECIAL_FONT_XML:String = "fonts/specialfonts.xml";
		static public var STATIC_FONT_XML:String = "fonts/staticfonts.xml";
		static public var LIBRARY_XML:String = "library.xml";
		
		static public var UPLOAD_IMAGE_URL:String = "upload.php"; // "http://localhost/diypaper/upload.php";
		static public var UPLOAD_PAPER_URL:String = "paperupload.php"; // "http://localhost/diypaper/paperupload.php";
		
		/**
		 * 支持的图片类型
		 */
		static public var filterType:String = "*.jpg;*.png";
		/**
		 * 支持的文件大小
		 */
		static public var MaxFileSize:int = 500 * 1024; // 500K;
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