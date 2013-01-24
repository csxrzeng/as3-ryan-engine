package controller
{
	import com.ryan.global.Global;
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
	}
}