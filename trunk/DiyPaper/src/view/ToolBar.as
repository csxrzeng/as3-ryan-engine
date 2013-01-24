package view
{
	import controller.Dispatcher;
	import controller.GameEvent;
	import org.aswing.BorderLayout;
	import org.aswing.event.AWEvent;
	import org.aswing.JButton;
	import org.aswing.JPanel;
	import org.aswing.JToolBar;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class ToolBar extends JPanel 
	{
		private var bar:JToolBar;
		private var btnAddText:JButton;
		private var btnAddImage:JButton;
		private var btnSavePng:JButton;
		private var btnSaveXml:JButton;
		private var btnLoadXml:JButton;
		
		public function ToolBar() 
		{
			super();
			setLayout(new BorderLayout());
			
			bar = new JToolBar(JToolBar.HORIZONTAL, 5);
			append(bar, BorderLayout.CENTER);
			
			btnAddText = new JButton("添加文字");
			btnAddImage = new JButton("添加图片");
			btnLoadXml = new JButton("保存为图片");
			btnSavePng = new JButton("保存模版");
			btnSaveXml = new JButton("打开模版");
			
			bar.appendAll(btnAddText, btnAddImage, btnLoadXml, btnSavePng, btnSaveXml);
			
			initEvents();
		}
		
		private function initEvents():void 
		{
			btnAddText.addEventListener(AWEvent.ACT, onActHandler);
			btnAddImage.addEventListener(AWEvent.ACT, onActHandler);
			btnLoadXml.addEventListener(AWEvent.ACT, onActHandler);
			btnSavePng.addEventListener(AWEvent.ACT, onActHandler);
			btnSaveXml.addEventListener(AWEvent.ACT, onActHandler);
		}
		
		private function onActHandler(e:AWEvent):void 
		{
			var type:String = "";
			switch(e.currentTarget)
			{
				case btnAddText:
					type = GameEvent.AddText;
					break;
				case btnAddImage:
					type = GameEvent.AddImage;
					break;
				case btnLoadXml:
					type = GameEvent.SaveToPng;
					break;
				case btnSavePng:
					type = GameEvent.SavePaper;
					break;
				case btnSaveXml:
					type = GameEvent.LoadPaper;
					break;
			}
			if (type)
			{
				Dispatcher.dispatchEvent(new GameEvent(type));
			}
		}
	}

}