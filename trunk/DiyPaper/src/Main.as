package
{
	import com.ryan.global.Global;
	import com.ryan.resource.LoaderManager;
	import com.ryan.resource.ResourceManager;
	import controller.GameController;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Security;
	import model.Cache;
	import model.FontVo;
	import model.ItemVo;
	import org.aswing.AsWingManager;
	import org.aswing.JOptionPane;
	import resource.Config;
	import resource.proxy.ResourceProxy;
	import view.MainWindow;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class Main extends Sprite
	{
		private var window:MainWindow;
		private var list:Array;
		private var loadedNum:int;
		
		public function Main():void
		{
			Security.allowDomain("*");
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			Global.instance.initStage(stage);
			AsWingManager.initAsStandard(this);
			// specialfonts.xml, staticfonts.xml, library.xml
			var params:Object = root.loaderInfo.parameters;
			params.templet = "LCxCklz4Deb5seY.xml"; // 测试
			params.admin = 1;
			Config.isAdministrator = params.admin == "1"; // 管理员
			Config.TEMPLET_XML = params.templet; // 模版
			list = [
				Config.STATIC_FONT_XML,
				Config.SPECIAL_FONT_XML,
				Config.LIBRARY_XML
			];
			if (Config.TEMPLET_XML)
			{
				list.push(Config.XML_PATH + Config.TEMPLET_XML); // 加载模版
			}
			for (var i:int = 0; i < list.length; i++) 
			{
				LoaderManager.instance.load(list[i], onLoaded, 3, null, null, onFailed);
			}
		}
		
		private function onLoaded(...rest):void 
		{
			loadedNum++;
			if (loadedNum == list.length)
			{
				realInit();
			}
		}
		
		private function onFailed(...rest):void
		{
			JOptionPane.showMessageDialog("错误", "加载资源失败！");
		}
		
		private function realInit():void
		{
			if (Config.TEMPLET_XML) // 存在模版
			{
				Cache.instance.paper.fromXML(XML(ResourceManager.getInfoByName(Config.XML_PATH + Config.TEMPLET_XML).data));
				initWindow();
				// 需要加载字库，加载图片等。加载完成才能初始化
				for each (var item:ItemVo in Cache.instance.paper.items)
				{
					if (item.type == ItemVo.SPECIAL_TEXT)
					{
						var font:FontVo = Cache.instance.font.getSpecialFontByFont(item.font);
						ResourceProxy.loadFont(font, onFontComplete);
					}
				}
			}
			else
			{
				initWindow();
			}
		}
		
		private function onFontComplete(...rest):void 
		{
			MainWindow.paper.updateAll();
		}
		
		private function initWindow():void
		{
			GameController.init();
			window = new MainWindow();
			window.setSizeWH(stage.stageWidth, stage.stageHeight);
			window.show();
			MainWindow.paper.setVo(Cache.instance.paper);
			stage.addEventListener(Event.RESIZE, onStageResize);
		}
		
		private function onStageResize(e:Event):void
		{
			window.setSizeWH(stage.stageWidth, stage.stageHeight);
		}
	}
}