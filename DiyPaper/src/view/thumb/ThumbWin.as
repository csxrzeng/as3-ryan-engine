package view.thumb
{
	import org.aswing.BoxLayout;
	import org.aswing.JFrame;
	import org.aswing.JPanel;
	import org.aswing.JScrollPane;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class ThumbWin extends JFrame
	{
		private var scrollPane:JScrollPane;
		private var layers:JPanel;
		
		public function ThumbWin(owner:* = null, title:String = "", modal:Boolean = false)
		{
			super(owner, title, modal);
			configUI();
		}
		
		private function configUI():void
		{
			setResizable(false);
			layers = new JPanel(new BoxLayout(BoxLayout.Y_AXIS, 2));
			scrollPane = new JScrollPane(layers, JScrollPane.SCROLLBAR_ALWAYS, JScrollPane.SCROLLBAR_NEVER);
			setContentPane(scrollPane);
			layers.setPreferredWidth(45);
			layers.setPreferredHeight(300);
			pack();
		}
	}
}