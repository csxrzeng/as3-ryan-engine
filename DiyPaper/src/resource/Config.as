package resource 
{
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class Config 
	{
		static public var PATH:String =  ""; // "http://localhost/diypaper/"; //
		
		static public var XML_PATH:String = PATH + "xmls/";
		static public var PAPER_PATH:String = PATH + "papers/";
		static public var MEDIA_PATH:String = PATH + "assets/";
		static public var MY_MEDIA_PATH:String = PATH + "images/";
		static public var FONT_PATH:String = PATH + "fonts/";
		
		static public var SPECIAL_FONT_XML:String = PATH + "fonts/specialfonts.xml";
		static public var STATIC_FONT_XML:String = PATH + "fonts/staticfonts.xml";
		static public var LIBRARY_XML:String = PATH + "library.xml";
		
		static public var IMAGE_PROXY:String = PATH + "imageproxy.php";
		static public var FONT_PROXY:String = PATH + "fontproxy.php";
		
		static public var UPLOAD_IMAGE_URL:String = PATH + "upload.php";
		static public var UPLOAD_XML_URL:String = PATH + "xmlupload.php";
		static public var UPLOAD_PAPER_URL:String = PATH + "paperupload.php";
		
		static public var TEMPLET_XML:String = ""; // 当前加载的模版XML
		static public var PAPER_XML:String = ""; // 当前保存的模版的xml文件名，当为管理员的时候，等于ModelXML
		static public var PAPER_IMAGE:String = ""; // 当前保存的图片的jpg文件名
		
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