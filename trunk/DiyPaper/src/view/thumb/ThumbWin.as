package view.thumb
{
	import controller.Dispatcher;
	import controller.GameEvent;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import model.ItemVo;
	import org.aswing.AssetPane;
	import org.aswing.JFrame;
	import org.aswing.JScrollPane;
	import org.aswing.JViewport;
	
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
		
		public function ThumbWin(owner:* = null, title:String = "", modal:Boolean = false)
		{
			super(owner, title, modal);
			configUI();
		}
		
		private function configUI():void
		{
			setResizable(false);
			layers = new Sprite();
			var asset:AssetPane = new AssetPane(layers, AssetPane.PREFER_SIZE_BOTH);
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
			var icon:ThumbIcon = layers.getChildAt(vo.layer) as ThumbIcon;
			if (icon)
			{
				icon.data = vo;
			}
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
		
		private function resortIcons():void
		{
			var icon:ThumbIcon;
			for (var i:int = 0; i < layerList.length; ++i)
			{
				icon = layerList[i];
				icon.y = i * (icon.height + ICON_GAP) + ICON_GAP;
			}
			//viewport.updateUI();
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			draggingIcon = e.target as ThumbIcon;
			if (draggingIcon)
			{
				dy = draggingIcon.y - e.stageY;
				updateNearbyIcon();
				stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			}
		}
		
		private function onMouseMove(e:MouseEvent):void
		{
			draggingIcon.y = dy + e.stageY;
			var px:Number = draggingIcon.width / 2;
			var py:Number = draggingIcon.height / 2;
			var globalPoint:Point = draggingIcon.localToGlobal(new Point(px, py));
			
			if (upIcon && upIcon.hitTestPoint(globalPoint.x, globalPoint.y))
			{
				swapLayer(draggingIcon, upIcon);
				upIcon.y -= upIcon.height + ICON_GAP;
				updateNearbyIcon();
				Dispatcher.dispatchEvent(new GameEvent(GameEvent.UP_LAYER, draggingIcon.data));
			}
			else if (downIcon && downIcon.hitTestPoint(globalPoint.x, globalPoint.y))
			{
				swapLayer(draggingIcon, downIcon);
				downIcon.y += downIcon.height + ICON_GAP;
				updateNearbyIcon();
				Dispatcher.dispatchEvent(new GameEvent(GameEvent.DOWN_LAYER, draggingIcon.data));
			}
		}
		
		private function swapLayer(icon1:ThumbIcon, icon2:ThumbIcon):void
		{
			var index1:int = layerList.indexOf(icon1);
			var index2:int = layerList.indexOf(icon2);
			if (index1 >= 0 && index2 >= 0)
			{
				layerList[index1] = icon2;
				layerList[index2] = icon1;
			}
		}
		
		private function updateNearbyIcon():void
		{
			var index:int = layerList.indexOf(draggingIcon);
			if (index > 0)
			{
				downIcon = layerList[index - 1];
			}
			else
			{
				downIcon = null;
			}
			if (index < layerList.length - 1)
			{
				upIcon = layerList[index + 1];
			}
			else
			{
				upIcon = null;
			}
		}
		
		public function addLayer(vo:ItemVo):void
		{
			vo.layer = layerList.length;
			var icon:ThumbIcon = new ThumbIcon();
			icon.data = vo;
			var index:int = layerList.push(icon) - 1;
			layers.addChild(icon);
			icon.y = index * (icon.height + ICON_GAP) + ICON_GAP;
			if (layers.height > LIST_HEIGHT)
			{
				viewport.getView().setPreferredHeight(layers.height);
			}
			viewport.updateUI();
		}
	}
}