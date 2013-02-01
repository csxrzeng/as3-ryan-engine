package view.property
{
	import model.ItemVo;
	import org.aswing.JFrame;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class PropertyWin extends JFrame
	{
		static public const BASE:int = 1;
		static public const STATIC_TEXT:int = 2;
		static public const SPECIAL_TEXT:int = 3;
		static public const IMAGE:int = 4;
		static public const LIBRARY:int = 5;
		static public const ASSETS:int = 6;
		
		private var pStaticText:StaticTextPane;
		private var pSpecialText:SpecialTextPane;
		private var pBase:BasePane;
		private var pImage:ImagePane;
		private var pLibrary:LibraryPane;
		private var pAssets:AssetsPane;
		
		private var _type:int = 0;
		
		public function PropertyWin(owner:* = null, title:String = "", modal:Boolean = false)
		{
			super(owner, title, modal);
			setClipMasked(false);
			configUI();
		}
		
		private function configUI():void
		{
			setResizable(false);
			pStaticText = new StaticTextPane();
			pSpecialText = new SpecialTextPane();
			pBase = new BasePane();
			pImage = new ImagePane();
			pLibrary = new LibraryPane();
			pAssets = new AssetsPane();
			setType(BASE);
		}
		
		public function getType():int
		{
			return _type;
		}
		
		public function setType(type:int, data:ItemVo = null):void
		{
			if (_type != type)
			{
				_type = type;
			}
			switch (type)
			{
				case BASE:
					setTitle("基本属性");
					setContentPane(pBase);
					pBase.update();
					break;
				case STATIC_TEXT:
					setTitle("静态文字");
					setContentPane(pStaticText);
					pStaticText.settingVo = data;
					break;
				case SPECIAL_TEXT:
					setTitle("特效文字");
					setContentPane(pSpecialText);
					break;
				case IMAGE:
					setTitle("图片属性");
					setContentPane(pImage);
					break;
				case LIBRARY:
					setTitle("在线图标");
					setContentPane(pLibrary);
					break;
				case ASSETS:
					setTitle("我的素材");
					setContentPane(pAssets);
					break;
			}
			pack();
			show();
		}
	}
}