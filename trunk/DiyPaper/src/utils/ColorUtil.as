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
			colorTransform.color = color.getRGB();
			colorTransform.alphaOffset = int(color.getAlpha() * 255 - 255);
			colorTransform.redMultiplier = multiplier;
			colorTransform.greenMultiplier = multiplier;
			colorTransform.blueMultiplier = multiplier;
			colorTransform.alphaMultiplier = 1;
			return colorTransform;
		}
	}

}