package view.paper
{
	import controller.Dispatcher;
	import controller.GameController;
	import controller.GameEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import org.aswing.ASColor;
	import org.aswing.AssetPane;
	import org.aswing.event.AWEvent;
	import org.aswing.geom.IntDimension;
	import org.aswing.JViewport;
	import view.gui.PreviewUI;
	
	/**
	 * 预览面板
	 * @author WorrySprite
	 */
	public class PreviewWin extends PreviewUI
	{
		private var asset:AssetPane;
		private var preview:Bitmap;
		private var viewport:JViewport;
		
		public function PreviewWin()
		{
			initView();
		}
		
		private function initView():void
		{
			setOpaque(true);
			setBackground(new ASColor(0xeeeeee, 1));
			preview = new Bitmap();
			asset = new AssetPane(preview);
			asset.setOpaque(true);
			asset.setBackground(new ASColor(0xFFFFFF, 1));
			viewport = new JViewport(asset);
			scrollpane.setViewport(viewport);
			
			btnSave.addActionListener(onSaveClick);
			btnBack.addActionListener(onBackClick);
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		private function onAdded(e:Event):void 
		{
			stage.addEventListener(Event.RESIZE, onResize);
			onResize(null);
		}
		
		private function onRemoved(e:Event):void 
		{
			stage.removeEventListener(Event.RESIZE, onResize);
		}
		
		private function onResize(e:Event):void 
		{
			var size:IntDimension = new IntDimension(stage.stageWidth, stage.stageHeight);
			scrollpane.setPreferredSize(size);
			setSize(size);
			paneButtons.x = (size.width - paneButtons.width) / 2;
			paneButtons.y = size.height - 100;
		}
		
		private function onBackClick(e:AWEvent):void
		{
			Dispatcher.dispatchEvent(new GameEvent(GameEvent.ShowNormal));
		}
		
		private function onSaveClick(e:AWEvent):void
		{
			btnSave.setEnabled(false);
			GameController.save.savePaper(preview.bitmapData);
		}
		
		public function previewPaper(paper:PaperView):void
		{
			var bmd:BitmapData = paper.getPreview();
			asset.setPreferredWidth(bmd.width);
			asset.setPreferredHeight(bmd.height);
			preview.bitmapData = bmd;
		}
	}
}