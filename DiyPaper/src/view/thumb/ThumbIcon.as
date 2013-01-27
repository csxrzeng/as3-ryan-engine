package view 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import org.aswing.ASColor;
	import org.aswing.border.LineBorder;
	import org.aswing.EmptyLayout;
	import org.aswing.JPanel;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class ThumbIcon extends JPanel 
	{
		private var bmp:Bitmap;
		private var bmd:BitmapData;
		private var shape:JPanel;
		
		public function ThumbIcon() 
		{
			setLayout(new EmptyLayout());
			bmd = new BitmapData(45, 45, true, 0);
			bmp = new Bitmap(bmd);
			shape = new JPanel();
			shape.setBorder(new LineBorder(null, new ASColor(0xDDDDDD, 1), 1, 2));
			shape.setPreferredWidth(45);
			shape.setPreferredHeight(45);
			
			appendAll(bmp, shape);
		}
	}
}