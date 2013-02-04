package view
{
	import org.aswing.*;
	import org.aswing.event.ResizedEvent;
	import org.aswing.geom.IntDimension;
	import view.paper.PaperView;
	import view.paper.PreviewWin;
	import view.property.PropertyWin;
	import view.thumb.ThumbWin;
	import view.toolbar.ToolBar;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class MainWindow extends JWindow
	{
		static public var mapLayer:JScrollPane;
		static public var uiLayer:JPanel;
		// 海报
		static public var paper:PaperView;
		// 工具栏
		static public var toolBar:ToolBar;
		// 图层
		static public var layerWin:ThumbWin;
		// 属性
		static public var propertyWin:PropertyWin;
		//预览
		static public var previewWin:PreviewWin;
		
		static private var _instance:MainWindow;
		
		public function MainWindow(owner:*=null, modal:Boolean=false)
		{
			super(owner, modal);
			configUI();
			_instance = this;
		}
		
		private function configUI():void
		{
			var pane:Container = getContentPane();
			
			toolBar = new ToolBar();
			paper = new PaperView()
			
			mapLayer = new JScrollPane(paper);
			mapLayer.setOpaque(true);
			mapLayer.setBackground(new ASColor(0xeeeeee, 1));
			
			previewWin = new PreviewWin();
			//pane.append(previewWin);
			
			uiLayer = new JPanel(new EmptyLayout());
			pane.append(toolBar, BorderLayout.NORTH);
			pane.append(mapLayer, BorderLayout.CENTER);
			pane.append(uiLayer, BorderLayout.CENTER);

			layerWin = new ThumbWin(this, "图层");
			layerWin.show();
			layerWin.x = 0;
			layerWin.y = 50;
			
			propertyWin = new PropertyWin(this, "基本属性");
			propertyWin.show();
			propertyWin.x = 700;
			propertyWin.y = 50;
			
			addEventListener(ResizedEvent.RESIZED, onApplicationResize);
		}
		
		private function onApplicationResize(e:ResizedEvent):void
		{
			var size:IntDimension = e.getNewSize();
			if (true) // propertyWin.x + propertyWin.width > size.width)
			{
				propertyWin.x = size.width - propertyWin.width;
			}
		}
		
		static public function get instance():MainWindow
		{
			return _instance;
		}
	}
}