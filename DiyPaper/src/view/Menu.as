package view
{
	import flash.display.JointStyle;
	import flash.system.fscommand;
	import org.aswing.BorderLayout;
	import org.aswing.event.AWEvent;
	import org.aswing.JMenu;
	import org.aswing.JMenuBar;
	import org.aswing.JMenuItem;
	import org.aswing.JPanel;
	import org.aswing.KeySequence;
	import org.aswing.KeyStroke;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class Menu extends JPanel 
	{
		private var bar:JMenuBar;
		private var editMenu:JMenu;
		private var addTaskMenu:JMenuItem;
		private var editTaskMenu:JMenuItem;
		private var deleteTaskMenu:JMenuItem;
		private var helpMenu:JMenu;
		private var aboutMenu:JMenuItem;
		
		public function Menu() 
		{
			super();
			setLayout(new BorderLayout());
			
			bar = new JMenuBar();
			editMenu = new JMenu("编辑(&E)");
			addTaskMenu = new JMenuItem("添加日程");
			editTaskMenu = new JMenuItem("编辑日程");
			deleteTaskMenu = new JMenuItem("删除日程");
			helpMenu = new JMenu("帮助(&H)");
			aboutMenu = new JMenuItem("关于(&A)");
			
			addTaskMenu.setAccelerator(new KeySequence(KeyStroke.VK_CONTROL, KeyStroke.VK_A));
			editTaskMenu.setAccelerator(new KeySequence(KeyStroke.VK_CONTROL, KeyStroke.VK_E));
			deleteTaskMenu.setAccelerator(new KeySequence(KeyStroke.VK_CONTROL, KeyStroke.VK_D));
			
			//fscommand("trapallkeys", "true");
			
			append(bar, BorderLayout.CENTER);
			
			bar.appendAll(editMenu, helpMenu);
			
			editMenu.append(addTaskMenu);
			editMenu.append(editTaskMenu);
			editMenu.append(deleteTaskMenu);
			
			helpMenu.append(aboutMenu);
			
			addTaskMenu.addActionListener(onMenuAction);
			editTaskMenu.addActionListener(onMenuAction);
			deleteTaskMenu.addActionListener(onMenuAction);
			aboutMenu.addActionListener(onMenuAction);
			
		}
		
		private function onMenuAction(e:AWEvent):void 
		{
			var menu:JMenuItem = e.currentTarget as JMenuItem;
			trace(menu.getText() + " clicked!");
		}
		
	}

}