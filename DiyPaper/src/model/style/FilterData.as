package model.style
{
	import flash.filters.BevelFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;

	public class FilterData
	{
		//鼠标移到人物身上的选择边框
		static public const line1:GlowFilter = new GlowFilter(0xffffff,0.7,5,5,10);
		
		//人物名称的描边
		static public const line2:GlowFilter = new GlowFilter(0x300b00,0.8,3,3,10);
		
		/** 宠物选中框  **/
		static public const line3:GlowFilter = new GlowFilter(0xffff00,0.8,4,4,10);
		
		/** 提示文字边框  **/
		static public const line4:GlowFilter = new GlowFilter(0x000000,0.8,5,5,2);
		
		/** 提示文字边框  **/
		static public const line5:GlowFilter = new GlowFilter(0xffff00,1,3,3,10);
		/** 小地图边框  **/
		static public const line6:GlowFilter = new GlowFilter(0x00ffff,0.8,4,4,10);
		
		static public const line7:GlowFilter = new GlowFilter(0x000000, 1, 3, 3, 10);
		
		/** 任务文字边框  **/
		static public const line8:GlowFilter = new GlowFilter(0x000000, 1, 2, 2);
		/**
		 * 强描边
		 */
		static public const line9:GlowFilter = new GlowFilter(0, 1, 3, 3, 5);
		
		static public const bonfireColorMatrix:Array = [ -0.8280893564224243, 1.4064596891403198, 0.8616296052932739, 0,
														-27.94000244140625, 0.6753073334693909, 0.7749831676483154,
														-0.010290520265698433, 0, -27.940000534057617, 0.005707226227968931,
														2.4360597133636475, -1.0017670392990112, 0, -27.939998626708984, 0, 0, 0, 1, 0];
		
		static public const bonfireFilters:Array = [new ColorMatrixFilter(bonfireColorMatrix), new GlowFilter(0xFF0000, 1, 5, 5, 1)];
		
		/**
		 * 文字描边——黑
		 * @default
		 */
		static public const textShadow:GlowFilter = new GlowFilter(0x0, 1, 2, 2, 10, 1);
		
		/**
		 * 文字描边——黑2
		 * @default
		 */
		static public const textShadow2:GlowFilter = new GlowFilter(0x0, 1, 2, 2, 10, 2);
		
		/**
		 * 文字描边——黑3
		 * @default
		 */
		static public const textShadow3:GlowFilter = new GlowFilter(0x071a50, 1, 2, 2, 5, 3);
		
		/**
		 * 文字描边——黑4
		 * @default
		 */
		static public const textShadow4:GlowFilter = new GlowFilter(0x000000, 1, 2, 2, 3);
		
		/**
		 * 文字描边——黑5
		 */
		static public const textShadow5:GlowFilter = new GlowFilter(0x0, 0.9, 7, 7, 3, 1);
		
		/**
		 * Vip文本发光
		 */
		static public const textVip:GlowFilter = new GlowFilter(0xFF0000, 1, 5, 5, 3);
		
		
		static public const textWhite:GlowFilter = new GlowFilter(0xFFFFFF, 1, 0.8, 2, 2, 1, false, false);
		
		/**
		 * 表情移上去的高亮
		 * @default
		 */
		static public const faceGreen:GlowFilter = new GlowFilter(0x00ff00, 0.8, 3, 3, 2);
		
		/**
		 * 跑马灯文字
		 * @default
		 */
		static public const horseGlow:GlowFilter = new GlowFilter(0, 1, 2, 2, 3);
		/**
		 * 技能选中效果
		 */
		static public const skillSelected:GlowFilter = new GlowFilter(0xFFF3B0, 1, 4, 4, 2.5, 3);
		
		/**
		 * 右下角提示文字
		 * @default
		 */
		static public const LRGlow:GlowFilter = new GlowFilter(0, 1, 2, 2, 3);
		
		/**
		 * 快捷栏的默认选中
		 * @default
		 */
		static public const ShortcutChosen:GlowFilter = new GlowFilter(0xffff00, 0.8, 4, 4, 4);
		
		/**
		 * 按钮发光
		 * @default
		 */
		static public const btnYellowFilter:Array = [new GlowFilter(0xffff00, 1, 2, 2, 10, 3)];
		/**
		 * 按钮发光
		 * @default
		 */
		static public const btnGreenFilter:Array = [new GlowFilter(0x00ff00, 1, 2, 2, 10, 3)];
		/**
		 * 按钮发光强
		 * @default
		 */
		static public const btnBlueFilter:Array = [new GlowFilter(0x0000ff, 1, 4, 4, 10, 3)];
		/**
		 * 按钮发光黄强
		 * @default
		 */
		static public const btnYellowXFilter:Array = [new GlowFilter(0xffff00, 1, 4, 4, 10, 3)];
		/**
		 * 按钮黄色强强光
		 */
		static public const btnYellowXXFilter:Array = [new GlowFilter(0xffff00, 1, 10, 10)];
		/**
		 * 按钮边缘蓝光
		 */
		static public const overGlow:Array = [new GlowFilter(0x00FFFF, 1, 9, 9, 3.45, 3)];
		/**
		 * 副本翻牌卡片发光，伏魔卡片
		 */
		static public const cardGlow:Array = [new GlowFilter(0xFFFF00, 1, 10, 10,3, 2)];
		
		static public const cardShadow:Array = [new DropShadowFilter(5, 45, 0, 1, 5, 5, 0.8)];
		
		static public const lionKingdomDouble:Array = [new GlowFilter(0xFF9900, 1, 9, 9, 2, 3)];
		
		static public const BagItemChosen:Array =  [new GlowFilter(0xffff00, 0.8, 5, 5, 5)];
		
		public static const mat:Array =[0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0];
		/** 灰色滤镜 **/
		static public const colorMat:ColorMatrixFilter = new ColorMatrixFilter(mat);
		
		static private const FLOAT_DROP:DropShadowFilter = new DropShadowFilter(2, 45, 0, 1, 5, 5);
		
		static private const FLOAT_GLOW:GlowFilter = new GlowFilter(0, 1, 2, 2, 1.5);
		
		/**
		 * 蓝色漂浮文字的滤镜组，真气用
		 */
		static public const BLUE_FLOAT_TEXT:Array = [new BevelFilter(5, 45, 0x79EBFF, 1, 0x193AFF, 1, 5, 5), FLOAT_DROP, FLOAT_GLOW];
		/**
		 * 红色漂浮文字的滤镜组，伤害和暴击用
		 */
		static public const RED_FLOAT_TEXT:Array = [new BevelFilter(5, 45, 0xFFFF00, 1, 0xFF3300, 1, 5, 5), FLOAT_DROP, FLOAT_GLOW];
		/**
		 * 绿色漂浮文字的滤镜组，闪避用
		 */
		static public const GREEN_FLOAT_TEXT:Array = [new BevelFilter(5, 45, 0x66FF00, 1, 0x006633, 1, 5, 5), FLOAT_DROP, FLOAT_GLOW];
		/**
		 * 墨绿漂浮文字的滤镜组，经验用
		 */
		static public const DARK_GREEN_FLOAT_TEXT:Array = [new BevelFilter(5, 45, 0xB6D56E, 1, 0x56BC13, 1, 5, 5), FLOAT_DROP, FLOAT_GLOW];
		/**
		 * 黄色漂浮文字的滤镜组，绑定铜钱用
		 */
		static public const YELLOW_FLOAT_TEXT:Array = [new BevelFilter(5, 45, 0xFF6600, 1, 0xFF3300, 1, 5, 5), new DropShadowFilter(2, 45, 0, 1, 5, 5), new GlowFilter(0, 1, 2, 2, 1.5)];
		/**
		 * 紫色漂浮文字的滤镜组，宠物经验用
		 */
		static public const PURPLE_FLOAT_TEXT:Array = [new BevelFilter(5, 45, 0x571391, 1, 0x510F8C, 1, 5, 5), new DropShadowFilter(2, 45, 0, 1, 5, 5), new GlowFilter(0, 1, 2, 2, 1.5)];
		/**
		 * 荣誉商店发光
		 */
		static public const HONOR_SHOP_GLOW:Array = [new GlowFilter(0xFFFF00, 1)];
		static public const SELECTED_GEM:Array = [new GlowFilter(0x00FFFF,1,15,15,2,2)];
	}
}