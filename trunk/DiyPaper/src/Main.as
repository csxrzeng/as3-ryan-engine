package
{
	import com.ryan.global.Global;
	import controller.GameController;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.aswing.*;
	import view.*;
	import view.laf.MyLookAndFeel;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class Main extends Sprite
	{
		// 菜单
		//static public var menuContainer:JPanel;
		// 工具栏
		static public var toolContainer:JPanel;
		// 海报
		static public var paperContainer:PaperView;
		// UI窗口区域
		static public var uiContainer:JPanel;
		static public var mainWindow:JWindow;
		
		public function Main():void
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			Global.instance.initStage(stage);
			AsWingManager.initAsStandard(this);
			UIManager.setLookAndFeel(new MyLookAndFeel());
			//menuContainer = new Menu();
			toolContainer = new ToolBar();
			paperContainer = new PaperView();
			uiContainer = new JPanel();
			mainWindow = new JWindow();
			var pane:Container = mainWindow.getContentPane();
			pane.setLayout(new BorderLayout());
			var top:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
			//top.append(menuContainer);
			top.append(toolContainer);
			var middle:JPanel = new JPanel(new CenterLayout());
			middle.setOpaque(true);
			middle.setBackground(new ASColor(0xEEEEEE, 1));
			middle.append(paperContainer);
			pane.append(top, BorderLayout.NORTH);
			pane.append(middle, BorderLayout.CENTER);
			pane.append(uiContainer, BorderLayout.CENTER);
			mainWindow.setSizeWH(stage.stageWidth, stage.stageHeight);
			mainWindow.show();
			stage.addEventListener(Event.RESIZE, onStageResize);
			stage.addEventListener(MouseEvent.CLICK, onStageClick);
			
			GameController.init();
		}
		
		private function onStageClick(e:MouseEvent):void
		{
		}
		
		private function onStageResize(e:Event):void
		{
			mainWindow.setSizeWH(stage.stageWidth, stage.stageHeight);
		}
	}
}