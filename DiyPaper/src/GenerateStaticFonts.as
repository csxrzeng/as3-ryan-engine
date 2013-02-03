package  
{
	import flash.display.Sprite;
	import flash.net.FileReference;
	import flash.text.Font;
	import flash.text.FontStyle;
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class GenerateStaticFonts extends Sprite
	{
		
		public function GenerateStaticFonts() 
		{
			var xml:XML = <data></data>;
			var arr:Array =[];
			arr.push("宋体");
			arr.push("隶书");
			arr.push("幼圆");
			arr.push("黑体");
			arr.push("方正舒体");
			arr.push("方正姚体");
			arr.push("华文彩云");
			arr.push("华文行楷");
			arr.push("华文琥珀");
			arr.push("华文楷体");
			arr.push("华文新魏");
			arr.push("微软雅黑");
			for each (var item:* in arr) 
			{
				xml.appendChild(<font name={item}></font>);
			}
			var file:FileReference = new FileReference();
			file.save(xml, "staticfonts.xml");
		}
		
	}

}