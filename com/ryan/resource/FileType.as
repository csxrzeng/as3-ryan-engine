package com.ryan.resource
{
	import com.ryan.resource.info.DataInfo;
	import com.ryan.resource.info.ImageInfo;
	import com.ryan.resource.info.JTAInfo;
	import com.ryan.resource.info.MapDataInfo;
	import com.ryan.resource.info.SWFInfo;
	import com.ryan.resource.info.XMLInfo;
	import com.ryan.resource.loader.DataLoader;
	import com.ryan.resource.loader.ImageLoader;
	import com.ryan.resource.loader.JTALoader;
	import com.ryan.resource.loader.MapDataLoader;
	import com.ryan.resource.loader.SWFLoader;
	import com.ryan.resource.loader.XMLLoader;

	public class FileType
	{
		private static var _classRef:Object = {
			".XML":XMLLoader,
			".JPG":ImageLoader,
			".PNG":ImageLoader,
			".GIF":ImageLoader,
			".DATA":DataLoader,
			".SWF":SWFLoader,
			".MPT":MapDataLoader,
			".JTA":JTALoader,
			".ZIP":DataLoader
		}
			
		private static var _classInfoRef:Object = {
			".XML":XMLInfo,
			".JPG":ImageInfo,
			".PNG":ImageInfo,
			".GIF":ImageInfo,
			".DATA":DataInfo,
			".SWF":SWFInfo,
			".MPT":MapDataInfo,
			".JTA":JTAInfo,
			".ZIP":DataInfo
		}
		
		public function FileType()
		{
		}
		
		public static function getLoaderByType( type:String ):Class
		{
			return _classRef[ type.toUpperCase() ];
		}
		
		public static function getLoaderInfoByType( type:String ):Class
		{
			return _classInfoRef[ type.toUpperCase() ];
		}
		
	}
}