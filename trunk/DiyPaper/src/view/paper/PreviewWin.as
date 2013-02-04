package view.paper
{
	import controller.Dispatcher;
	import controller.GameEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	import org.aswing.ASColor;
	import org.aswing.AssetPane;
	import org.aswing.event.AWEvent;
	import org.aswing.geom.IntDimension;
	import org.aswing.JOptionPane;
	import org.aswing.JViewport;
	import resource.Config;
	import utils.JPEGEncoder;
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
			savePaper();
		}
		
		public function previewPaper(paper:PaperView):void
		{
			var bmd:BitmapData = paper.getPreview();
			asset.setPreferredWidth(bmd.width);
			asset.setPreferredHeight(bmd.height);
			preview.bitmapData = bmd;
		}
		
		private function savePaper():void
		{
			btnSave.setEnabled(false);
			var encoder:JPEGEncoder = new JPEGEncoder(80);
			var bytes:ByteArray = encoder.encode(preview.bitmapData);
			
			var request:URLRequest = new URLRequest(Config.UPLOAD_PAPER_URL);
			request.contentType = encoder.contentType;
			request.data = bytes;
			request.method = URLRequestMethod.POST;
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onSaveComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSaveError);
			loader.load(request);
		}
		
		private function onSaveError(e:Event):void
		{
			//保存出错
			JOptionPane.showMessageDialog("失败", "保存失败");
			btnSave.setEnabled(true);
		}
		
		private function onSaveComplete(e:Event):void
		{
			//检查php返回结果
			var loader:URLLoader = e.currentTarget as URLLoader;
			var vars:URLVariables = new URLVariables(loader.data);
			if (vars.result == 1)
			{
				JOptionPane.showMessageDialog("成功", vars.file);
			}
			else
			{
				JOptionPane.showMessageDialog("失败", vars.desc);
			}
			btnSave.setEnabled(true);
		}
	}
}