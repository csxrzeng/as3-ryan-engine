package
{
	import com.ryan.global.Global;
	import controller.GameController;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import org.aswing.AsWingManager;
	import org.aswing.UIManager;
	import view.laf.MyLookAndFeel;
	import view.MainWindow;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class Main extends Sprite
	{
		private var window:MainWindow;
		
		public function Main():void
		{
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
			UIManager.setLookAndFeel(new MyLookAndFeel());
			window = new MainWindow();
			window.setSizeWH(stage.stageWidth, stage.stageHeight);
			window.show();
			stage.addEventListener(Event.RESIZE, onStageResize);
			GameController.init();
		}
		
		private function onStageResize(e:Event):void
		{
			window.setSizeWH(stage.stageWidth, stage.stageHeight);
		}
	}
}