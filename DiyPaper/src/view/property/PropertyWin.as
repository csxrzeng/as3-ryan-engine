package view.property
{
	import model.ItemVo;
	import org.aswing.JFrame;
	import org.aswing.JPanel;
	
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
		
		private var lastPane:JPanel;
		
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
			show();
			if (lastPane)
			{
				getContentPane().remove(lastPane);
			}
			if (_type != type)
			{
				_type = type;
			}
			switch (type)
			{
				case BASE:
					setTitle("基本属性");
					lastPane = pBase;
					pBase.update();
					break;
				case STATIC_TEXT:
					if (data)
					{
						setTitle("静态文字属性");
					}
					else
					{
						setTitle("添加静态文字");
					}
					pStaticText.settingVo = data;
					pStaticText.updateUI();
					lastPane = pStaticText;
					break;
				case SPECIAL_TEXT:
					if (data)
					{
						setTitle("特效文字属性");
					}
					else
					{
						setTitle("添加特效文字");
					}
					lastPane = pSpecialText;
					pSpecialText.settingVo = data;
					break;
				case IMAGE:
					setTitle("图片属性");
					lastPane = pImage;
					pImage.settingVo = data;
					break;
				case LIBRARY:
					setTitle("在线图标");
					lastPane = pLibrary;
					break;
				case ASSETS:
					setTitle("我的素材");
					lastPane = pAssets;
					break;
			}
			getContentPane().append(lastPane);
			pack();
		}
		
		/**
		 * 更新当前对象的属性
		 * @param	data
		 */
		public function update(data:ItemVo):void 
		{
			setType(_type, data);
		}
	}
}