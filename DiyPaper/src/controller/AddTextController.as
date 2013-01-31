package controller
{
	import com.ryan.global.Global;
	import model.ItemVo;
	import org.aswing.AsWingUtils;
	import org.aswing.event.AWEvent;
	import org.aswing.JFrame;
	import org.aswing.JPanel;
	import view.MainWindow;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class AddTextController extends Controller
	{
		private var _fontAddWindow:JFrame;
		private var _addTextPane:JPanel;
		private var curFont:String;
		
		public function AddTextController()
		{
		}
		
		override protected function initServer():void
		{
		}
		
		private function addTextProcessor(e:GameEvent):void
		{
			if (e.data)
			{
				var item:ItemVo = new ItemVo(ItemVo.TEXT);
				item.font = cache.font.getFont(e.data);
				MainWindow.paper.addItem(item);
				fontAddWindow.hide();
			}
			else
			{
				AsWingUtils.getPopupAncestor(MainWindow.uiLayer);
				fontAddWindow.show();
				_fontAddWindow.x = (Global.stage.stageWidth - _fontAddWindow.width) * 0.5;
				_fontAddWindow.y = (Global.stage.stageHeight - _fontAddWindow.height) * 0.5;
			}
		}
		
		public function get fontAddWindow():JFrame
		{
			if (!_fontAddWindow)
			{
				//_fontAddWindow = new JFrame(AsWingUtils.getPopupAncestor(MainWindow.uiLayer), "选择字体");
				//_fontAddWindow.setResizable(false);
				//_addTextPane = new AddTextPane();
				//_addTextPane.getCbFont().setListData(cache.font.getFontNameList());
				//_addTextPane.getBtnConfirm().addActionListener(onConfirmAct);
				//_fontAddWindow.setContentPane(_addTextPane);
				//_fontAddWindow.pack();
			}
			return _fontAddWindow;
		}
		
		private function onConfirmAct(e:AWEvent):void
		{
			//curFont = _addTextPane.getCbFont().getSelectedItem() as String;
			//cache.font.loadFont(curFont, onComplete);
		}
		
		private function onComplete():void
		{
			if (cache.font.hasLoadedFont(curFont))
			{
				trace("字体加载完成");
			}
			else
			{
				trace("正在加载字体");
			}
		}
	}
}