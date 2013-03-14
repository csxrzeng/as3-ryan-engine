package
{
	import com.ryan.global.Global;
	import com.ryan.resource.info.XMLInfo;
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
	import org.aswing.JPopup;
	import org.aswing.JWindow;
	import resource.Config;
	import resource.PaperResource;
	import resource.proxy.ResourceProxy;
	import view.gui.LoadingPane;
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
		private var loadingWin:JPopup;
		private var loadingPane:JWindow;
		private var loading:LoadingPane;
		
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
			LoaderManager.instance.load("config.xml?" + Math.random(), onConfigLoaded, 1, null, null, onConfigFailed);
		}
		
		private function onConfigLoaded(xmlinfo:XMLInfo):void 
		{
			Config.init(xmlinfo.xml);
			loadXMLs();
		}
		
		private function onConfigFailed(...rest):void 
		{
			JOptionPane.showMessageDialog("错误", "加载配置文件失败！");
		}
		
		private function loadXMLs():void
		{
			// specialfonts.xml, staticfonts.xml, library.xml
			var params:Object = root.loaderInfo.parameters;
			//params.templet = "D0uk0GdQS9WZ3We.xml"; // 测试
			//params.admin = 1;
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
			showProgress(1, 100);
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
				var pr:PaperResource = new PaperResource(Cache.instance.paper);
				// 需要加载字库，加载图片等。加载完成才能初始化
				pr.start(initWindow, onLoadError, onLoadProgress);
			}
			else
			{
				initWindow();
			}
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
			if (window)
			{
				window.setSizeWH(stage.stageWidth, stage.stageHeight);
			}
			if (loadingPane)
			{
				loadingPane.setSizeWH(stage.stageWidth, stage.stageHeight);
			}
		}
		
		private function onLoadError():void
		{
			JOptionPane.showMessageDialog("失败", "加载模版失败");
		}
		
		private function onLoadProgress(cur:Number, total:Number):void
		{
			showProgress(cur, total, "正在加载模版：");
		}
		
		private function showProgress(cur:Number, total:Number, desc:String = "正在努力加载中："):void
		{
			if (!loadingPane)
			{
				loadingPane = new JWindow();
				loadingPane.setSizeWH(stage.stageWidth, stage.stageHeight);
				loading = new LoadingPane();
				loadingPane.getContentPane().append(loading);
				loading.progressBar.setIndeterminate(true);
				loadingPane.show();
			}
			loading.label.setText(desc + int(cur / total * 100) + "%");
		}
		
		private function hideProgress():void
		{
			if (loadingPane)
			{
				loadingPane.hide();
				loading.progressBar.setIndeterminate(false);
				loadingPane.remove(loading);
				loading = null;
				loadingPane = null;
			}
		}
	}
}