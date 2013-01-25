package controller
{
	import com.ryan.global.Global;
	import com.ryan.resource.info.ImageInfo;
	import com.ryan.resource.LoaderManager;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import model.ItemVo;
	import org.aswing.AsWingUtils;
	import org.aswing.event.AWEvent;
	import org.aswing.JFrame;
	import view.AddImagePane;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class AddImageController extends Controller
	{
		private var _imageAddWindow:JFrame;
		private var _addImagePane:AddImagePane;
		
		private var localFile:FileReference;
		
		public function AddImageController()
		{
		}
		
		override protected function initServer():void
		{
			Dispatcher.addEventListener(GameEvent.AddImage, addImageProcessor);
		}
		
		private function addImageProcessor(e:GameEvent):void
		{
			AsWingUtils.getPopupAncestor(Main.uiContainer)
			imageAddWindow.show();
			_imageAddWindow.setX((Global.stage.stageWidth - _imageAddWindow.width) * 0.5);
			_imageAddWindow.setY((Global.stage.stageHeight - _imageAddWindow.height) * 0.5);
		}
		
		public function get imageAddWindow():JFrame
		{
			if (!_imageAddWindow)
			{
				_imageAddWindow = new JFrame(AsWingUtils.getPopupAncestor(Main.uiContainer), "添加图片");
				_imageAddWindow.setResizable(false);
				_addImagePane = new AddImagePane();
				configImagePane();
				_imageAddWindow.setContentPane(_addImagePane);
				_imageAddWindow.pack();
			}
			return _imageAddWindow;
		}
		
		private function configImagePane():void
		{
			showRemote(true);
			_addImagePane.getBtnRemote().addActionListener(onBtnAction)
			_addImagePane.getBtnLocal().addActionListener(onBtnAction);
			_addImagePane.getBtnDownload().addActionListener(onDownloadClick);
			_addImagePane.getBtnUpload().addActionListener(onUploadClick);
		}
		
		private function onBtnAction(e:AWEvent):void
		{
			showRemote(e.currentTarget == _addImagePane.getBtnRemote());
		}
		
		private function showRemote(value:Boolean):void
		{
			_addImagePane.getPaneRemote().visible = value;
			_addImagePane.getPaneLocal().visible = !value;
		}
		
		private function onDownloadClick(e:AWEvent):void
		{
			LoaderManager.instance.load(_addImagePane.getTxtRemote().getText(), onImgLoaded);
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
			
			//LoaderManager.instance.load(_addImagePane.getTxtLocal().getText(), onImgLoaded);
		}
		
		private function onLocalFileSelected(e:Event):void
		{
			_addImagePane.getTxtLocal().setText(localFile.name);
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
				addImageToPaper(bitmap.bitmapData);
			}
		}
		
		private function onImgLoaded(info:ImageInfo):void
		{
			addImageToPaper(info.bitmapData);
		}
		
		private function addImageToPaper(img:BitmapData):void
		{
			var item:ItemVo = new ItemVo(ItemVo.IMAGE);
			item.bitmapData = img;
			GameController.paper.addImage(item);
			_imageAddWindow.hide();
		}
	}
}