package view.thumb
{
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import model.ItemVo;
	import org.aswing.AsWingConstants;
	import org.aswing.JFrame;
	import org.aswing.JPanel;
	import org.aswing.JScrollPane;
	import org.aswing.SoftBoxLayout;
	import view.paper.StaticTextView;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class ThumbWin extends JFrame
	{
		private var scrollPane:JScrollPane;
		private var layers:JPanel;
		
		private var layerList:Vector.<ThumbIcon>;
		
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
			layers = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 2, AsWingConstants.BOTTOM));
			scrollPane = new JScrollPane(layers, JScrollPane.SCROLLBAR_ALWAYS, JScrollPane.SCROLLBAR_NEVER);
			setContentPane(scrollPane);
			layers.setPreferredWidth(45);
			layers.setPreferredHeight(300);
			pack();
			
			layerList = new Vector.<ThumbIcon>();
			layers.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			layers.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			if (draggingIcon)
			{
				draggingIcon.stopDrag();
				draggingIcon = null;
				layers.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			}
			upIcon = null;
			downIcon = null;
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			draggingIcon = e.target as ThumbIcon;
			if (draggingIcon)
			{
				var index:int = layerList.indexOf(draggingIcon);
				if (index > 0)
				{
					downIcon = layerList[index - 1];
				}
				if (index < layerList.length - 1)
				{
					upIcon = layerList[index + 1];
				}
				draggingIcon.startDrag(false, new Rectangle(0, 0, 0, layers.getHeight() - draggingIcon.height));
				layers.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			}
		}
		
		private function onMouseMove(e:MouseEvent):void
		{
			if (upIcon && upIcon.hitTestMouse())
			{
				swapLayer(draggingIcon, upIcon);
				upIcon.y -= upIcon.height;
			}
			else if (downIcon && downIcon.hitTestMouse())
			{
				swapLayer(draggingIcon, downIcon);
				downIcon.y += downIcon.height;
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
		
		public function addLayer(vo:ItemVo):void
		{
			if (vo.type == ItemVo.IMAGE)
			{
				addImage(vo);
			}
			else if (vo.type == ItemVo.SPECIAL_TEXT)
			{
				addText(vo);
			}
			else if (vo.type == ItemVo.STATIC_TEXT)
			{
				addStaticText(vo);
			}
		}
		
		private function addStaticText(vo:ItemVo):void
		{
			var icon:ThumbIcon = new ThumbIcon();
			var text:StaticTextView = new StaticTextView();
			text.vo = vo;
			icon.setIcon(text);
			layerList.push(icon);
			layers.append(icon);
		}
		
		private function addText(vo:ItemVo):void
		{
			
		}
		
		private function addImage(vo:ItemVo):void
		{
			
		}
	}
}