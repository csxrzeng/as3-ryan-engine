package controller
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.net.FileReference;
	import model.ItemVo;
	import model.library.AssetVo;
	import org.aswing.JOptionPane;
	import resource.Config;
	import resource.proxy.ResourceProxy;
	
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
			ResourceProxy.loadSwf(Config.MEDIA_PATH + (e.data as AssetVo).file, onLoadComplete, onError);
		}
		
		private function onLoadComplete(display:DisplayObject):void 
		{
			var item:ItemVo = new ItemVo(ItemVo.IMAGE);
			item.display = display;
			GameController.paper.addItem(item);
		}
		
		private function onError(text:String):void
		{
			JOptionPane.showMessageDialog("错误", text);
		}
		
		private function onAddImageToPaper(e:GameEvent):void 
		{
			var item:ItemVo = new ItemVo(ItemVo.IMAGE);
			item.display = new Bitmap(e.data, "auto", true);
			GameController.paper.addItem(item);
		}
	}
}