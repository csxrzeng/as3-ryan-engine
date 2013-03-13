package view.property 
{
	import controller.Dispatcher;
	import controller.GameEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
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
		static private const COLUMN:int = 4;
		
		private var iconList:Vector.<JLoadPane> = new Vector.<JLoadPane>();
		private var urlList:Vector.<AssetVo> = new Vector.<AssetVo>();
		private var pageData:Vector.<AssetVo>;
		private var pageSize:int = 20;
		private var curPage:int = 0;
		private var maxPage:int = 1;
		
		public function LibraryPane() 
		{
			configUI();
		}
		
		private function configUI():void 
		{
			//pane = new JPanel(new FlowWrapLayout(265, FlowWrapLayout.LEFT, 1, 1, false));
			pane.setPreferredWidth(265);
			spLibrary.setHorizontalScrollBarPolicy(JScrollPane.SCROLLBAR_NEVER);
			spLibrary.setView(pane);
			btnOnline.setSelected(true);
			btnOnline.addEventListener(AWEvent.ACT, onOnlineClick);
			btnMyAssets.addEventListener(AWEvent.ACT, onMyAssetsClick);
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			pane.addEventListener(MouseEvent.CLICK, onPaneClick);
			cbType.addSelectionListener(onTypeSelection);
			var format:TextFormat = txtPage.getDefaultTextFormat();
			format.align = TextFormatAlign.CENTER;
			txtPage.setDefaultTextFormat(format);
			txtPage.setTextFormat(format);
			txtPage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			btnPre.addEventListener(AWEvent.ACT, onBtnPreAction);
			btnNext.addEventListener(AWEvent.ACT, onBtnNextAction);
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == 13)
			{
				var p:int = parseInt(txtPage.getText().split("/")[0]);
				if (!isNaN(p))
				{
					curPage = p;
					updatePageData();
				}
			}
		}
		
		private function onBtnPreAction(e:AWEvent):void 
		{
			--curPage;
			updatePageData();
		}
		
		private function onBtnNextAction(e:AWEvent):void 
		{
			++curPage;
			updatePageData();
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
				if (index != -1 && index < pageData.length)
				{
					Dispatcher.dispatchEvent(new GameEvent(GameEvent.AddLibraryImage, pageData[index]));
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
			pageSize = Cache.instance.assets.pageSize;
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
			urlList = Cache.instance.assets.getAssetsList(typeVo.id);
			maxPage = Math.max(1, Math.ceil(urlList.length / pageSize));
			curPage = 0;
			updatePageData();
		}
		
		private function updatePageData():void
		{
			// 清除
			iconList.length = 0;
			pane.removeAll();
			if (curPage < 0)
			{
				curPage = 0;
			}
			if (curPage >= maxPage)
			{
				curPage = maxPage - 1;
			}
			btnPre.setEnabled(curPage != 0);
			btnNext.setEnabled(curPage != maxPage - 1);
			txtPage.setText((curPage + 1) + "/" + maxPage);
			pageData = urlList.slice(curPage * pageSize, (curPage + 1) * pageSize);
			for (var i:int = 0; i < pageData.length; i++) 
			{
				var icon:JLoadPane = new JLoadPane(Config.MEDIA_PATH + pageData[i].thumb, AssetPane.PREFER_SIZE_IMAGE);
				icon.setPreferredSize(new IntDimension(64, 64));
				icon.mouseChildren = false;
				pane.append(icon);
				iconList.push(icon);
				icon.addEventListener(MouseEvent.ROLL_OVER, onIconRollOver);
				icon.addEventListener(MouseEvent.ROLL_OVER, onIconRollOut);
			}
			var rowCount:int = Math.ceil(pageData.length / COLUMN);
			var h:int = rowCount * 65 + 2;
			pane.setPreferredHeight(Math.max(h, 326));
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