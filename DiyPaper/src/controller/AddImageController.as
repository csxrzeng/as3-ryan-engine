package controller
{
	import com.ryan.debug.Log;
	import com.ryan.resource.info.SWFInfo;
	import com.ryan.resource.LoaderManager;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import model.ItemVo;
	import model.LoaderVo;
	import org.aswing.event.AWEvent;
	import resource.Config;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class AddImageController extends Controller
	{
		private var localFile:FileReference;
		
		public function AddImageController()
		{
		}
		
		override protected function initServer():void
		{
			Dispatcher.addEventListener(GameEvent.AddImageToPaper, onAddImageToPaper);
			Dispatcher.addEventListener(GameEvent.AddLibraryImage, onAddLibraryImage);
		}
		
		private function onAddLibraryImage(e:GameEvent):void 
		{
			LoaderManager.instance.load(Config.MEDIA_PATH + e.data + ".swf", onLibraryImageLoaded);
		}
		
		private function onLibraryImageLoaded(info:SWFInfo):void 
		{
			var data:ByteArray = (info.data as LoaderInfo).bytes as ByteArray;
			if (!data)
			{
				Log.error("swf数据错误");
				return;
			}
			var loader:LoaderVo = new LoaderVo();
			loader.url = info.name;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onConvertComplete);
			loader.loadBytes(data);
		}
		
		private function onConvertComplete(e:Event):void 
		{
			var info:LoaderInfo = e.currentTarget as LoaderInfo;
			info.removeEventListener(Event.COMPLETE, onConvertComplete);
			var item:ItemVo = new ItemVo(ItemVo.IMAGE);
			item.display = info.loader;
			GameController.paper.addItem(item);
		}
		
		private function onAddImageToPaper(e:GameEvent):void 
		{
			var item:ItemVo = new ItemVo(ItemVo.IMAGE);
			item.display = new Bitmap(e.data, "auto", true);
			GameController.paper.addItem(item);
		}
		
		private function onUploadClick(e:AWEvent):void
		{
			if (localFile == null)
			{
				localFile = new FileReference();
				localFile.addEventListener(Event.SELECT, onLocalFileSelected);
				localFile.addEventListener(Event.COMPLETE, onLocalFileLoaded);
			}
			localFile.browse([new FileFilter("图片文件", "*.jpg")]);
		}
		
		private function onLocalFileSelected(e:Event):void
		{
			//_addImagePane.getTxtLocal().setText(localFile.name);
			localFile.load();
		}
		
		private function onLocalFileLoaded(e:Event):void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLocalImgLoaded);
			loader.loadBytes(localFile.data);
		}
		
		private function onLocalImgLoaded(e:Event):void
		{
			var loaderInfo:LoaderInfo = e.target as LoaderInfo;
			var bitmap:Bitmap = loaderInfo.content as Bitmap;
			if (bitmap)
			{
				//addImageToPaper(bitmap.bitmapData);
			}
		}
		
	}
}