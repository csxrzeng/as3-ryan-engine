package view.property 
{
	import controller.Dispatcher;
	import controller.GameEvent;
	import org.aswing.ASColor;
	import org.aswing.AsWingUtils;
	import org.aswing.colorchooser.JColorMixer;
	import org.aswing.Component;
	import org.aswing.event.AWEvent;
	import org.aswing.event.ColorChooserEvent;
	import org.aswing.Icon;
	import org.aswing.JPopup;
	import view.cases.ColorIcon;
	import view.gui.BaseProperty;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class BasePane extends BaseProperty 
	{
		private var pop:JPopup;
		private var colorMixer:JColorMixer;
		private var mixerOwner:Component;
		private var icon:Icon;
		
		private var colorBg:ASColor;
		private var colorBorder:ASColor;
		
		public function BasePane() 
		{
			colorBorder = new ASColor(0x000000, 1);
			colorMixer = new JColorMixer();
			pop = new JPopup(AsWingUtils.getPopupAncestor(this));
			pop.append(colorMixer);
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
		
		private function configEvents():void 
		{
			sW.addEventListener(AWEvent.ACT, onWidthAction);
			sH.addEventListener(AWEvent.ACT, onHeightAction);
			sB.addEventListener(AWEvent.ACT, onBorderAction);
			btnBg.addEventListener(AWEvent.ACT, onBgAction);
			colorMixer.addEventListener(ColorChooserEvent.COLOR_ADJUSTING, onColorAdjusting);
		}
		
		private function onColorAdjusting(e:ColorChooserEvent):void 
		{
			if (mixerOwner == btnBg)
			{
				Dispatcher.dispatchEvent(new GameEvent(GameEvent.BgColorChange, e.getColor()));
			}
			else if (mixerOwner == sB)
			{
				Dispatcher.dispatchEvent(new GameEvent(GameEvent.BorderColorChange, e.getColor()));
			}
		}
		
		private function onWidthAction(e:AWEvent):void 
		{
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.WidthChange, sW.getValue()));
		}
		
		private function onHeightAction(e:AWEvent):void 
		{
			
		}
		
		private function onBorderAction(e:AWEvent):void 
		{
			
		}
		
		private function onBgAction(e:AWEvent):void 
		{
			
		}
		
	}

}