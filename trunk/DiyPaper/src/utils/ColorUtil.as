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
		
		
		static public function color2ColorTransform(color:ASColor, multiplier:Number):ColorTransform
		{
			var colorTransform:ColorTransform = new ColorTransform();
			colorTransform.redOffset = color.getRed();
			colorTransform.greenOffset = color.getGreen();
			colorTransform.blueOffset = color.getBlue();
			//trace(color.getAlpha());
			colorTransform.alphaOffset = 255 * (color.getAlpha() - 1);
			colorTransform.redMultiplier = multiplier;
			colorTransform.greenMultiplier = multiplier;
			colorTransform.blueMultiplier = multiplier;
			colorTransform.alphaMultiplier = 0;
			return colorTransform;
		}
	}

}