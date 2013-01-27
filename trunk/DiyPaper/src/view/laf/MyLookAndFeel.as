package view.laf 
{
	import org.aswing.plaf.basic.BasicLookAndFeel;
	import org.aswing.UIDefaults;
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class MyLookAndFeel extends BasicLookAndFeel
	{
		
		public function MyLookAndFeel() 
		{
			
		}
		
		override protected function initClassDefaults(table:UIDefaults):void 
		{
			super.initClassDefaults(table);
			var uiDefaults:Array = [
				"ColorMixerUI", MyBasicColorMixerUI
				];
			table.putDefaults(uiDefaults);
		}
	}

}