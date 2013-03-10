package view.thumb
{
	import controller.Dispatcher;
	import controller.GameEvent;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import model.ItemVo;
	import org.aswing.AssetPane;
	import org.aswing.AsWingConstants;
	import org.aswing.FlowLayout;
	import org.aswing.JFrame;
	import org.aswing.JScrollPane;
	import org.aswing.JViewport;
	import view.MainWindow;
	import view.paper.IItemView;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class ThumbWin extends JFrame
	{
		private static const LIST_WIDTH:int = 50;
		private static const LIST_HEIGHT:int = 300;
		private static const ICON_GAP:int = 5;
		
		private var scrollPane:JScrollPane;
		private var viewport:JViewport;
		private var layers:Sprite;
		
		private var layerList:Vector.<ThumbIcon>;
		
		private var dy:Number;
		private var draggingIcon:ThumbIcon;
		private var upIcon:ThumbIcon;
		private var downIcon:ThumbIcon;
		private var lastLayer:int;
		
		public function ThumbWin(owner:* = null, title:String = "", modal:Boolean = false)
		{
			super(owner, title, modal);
			configUI();
		}
		
		public function updateAll():void
		{
			for each (var icon:ThumbIcon in layerList)
			{
				icon.view = icon.view;
			}
		}
		
		private function configUI():void
		{
			setResizable(false);
			setClosable(false);
			layers = new Sprite();
			var asset:AssetPane = new AssetPane(layers, AssetPane.PREFER_SIZE_BOTH);
			asset.setLayout(new FlowLayout(AsWingConstants.BOTTOM));
			asset.setPreferredWidth(LIST_WIDTH);
			asset.setPreferredHeight(LIST_HEIGHT);
			viewport = new JViewport(asset);
			viewport.setPreferredWidth(LIST_WIDTH);
			viewport.setPreferredHeight(LIST_HEIGHT);
			
			scrollPane = new JScrollPane(viewport, JScrollPane.SCROLLBAR_ALWAYS, JScrollPane.SCROLLBAR_NEVER);
			setContentPane(scrollPane);
			pack();
			
			layerList = new Vector.<ThumbIcon>();
			layers.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			Dispatcher.addEventListener(GameEvent.UpdateSelectItem, onSelectedItemUpdate);
		}
		
		private function onSelectedItemUpdate(e:GameEvent):void
		{
			var vo:ItemVo = e.data as ItemVo;
			var index:int = indexOfVo(vo);
			if (index != -1)
			{
				var icon:ThumbIcon =layerList[index];
				icon.view = MainWindow.paper.seletedItemView;
			}
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			draggingIcon = e.target as ThumbIcon;
			if (draggingIcon)
			{
				lastLayer = draggingIcon.view.vo.layer;
				dy = draggingIcon.y - e.stageY;
				layers.addChild(draggingIcon);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				MainWindow.paper.setItemSelected(draggingIcon.view.vo);
			}
		}
		
		private function onMouseMove(e:MouseEvent):void
		{
			draggingIcon.y = dy + e.stageY;
			resortIcons();
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			if (draggingIcon)
			{
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				draggingIcon = null;
				resortIcons();
			}
			upIcon = null;
			downIcon = null;
		}
		
		private function resortIcons(fireEvent:Boolean = true):void
		{
			layerList.sort(sortByY); // 按Y倒序排列
			var len:int = layerList.length;
			for (var i:int = 0; i < len; ++i)
			{
				layerList[i].view.vo.layer = len - i - 1;
				if (layerList[i] != draggingIcon)
				{
					layerList[i].y = i * (layerList[i].height + ICON_GAP) + ICON_GAP;
				}
			}
			viewport.updateUI();
			if (fireEvent && draggingIcon)
			{
				if (draggingIcon.view.vo.layer != lastLayer) // 层次不同了
				{
					lastLayer = draggingIcon.view.vo.layer;
					Dispatcher.dispatchEvent(new GameEvent(GameEvent.RESORT_LAYER))
				}
			}
		}
		
		private function sortByY(a:ThumbIcon, b:ThumbIcon):int
		{
			if (a.y < b.y)
			{
				return -1;
			}
			else if (a.y > b.y)
			{
				return 1;
			}
			return 0;
		}
				
		public function addLayer(item:IItemView):void
		{
			if (indexOf(item) != -1)
			{
				return;
			}
			item.vo.layer = layerList.length;
			var icon:ThumbIcon = new ThumbIcon();
			icon.view = item;
			layers.addChild(icon);
			layerList.push(icon);
			resortIcons(false);
			if (layers.height > LIST_HEIGHT)
			{
				viewport.getView().setPreferredHeight(layers.height);
			}
			viewport.updateUI();
		}
		
		public function deleteLayer(item:IItemView):void
		{
			var index:int = indexOf(item);
			if (index != -1)
			{
				var icon:ThumbIcon = layerList[index];
				if (icon.parent == layers)
				{
					layers.removeChild(icon);
				}
				layerList.splice(index, 1);
				resortIcons(false);
			}
		}
		
		public function updateLayer(item:IItemView):void
		{
			var index:int = indexOf(item);
			if (index != -1)
			{
				var icon:ThumbIcon = layerList[index];
				icon.view = icon.view;
			}
		}
		
		private function indexOf(item:IItemView):int
		{
			for (var i:int = 0; i < layerList.length; ++i)
			{
				if (layerList[i].view == item)
				{
					return i;
				}
			}
			return -1;
		}
		
		private function indexOfVo(vo:ItemVo):int
		{
			for (var i:int = 0; i < layerList.length; ++i)
			{
				if (layerList[i].view.vo == vo)
				{
					return i;
				}
			}
			return -1;
		}
	}
}