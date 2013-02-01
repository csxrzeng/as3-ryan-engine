package view.thumb
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import org.aswing.AssetPane;
	import org.aswing.border.LineBorder;
	import org.aswing.BorderLayout;
	import org.aswing.JPanel;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class ThumbIcon extends JPanel
	{
		public static const SIZE:int = 45;
		
		private var bmp:Bitmap;
		private var shape:JPanel;
		
		public function ThumbIcon()
		{
			mouseChildren = false;
			buttonMode = true;
			super(new BorderLayout());
			setPreferredWidth(SIZE);
			setPreferredHeight(SIZE);
			setBorder(new LineBorder());
			
			bmp = new Bitmap();
			var asset:AssetPane = new AssetPane(bmp);
			asset.setPreferredWidth(SIZE);
			asset.setPreferredHeight(SIZE);
			append(asset, BorderLayout.CENTER);
		}
		
		public function setIcon(view:DisplayObject):void
		{
			var orignWidth:Number = view.width;
			var orignHeight:Number = view.height;
			view.width = view.height = SIZE;
			var bmd:BitmapData = new BitmapData(SIZE, SIZE);
			bmd.draw(view);
			bmp.bitmapData = bmd;
			view.width = orignWidth;
			view.height = orignHeight;
		}
	}
}