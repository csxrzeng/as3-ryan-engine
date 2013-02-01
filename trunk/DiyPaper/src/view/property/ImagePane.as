package view.property 
{
	import model.ItemVo;
	import view.gui.ImageProperty;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class ImagePane extends ImageProperty 
	{
		private var _settingVo:ItemVo;
		
		public function ImagePane() 
		{
			configUI();
		}
		
		public function get settingVo():ItemVo 
		{
			return _settingVo;
		}
		
		public function set settingVo(value:ItemVo):void 
		{
			_settingVo = value;
			if (_settingVo)
			{
				update();
			}
		}
		
		
		private function configUI():void 
		{
			
		}
		
		private function update():void
		{
			
		}
	}

}