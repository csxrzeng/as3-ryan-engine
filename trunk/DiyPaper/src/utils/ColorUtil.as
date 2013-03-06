package utils
{
	import flash.geom.ColorTransform;
	import org.aswing.ASColor;
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class ColorUtil
	{
		
		public function ColorUtil()
		{
			
		}
		
		static public function color2ColorTransform(color:ASColor, percent:int = 100):ColorTransform
		{
			var multiplier:Number = percent / 100;
			var colorTransform:ColorTransform = new ColorTransform();
			colorTransform.redOffset = Math.round(color.getRed() * multiplier);
			colorTransform.greenOffset = Math.round(color.getGreen() * multiplier);
			colorTransform.blueOffset = Math.round(color.getBlue() * multiplier);
			colorTransform.alphaOffset = 0;
			colorTransform.redMultiplier = 1 - multiplier;
			colorTransform.greenMultiplier = 1 - multiplier;
			colorTransform.blueMultiplier = 1 - multiplier;
			colorTransform.alphaMultiplier = color.getAlpha();
			return colorTransform;
		}
		
		static public function transform2Color(transform:ColorTransform):ASColor
		{
			var multiplier:Number = 1 - transform.redMultiplier;
			var r:int = multiplier == 0 ? 0 : Math.round(transform.redOffset / multiplier);
			var g:int = multiplier == 0 ? 0 : Math.round(transform.greenOffset / multiplier);
			var b:int = multiplier == 0 ? 0 : Math.round(transform.blueOffset / multiplier);
			var color:ASColor = new ASColor((r << 16) + (g << 8) + b, transform.alphaMultiplier);
			return color;
		}
		
		static public function transform2Multiplier(transform:ColorTransform):int
		{
			return Math.round((1 - transform.redMultiplier) * 100);
		}
		
		static public function transform2Alpha(transform:ColorTransform):int
		{
			return transform.alphaMultiplier * 100;
		}
	}

}