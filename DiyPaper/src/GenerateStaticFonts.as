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
			var xml:XML =  <data></data>;var arr:Array = [];
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
			for each (var item:*in arr)
			{
				xml.appendChild(<font name={item} font={fontMap[item]}></font>);
			}
			var file:FileReference = new FileReference();
			file.save(xml, "staticfonts.xml");
		}
		private var fontMap:Object = {
			新细明体:"PMingLiU",
			细明体:"MingLiU",
			标楷体:"DFKai-SB",
			黑体:"SimHei",
			宋体:"SimSun",
			新宋体:"NSimSun",
			仿宋:"FangSong",
			楷体:"KaiTi",
			仿宋_GB2312:"FangSong_GB2312",
			楷体_GB2312:"KaiTi_GB2312",
			微软正黑体:"Microsoft JhengHei",
			微软雅黑:"Microsoft YaHei",

			隶书:"LiSu",
			幼圆:"YouYuan",
			华文细黑:"STXihei",
			华文楷体:"STKaiti",
			华文宋体:"STSong",
			华文中宋:"STZhongsong",
			华文仿宋:"STFangsong",
			方正舒体:"FZShuTi",
			方正姚体:"FZYaoti",
			华文彩云:"STCaiyun",
			华文琥珀:"STHupo",
			华文隶书:"STLiti",
			华文行楷:"STXingkai",
			华文新魏:"STXinwei"
		};
	}
}