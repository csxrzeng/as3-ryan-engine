package view.property 
{
	import controller.Dispatcher;
	import controller.GameEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import model.Cache;
	import model.library.AssetVo;
	import model.library.TypeVo;
	import model.style.FilterData;
	import org.aswing.AssetPane;
	import org.aswing.event.AWEvent;
	import org.aswing.event.InteractiveEvent;
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
		private var urlList:Vector.<AssetVo> = new Vector.<AssetVo>();
		private var iconList:Vector.<JLoadPane> = new Vector.<JLoadPane>();
		
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
			cbType.addSelectionListener(onTypeSelection);
		}
		
		private function onTypeSelection(e:InteractiveEvent):void 
		{
			var typeVo:TypeVo = cbType.getSelectedItem() as TypeVo;
			if (typeVo)
			{
				updateTypes(typeVo);
			}
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
			initTypes();
		}
		
		private function initTypes():void 
		{
			var types:Array = Cache.instance.assets.getTypeList();
			cbType.setListData(types);
			if (types.length > 0)
			{
				cbType.setSelectedIndex(0);
				updateTypes(types[0]);
			}
		}
		
		private function updateTypes(typeVo:TypeVo):void
		{
			pane.removeAll();
			iconList.length = 0;
			urlList = Cache.instance.assets.getAssetsList(typeVo.id);
			for (var i:int = 0; i < urlList.length; i++) 
			{
				var icon:JLoadPane = new JLoadPane(Config.MEDIA_PATH + urlList[i].thumb, AssetPane.PREFER_SIZE_IMAGE);
				icon.setPreferredSize(new IntDimension(64, 64));
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
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.ShowProperty, {winType:PropertyWin.ASSETS}));
		}
		
	}

}