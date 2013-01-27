package view.toolbar
{
	import org.aswing.ASColor;
	import org.aswing.border.EmptyBorder;
	import org.aswing.BorderLayout;
	import org.aswing.JPanel;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class ToolBar extends JPanel 
	{
		public var saveBar:SaveBarWin;
		public var propertyBar:PropertyBarWin;
		
		public function ToolBar() 
		{
			super();
			setLayout(new BorderLayout());
			setOpaque(true);
			setBackground(new ASColor(0xa5ce1c, 1));
			
			saveBar = new SaveBarWin();
			append(saveBar, BorderLayout.WEST);

			propertyBar = new PropertyBarWin();
			append(propertyBar, BorderLayout.EAST);
		}
	}
}