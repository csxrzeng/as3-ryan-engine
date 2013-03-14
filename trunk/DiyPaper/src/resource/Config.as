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
		
		static public var UPLOAD_XML_URL:String = PATH + "xmlupload.php";
		static public var UPLOAD_PAPER_URL:String = PATH + "paperupload.php";
		static public var UPLOAD_IMAGE_URL:String = PATH + "upload.php";
		/**
		 * 支持的图片类型
		 */
		static public var filterType:String = "*.jpg;*.png";
		/**
		 * 支持的文件大小
		 */
		static public var MaxFileSize:int = 500 * 1024; // 500K;
		
		static public var TEMPLET_XML:String = ""; // 当前加载的模版XML
		static public var PAPER_XML:String = ""; // 当前保存的模版的xml文件名，当为管理员的时候，等于ModelXML
		static public var PAPER_IMAGE:String = ""; // 当前保存的图片的jpg文件名
		
		/**
		 * 是否管理员模式
		 * 管理员模式所有资源需要上传到服务器
		 * 否则直接读取到内存
		 */
		static public var isAdministrator:Boolean = true;
		
		public function Config() 
		{
			
		}
		
		static public function init(xml:XML):void
		{
			//<!--- 根路径 -->
			PATH = xml.path;
			//<!-- 保存XML的路径 -->
			XML_PATH = getUrl(xml.xml_path);
			//<!-- 保存海报jpg的路径 -->
			PAPER_PATH = getUrl(xml.paper_path);
			//<!-- 保存在线图标的路径 -->
			MEDIA_PATH = getUrl(xml.media_path);
			//<!-- 保存上传图片的路径 -->
			MY_MEDIA_PATH = getUrl(xml.my_media_path);
			//<!-- 保存字体的路径 -->
			FONT_PATH = getUrl(xml.font_path);
			//<!-- 特效文字配置XML路径 -->
			SPECIAL_FONT_XML = getUrl(xml.special_font_xml);
			//<!-- 静态文字配置XML路径 -->
			STATIC_FONT_XML = getUrl(xml.static_font_xml);
			//<!-- 在线图标配置XML路径 -->
			LIBRARY_XML = getUrl(xml.library_xml);
			//<!-- 加载其他网站图片的代理地址 -->
			IMAGE_PROXY = getUrl(xml.image_proxy);
			//<!-- XML上传的页面地址 -->
			UPLOAD_XML_URL = getUrl(xml.upload_xml_url);
			//<!-- 海报上传的页面地址 -->
			UPLOAD_PAPER_URL = getUrl(xml.upload_paper_url);
			//<!-- 上传图片的页面地址 -->
			UPLOAD_IMAGE_URL = getUrl(xml.upload_image_url);
			//<!-- 上传图片的限制格式 -->
			filterType = xml.upload_image_type;
			//<!-- 上传图片的限制大小 -->
			MaxFileSize = int(xml.upload_image_size) * 1024;
			//<!-- 暂未使用：动态生成文字SWF代理地址 -->
			FONT_PROXY = getUrl(xml.font_proxy);
		}
		
		static private function getUrl(str:String):String
		{
			if (str.search(/^http[s]?:\/\//) == -1)
			{
				str = PATH + str;
			}
			return str;
		}
	}

}