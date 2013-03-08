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
	import org.aswing.AsWingManager;
	import resource.Config;
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
			params.templet = "076QAuI5QENrWZK.xml"; // 测试
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
				LoaderManager.instance.load(list[i], onLoaded);
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
		
		private function realInit():void
		{
			if (Config.TEMPLET_XML) // 存在模版
			{
				Cache.instance.paper.fromXML(XML(ResourceManager.getInfoByName(Config.XML_PATH + Config.TEMPLET_XML).data));
				// 需要加载字库，加载图片等。加载完成才能初始化
				initWindow();
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
			stage.addEventListener(Event.RESIZE, onStageResize);
		}
		
		private function onStageResize(e:Event):void
		{
			window.setSizeWH(stage.stageWidth, stage.stageHeight);
		}
	}
}