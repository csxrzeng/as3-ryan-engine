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
		
		static public function getRGB(argb:uint):uint
		{
			return argb & 0x00FFFFFF;
		}
		
		static public function getAlpha(argb:uint):Number
		{
			return argb >>> 24 / 255;
		}
		
		static public function getASColor(argb:uint):ASColor
		{
			return new ASColor(getRGB(argb), getAlpha(argb));
		}
		
		static private const CONST_MULTI:int = 1;
		
		/**
		 * 颜色转transform，7F7F7F为0，
		 * @param	color 
		 * @param	multi
		 * @return
		 */
		static public function color2ColorTransform(color:ASColor, multi:int = 0):ColorTransform
		{
			var multiplier:Number = multi / 100;
			var colorTransform:ColorTransform = new ColorTransform();
			colorTransform.redOffset = (color.getRed() - 0x7F) * CONST_MULTI;
			colorTransform.greenOffset = (color.getGreen() - 0x7F) * CONST_MULTI;
			colorTransform.blueOffset = (color.getBlue() - 0x7F) * CONST_MULTI;
			colorTransform.alphaOffset = 0;
			colorTransform.redMultiplier = 1 - multiplier;
			colorTransform.greenMultiplier = 1 - multiplier;
			colorTransform.blueMultiplier = 1 - multiplier;
			colorTransform.alphaMultiplier = color.getAlpha();
			return colorTransform;
		}
		
		/**
		 * transform转颜色，0转为7F7F7F
		 * @param	transform
		 * @return
		 */
		static public function transform2Color(transform:ColorTransform):ASColor
		{
			var r:int = Math.round(transform.redOffset / CONST_MULTI) + 0x7F;
			var g:int = Math.round(transform.greenOffset / CONST_MULTI) + 0x7F;
			var b:int = Math.round(transform.blueOffset / CONST_MULTI) + 0x7F;
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