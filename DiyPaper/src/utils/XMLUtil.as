package utils
{
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class XMLUtil
	{
		public function XMLUtil()
		{
		}
		
		static public function glowFilterToXML(filter:GlowFilter):XML
		{
			var xml:XML = <glowfilter/>;
			xml.@alpha = filter.alpha;
			xml.@blurX = filter.blurX;
			xml.@blurY = filter.blurY;
			xml.@color = filter.color;
			xml.@inner = filter.inner;
			xml.@knockout = filter.knockout;
			xml.@quality = filter.quality;
			xml.@strength = filter.strength;
			return xml;
		}
		
		static public function glowFilterFromXML(xml:XML):GlowFilter
		{
			var filter:GlowFilter = new GlowFilter();
			filter.alpha = xml.@alpha;
			filter.blurX = xml.@blurX;
			filter.blurY = xml.@blurY;
			filter.color = xml.@color;
			filter.inner = xml.@inner;
			filter.knockout = xml.@knockout;
			filter.quality = xml.@quality;
			filter.strength = xml.@strength;
			return filter;
		}
		
		static public function dropShadowFilterToXML(filter:DropShadowFilter):XML
		{
			var xml:XML = <dropshadowfilter/>;
			xml.@alpha = filter.alpha;
			xml.@angle = filter.angle;
			xml.@blurX = filter.blurX;
			xml.@blurY = filter.blurY;
			xml.@color = filter.color;
			xml.@distance = filter.distance;
			xml.@hideObject = filter.hideObject;
			xml.@inner = filter.inner;
			xml.@knockout = filter.knockout;
			xml.@quality = filter.quality;
			xml.@strength = filter.strength;
			return xml;
		}
		
		static public function dropShadowFilterFromXML(xml:XML):DropShadowFilter
		{
			var filter:DropShadowFilter = new DropShadowFilter();
			filter.alpha = xml.@alpha;
			filter.angle = xml.@angle;
			filter.blurX = xml.@blurX;
			filter.blurY = xml.@blurY;
			filter.color = xml.@color;
			filter.distance = xml.@distance;
			filter.hideObject = xml.@hideObject;
			filter.inner = xml.@inner;
			filter.knockout = xml.@knockout;
			filter.quality = xml.@quality;
			filter.strength = xml.@strength;
			return filter;
		}
		
		static public function colorTransformToXML(filter:ColorTransform):XML
		{
			var xml:XML = <colortransform/>;
			xml.@alphaMultiplier = filter.alphaMultiplier;
			xml.@alphaOffset = filter.alphaOffset;
			xml.@blueMultiplier = filter.blueMultiplier;
			xml.@blueOffset = filter.blueOffset;
			xml.@greenMultiplier = filter.greenMultiplier;
			xml.@greenOffset = filter.greenOffset;
			xml.@redMultiplier = filter.redMultiplier;
			xml.@redOffset = filter.redOffset;
			return xml;
		}
		
		static public function colorTransformFromXML(xml:XML):ColorTransform
		{
			var filter:ColorTransform = new ColorTransform();
			filter.alphaMultiplier = xml.@alphaMultiplier;
			filter.alphaOffset = xml.@alphaOffset;
			filter.blueMultiplier = xml.@blueMultiplier;
			filter.blueOffset = xml.@blueOffset;
			filter.greenMultiplier = xml.@greenMultiplier;
			filter.greenOffset = xml.@greenOffset;
			filter.redMultiplier = xml.@redMultiplier;
			filter.redOffset = xml.@redOffset;
			return filter;
		}
	}
}