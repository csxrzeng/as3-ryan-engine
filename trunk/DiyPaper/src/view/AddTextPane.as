package view
{
	import org.aswing.*;
	import org.aswing.border.*;
	import org.aswing.colorchooser.*;
	import org.aswing.ext.*;
	import org.aswing.geom.*;
	
	/**
	 * AddTextPane
	 */
	public class AddTextPane extends JPanel
	{
		//members define
		private var cbFont:JComboBox;
		private var label4:JLabel;
		private var btnConfirm:JButton;
		
		/**
		 * AddTextPane Constructor
		 */
		public function AddTextPane()
		{
			//component creation
			setBackground(new ASColor(0xffffff, 1));
			setSize(new IntDimension(300, 160));
			setConstraints("Center");
			var border0:LineBorder = new LineBorder();
			border0.setColor(new ASColor(0x0, 1));
			border0.setThickness(1);
			border0.setRound(5);
			setBorder(border0);
			var layout1:EmptyLayout = new EmptyLayout();
			setLayout(layout1);
			cbFont = new JComboBox();
			cbFont.setLocation(new IntPoint(75, 70));
			cbFont.setSize(new IntDimension(150, 22));
			cbFont.setConstraints("Center");
			cbFont.setMaximumRowCount(10);
			label4 = new JLabel();
			label4.setLocation(new IntPoint(0, 20));
			label4.setSize(new IntDimension(300, 30));
			label4.setConstraints("Center");
			label4.setText("注意：字体文件需要下载，请选择字体");
			btnConfirm = new JButton();
			btnConfirm.setLocation(new IntPoint(110, 115));
			btnConfirm.setSize(new IntDimension(80, 25));
			btnConfirm.setText("确  定");
			//component layoution
			append(cbFont);
			append(label4);
			append(btnConfirm);
		}
		
		//_________getters_________
		public function getCbFont():JComboBox
		{
			return cbFont;
		}
		
		public function getBtnConfirm():JButton
		{
			return btnConfirm;
		}
	}
}