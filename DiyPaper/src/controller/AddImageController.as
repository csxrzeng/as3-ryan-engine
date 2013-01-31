package controller
{
	import com.ryan.resource.info.ImageInfo;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import model.ItemVo;
	import org.aswing.event.AWEvent;
	
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
		}
		
		private function onAddImageToPaper(e:GameEvent):void 
		{
			var item:ItemVo = new ItemVo(ItemVo.IMAGE);
			item.display = new Bitmap(e.data, "auto", true);
			GameController.paper.addImage(item);
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