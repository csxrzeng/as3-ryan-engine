package view.property
{
	import controller.Dispatcher;
	import controller.GameEvent;
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
			colorBorder = new ASColor(0x000000, 1);
			colorMixer = new JColorMixer();
			pop = new JPopup(AsWingUtils.getPopupAncestor(this));
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
			configEvents();
			setBgColor(new ASColor(0xFFFFFF, 1));
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
			btnBg.addEventListener(AWEvent.ACT, onBgAction);
			colorMixer.addEventListener(ColorChooserEvent.COLOR_ADJUSTING, onColorAdjusting);
			pop.addEventListener(AWEvent.HIDDEN, onPopHidden);
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
			mixerOwner = sB;
			colorMixer.setSelectedColor(vo.borderColor);
			showMixer();
		}
		
		private function onBgAction(e:AWEvent):void
		{
			mixerOwner = btnBg;
			colorMixer.setSelectedColor(vo.background);
			showMixer();
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