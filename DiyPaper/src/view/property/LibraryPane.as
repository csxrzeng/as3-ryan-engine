package view.property 
{
	import controller.Dispatcher;
	import controller.GameEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import model.Cache;
	import model.style.FilterData;
	import org.aswing.AssetPane;
	import org.aswing.event.AWEvent;
	import org.aswing.FlowWrapLayout;
	import org.aswing.geom.IntDimension;
	import org.aswing.JLoadPane;
	import org.aswing.JPanel;
	import org.aswing.JScrollPane;
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
		private var pane:JPanel;
		
		public function LibraryPane() 
		{
			configUI();
		}
		
		private function configUI():void 
		{
			pane = new JPanel(new FlowWrapLayout(265, FlowWrapLayout.LEFT, 1, 1, false));
			pane.setPreferredWidth(265);
			spLibrary.setHorizontalScrollBarPolicy(JScrollPane.SCROLLBAR_NEVER);
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
				pane.append(icon);
				iconList.push(icon);
				icon.addEventListener(MouseEvent.ROLL_OVER, onIconRollOver);
				icon.addEventListener(MouseEvent.ROLL_OVER, onIconRollOut);
			}
		}
		
		private function onIconRollOver(e:MouseEvent):void 
		{
			var icon:JLoadPane = e.currentTarget as JLoadPane;
			icon.filters = FilterData.cardGlow;
		}
		
		private function onIconRollOut(e:MouseEvent):void 
		{
			var icon:JLoadPane = e.currentTarget as JLoadPane;
			icon.filters = null;
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