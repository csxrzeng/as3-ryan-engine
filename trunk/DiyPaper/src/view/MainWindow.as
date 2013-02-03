package view
{
	import org.aswing.*;
	import org.aswing.event.ResizedEvent;
	import org.aswing.geom.IntDimension;
	import view.paper.PaperView;
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
		static public var uiLayer:JWindow;
		// 海报
		static public var paper:PaperView;
		// 工具栏
		static public var toolBar:ToolBar;
		// 图层
		static public var layerWin:ThumbWin;
		// 属性
		static public var propertyWin:PropertyWin;
		
		public function MainWindow(owner:*=null, modal:Boolean=false)
		{
			super(owner, modal);
			configUI();
		}
		
		private function configUI():void
		{
			var pane:Container = getContentPane();
			pane.setLayout(new BorderLayout());
			
			toolBar = new ToolBar();
			paper = new PaperView()
			
			mapLayer = new JScrollPane(paper);
			mapLayer.setOpaque(true);
			mapLayer.setBackground(new ASColor(0xeeeeee, 1));

			uiLayer = new JWindow(pane, false);
			pane.append(toolBar, BorderLayout.NORTH);
			pane.append(mapLayer, BorderLayout.CENTER);
			uiLayer.show();
			//pane.append(uiLayer, BorderLayout.CENTER);

			layerWin = new ThumbWin(uiLayer, "图层");
			layerWin.show();
			layerWin.x = 0;
			layerWin.y = 50;
			
			propertyWin = new PropertyWin(uiLayer, "基本属性");
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
	}
}