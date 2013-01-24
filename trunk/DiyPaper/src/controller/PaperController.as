package controller
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import model.ItemVo;
	import model.PaperVo;
	import view.PaperView;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class PaperController extends Controller
	{
		private var file:FileReference;
		
		public function PaperController()
		{
		}
		
		public function addText(item:ItemVo):void 
		{
			paper.addText(item);
		}
		
		override protected function initServer():void
		{
			Dispatcher.addEventListener(GameEvent.NewPaper, newPaperProcessor);
			Dispatcher.addEventListener(GameEvent.SavePaper, savePaperProcessor);
			Dispatcher.addEventListener(GameEvent.LoadPaper, loadPaperProcessor);
		}
		
		private function newPaperProcessor(e:GameEvent):void
		{
			var vo:PaperVo = new PaperVo();
			vo.width = 500;
			vo.height = 300;
			paper.vo = vo;
		}
		
		private function savePaperProcessor(e:GameEvent):void
		{
			var data:ByteArray = new ByteArray();
			data.writeUTFBytes(paper.vo.toXML());
			var file:FileReference = new FileReference();
			file.addEventListener(Event.COMPLETE, onSaveComplete);
			file.save(data);
		}
		
		private function onSaveComplete(e:Event):void
		{
			trace("save complete");
		}
		
		private function loadPaperProcessor(e:GameEvent):void
		{
			file = new FileReference();
			file.addEventListener(Event.SELECT, onSelected);
			file.browse();
		}
		
		private function onSelected(e:Event):void
		{
			file.removeEventListener(Event.SELECT, onSelected);
			file.addEventListener(Event.COMPLETE, onLoadComplete);
			file.load();
		}
		
		private function onLoadComplete(e:Event):void
		{
			trace("load complete");
			var bytes:ByteArray = file.data as ByteArray;
			var str:String = bytes.readUTFBytes(bytes.length);
			var xml:XML = XML(str);
			var vo:PaperVo = new PaperVo();
			vo.fromXML(xml);
			paper.vo = vo;
		}
		
		public function get paper():PaperView 
		{
			return Main.paperContainer;
		}
	}
}