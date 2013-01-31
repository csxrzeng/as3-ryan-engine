package view.property 
{
	import controller.Dispatcher;
	import controller.GameEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import model.Cache;
	import org.aswing.AssetPane;
	import org.aswing.event.AWEvent;
	import org.aswing.FlowWrapLayout;
	import org.aswing.geom.IntDimension;
	import org.aswing.JLoadPane;
	import resource.Config;
	import view.gui.ImageLibrary;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class LibraryPane extends ImageLibrary 
	{
		private var urlList:Vector.<String> = new Vector.<String>();
		private var iconList:Vector.<JLoadPane> = new Vector.<JLoadPane>();
		
		public function LibraryPane() 
		{
			configUI();
		}
		
		private function configUI():void 
		{
			pane.setLayout(new FlowWrapLayout(265, FlowWrapLayout.LEFT, 0, 0, false));
			spLibrary.setView(pane);
			btnOnline.setSelected(true);
			btnOnline.addEventListener(AWEvent.ACT, onOnlineClick);
			btnMyAssets.addEventListener(AWEvent.ACT, onMyAssetsClick);
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			pane.addEventListener(MouseEvent.CLICK, onPaneClick);
		}
		
		private function onPaneClick(e:MouseEvent):void 
		{
			var icon:JLoadPane = e.target as JLoadPane;
			if (icon)
			{
				var index:int = iconList.indexOf(icon);
				if (index != -1)
				{
					Dispatcher.dispatchEvent(new GameEvent(GameEvent.AddLibraryImage, urlList[index]));
				}
			}
		}
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			urlList = Cache.instance.assets.assetsList;
			for (var i:int = 0; i < urlList.length; i++) 
			{
				var icon:JLoadPane = new JLoadPane(Config.MEDIA_PATH + urlList[i] + ".jpg", AssetPane.PREFER_SIZE_IMAGE);
				icon.setPreferredSize(new IntDimension(65, 65));
				icon.mouseChildren = false;
				append(icon);
				iconList.push(icon);
			}
		}
		
		private function onOnlineClick(e:AWEvent):void 
		{
			btnOnline.setSelected(true);
		}
		
		private function onMyAssetsClick(e:AWEvent):void 
		{
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.ShowProperty, PropertyWin.ASSETS));
		}
		
	}

}