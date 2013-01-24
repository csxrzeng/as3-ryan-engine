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
		private var addButton:JButton;
		private var removeButton:JButton;
		private var editButton:JButton;
		private var importButton:JButton;
		
		public function ToolBar() 
		{
			super();
			setLayout(new BorderLayout());
			
			bar = new JToolBar(JToolBar.HORIZONTAL, 5);
			append(bar, BorderLayout.CENTER);
			
			addButton = new JButton("添加文字");
			removeButton = new JButton("添加图片");
			editButton = new JButton("保 存");
			importButton = new JButton("打 开");
			
			bar.appendAll(addButton, removeButton, editButton, importButton);
			
			initEvents();
		}
		
		private function initEvents():void 
		{
			addButton.addEventListener(AWEvent.ACT, onAddTask);
			removeButton.addEventListener(AWEvent.ACT, onRemoveTask);
			editButton.addEventListener(AWEvent.ACT, onEditTask);
			importButton.addEventListener(AWEvent.ACT, onImportTask);
		}
		
		private function onAddTask(e:AWEvent):void 
		{
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.AddText));
		}
		
		private function onRemoveTask(e:AWEvent):void 
		{
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.AddImage));
		}
		
		private function onEditTask(e:AWEvent):void 
		{
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.SavePaper));
		}
		
		private function onImportTask(e:AWEvent):void 
		{
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.LoadPaper));
		}
		
	}

}