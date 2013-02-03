package view.property
{
	import controller.Dispatcher;
	import controller.GameEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import model.Cache;
	import model.PaperVo;
	import org.aswing.ASColor;
	import org.aswing.AsWingUtils;
	import org.aswing.colorchooser.JColorMixer;
	import org.aswing.Component;
	import org.aswing.event.AWEvent;
	import org.aswing.event.ColorChooserEvent;
	import org.aswing.event.InteractiveEvent;
	import org.aswing.geom.IntPoint;
	import org.aswing.JPopup;
	import view.cases.ColorIcon;
	import view.gui.BaseProperty;
	import view.MainWindow;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class BasePane extends BaseProperty
	{
		private var vo:PaperVo = Cache.instance.paper;
		private var pop:JPopup;
		private var colorMixer:JColorMixer;
		private var mixerOwner:Component;
		private var colorBg:ASColor;
		private var colorBorder:ASColor;
		private var color:ASColor;
		
		public function BasePane()
		{
			setClipMasked(false);
			colorBorder = new ASColor(0x000000, 1);
			colorMixer = new JColorMixer();
			pop = new JPopup(MainWindow.propertyWin);
			pop.append(colorMixer);
			colorMixer.setOpaque(true);
			colorMixer.setBackground(new ASColor(0xeeeeee, 1));
			pop.pack();
			sW.setMinimum(50);
			sW.setMaximum(3000);
			sH.setMinimum(50);
			sH.setMaximum(3000);
			sB.setMinimum(0);
			sB.setMaximum(100);
			setBgColor(new ASColor(0xFFFFFF, 1));
			update();
			configEvents(); // 一定要先update再添加事件，否则有点坑爹
		}
		
		public function setBgColor(color:ASColor):void
		{
			colorBg = color;
			btnBg.setIcon(new ColorIcon(colorBg, 16, 16));
		}
		
		public function update():void 
		{
			sW.setValue(vo.width);
			sH.setValue(vo.height);
			sB.setValue(vo.border);
			setBgColor(vo.background);
			colorBorder = vo.borderColor;
		}
		
		private function configEvents():void
		{
			sW.addEventListener(InteractiveEvent.STATE_CHANGED, onStateChange);
			sH.addEventListener(InteractiveEvent.STATE_CHANGED, onStateChange);
			sB.addEventListener(InteractiveEvent.STATE_CHANGED, onStateChange);
			sB.addEventListener(MouseEvent.ROLL_OVER, onBorderRollOver);
			sB.addEventListener(MouseEvent.ROLL_OUT, onBorderRollOut);
			btnBg.addEventListener(AWEvent.ACT, onBgAction);
			colorMixer.addEventListener(ColorChooserEvent.COLOR_ADJUSTING, onColorAdjusting);
			pop.addEventListener(AWEvent.HIDDEN, onPopHidden);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		private function onRemoved(e:Event):void 
		{
			pop.hide();
		}
		
		private function onStateChange(e:InteractiveEvent):void 
		{
			var w:int = sW.getValue();
			var h:int = sH.getValue();
			var b:int = sB.getValue();
			b = Math.min(b, int(w / 2), int(h / 2));
			sB.setValue(b);
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.BasePropertyChange, {width: w, height: h, border: b}));
		}
		
		private function onPopHidden(e:AWEvent):void
		{
			mixerOwner = null;
		}
		
		private function onColorAdjusting(e:ColorChooserEvent):void
		{
			if (mixerOwner == btnBg)
			{
				color = e.getColor();
				setBgColor(color);
				Dispatcher.dispatchEvent(new GameEvent(GameEvent.BasePropertyChange, {background: color}));
			}
			else if (mixerOwner == sB)
			{
				Dispatcher.dispatchEvent(new GameEvent(GameEvent.BasePropertyChange, {borderColor: e.getColor()}));
			}
		}
		
		private function onBorderRollOver(e:MouseEvent):void
		{
			if (mixerOwner != sB)
			{
				mixerOwner = sB;
				colorMixer.setSelectedColor(vo.borderColor);
				showMixer();
			}
		}
		
		private function onBorderRollOut(e:MouseEvent):void
		{
			if (!pop.hitTestMouse())
			{
				pop.hide();
			}
		}
		
		private function onBgAction(e:AWEvent):void
		{
			if (mixerOwner != btnBg)
			{
				mixerOwner = btnBg;
				colorMixer.setSelectedColor(vo.background);
				showMixer();
			}
			else
			{
				pop.hide();
			}
		}
		
		private function showMixer():void
		{
			if (mixerOwner)
			{
				var p:IntPoint = mixerOwner.getGlobalLocation();
				pop.setGlobalLocationXY(p.x + mixerOwner.width - pop.width, p.y + mixerOwner.height);
				pop.show();
			}
		}
	}
}