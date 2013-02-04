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
	import flash.utils.ByteArray;
	import model.PaperVo;
	import org.aswing.AssetPane;
	import org.aswing.event.AWEvent;
	import org.aswing.JViewport;
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
			preview = new Bitmap();
			asset = new AssetPane(preview);
			viewport = new JViewport(asset);
			scrollpane.setViewport(viewport);
			
			btnSave.addActionListener(onSaveClick);
			btnBack.addActionListener(onBackClick);
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
			var bmd:BitmapData = new BitmapData(paper.width, paper.height);
			bmd.draw(paper);
			preview.bitmapData = bmd;
			
			var vo:PaperVo = paper.getVo();
			asset.setPreferredWidth(vo.width);
			asset.setPreferredHeight(vo.height);
		}
		
		private function savePaper():void
		{
			var encoder:JPEGEncoder = new JPEGEncoder(80);
			var bytes:ByteArray = encoder.encode(preview.bitmapData);
			
			var request:URLRequest = new URLRequest("savefile.php");
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
		}
		
		private function onSaveComplete(e:Event):void
		{
			//检查php返回结果
		}
	}
}