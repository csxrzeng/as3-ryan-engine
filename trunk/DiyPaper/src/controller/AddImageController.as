package controller
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.net.FileReference;
	import model.ItemVo;
	import model.library.AssetVo;
	import org.aswing.JOptionPane;
	import resource.Config;
	import resource.proxy.ImageFileVo;
	import resource.proxy.ResourceProxy;
	import resource.proxy.SwfFileVo;
	import view.MainWindow;
	
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
			Dispatcher.addEventListener(GameEvent.ReplaceSelectedImage, onReplaceImage);
		}
		
		private function onReplaceImage(e:GameEvent):void 
		{
			var item:ItemVo = e.data as ItemVo;
			if (item)
			{
				ResourceProxy.loadLocalImage(updateItem, onError, item);
			}
		}
		
		private function updateItem(image:ImageFileVo):void 
		{
			if (image)
			{
				var item:ItemVo = image.extData as ItemVo;
				if (item)
				{
					item.url = image.url;
					item.display = new Bitmap(image.bmd, "auto", true);
					MainWindow.paper.updateItem(item);
				}
			}
		}
		
		private function onAddLibraryImage(e:GameEvent):void 
		{
			ResourceProxy.loadSwf(Config.MEDIA_PATH + (e.data as AssetVo).file, onLoadComplete, onError);
		}
		
		private function onLoadComplete(swfVo:SwfFileVo):void 
		{
			var item:ItemVo = new ItemVo(ItemVo.IMAGE);
			item.url = swfVo.url;
			item.display = swfVo.display;
			GameController.paper.addItem(item);
		}
		
		private function onError(text:String):void
		{
			if (text)
			{
				JOptionPane.showMessageDialog("错误", text);
			}
		}
		
		private function onAddImageToPaper(e:GameEvent):void 
		{
			var imageFile:ImageFileVo = e.data as ImageFileVo;
			var item:ItemVo = new ItemVo(ItemVo.IMAGE);
			item.url = imageFile.url;
			item.display = new Bitmap(imageFile.bmd, "auto", true);
			GameController.paper.addItem(item);
		}
	}
}