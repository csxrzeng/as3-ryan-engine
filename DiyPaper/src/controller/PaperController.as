package controller
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import model.ItemVo;
	import model.PaperVo;
	import org.aswing.JOptionPane;
	import utils.DateUtil;
	import utils.JPEGEncoder;
	import view.MainWindow;
	import view.paper.PaperView;
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class PaperController extends Controller
	{
		public function PaperController()
		{
			
		}
		
		public function addItem(item:ItemVo):void
		{
			paper.addItem(item);
		}
		
		override protected function initServer():void
		{
			Dispatcher.addEventListener(GameEvent.SavePaper, savePaperProcessor);
			Dispatcher.addEventListener(GameEvent.LoadPaper, loadPaperProcessor);
			Dispatcher.addEventListener(GameEvent.SaveToPng, saveToPngProcessor);
			Dispatcher.addEventListener(GameEvent.UpdateSelectItem, onUpdateSelecteItem);
			Dispatcher.addEventListener(GameEvent.DeleteSelectedItem, onDeleteSelectedItem);
		}
		
		private function onDeleteSelectedItem(e:GameEvent):void 
		{
			paper.removeSelectedItem(e.data);
		}
		
		private function onUpdateSelecteItem(e:GameEvent):void 
		{
			paper.updateItem(e.data);
		}
		
		private function saveToPngProcessor(e:GameEvent):void
		{
			var vo:PaperVo = cache.paper;
			var bmd:BitmapData = new BitmapData(vo.width, vo.height, true, 0xFFFFFFFF);
			bmd.draw(paper);
			var encoder:JPEGEncoder = new JPEGEncoder();
			var png:ByteArray = encoder.encode(bmd);
			saveByteArray(png, DateUtil.getDateString() + ".jpg");
		}
		
		private function savePaperProcessor(e:GameEvent):void
		{
			var data:ByteArray = new ByteArray();
			data.writeUTFBytes(cache.paper.toXML());
			saveByteArray(data, DateUtil.getDateString() + ".xml");
		}
		
		private function saveByteArray(data:ByteArray, fileName:String = null):void
		{
			var file:FileReference = new FileReference();
			file.addEventListener(Event.COMPLETE, onSaveComplete);
			file.save(data, fileName);
		}
		
		private function onSaveComplete(e:Event):void
		{
			JOptionPane.showMessageDialog("成功", "保存完成！");
		}
		
		private function loadPaperProcessor(e:GameEvent):void
		{
			var file:FileReference = new FileReference();
			file.addEventListener(Event.SELECT, onSelected);
			file.browse();
		}
		
		private function onSelected(e:Event):void
		{
			var file:FileReference = e.currentTarget as FileReference;
			file.removeEventListener(Event.SELECT, onSelected);
			file.addEventListener(Event.COMPLETE, onLoadComplete);
			file.load();
		}
		
		private function onLoadComplete(e:Event):void
		{
			JOptionPane.showMessageDialog("成功", "加载完成！");
			var file:FileReference = e.currentTarget as FileReference;
			var bytes:ByteArray = file.data as ByteArray;
			var str:String = bytes.readUTFBytes(bytes.length);
			var xml:XML = XML(str);
			var vo:PaperVo = cache.paper;
			vo.fromXML(xml);
		}
		
		public function get paper():PaperView
		{
			return MainWindow.paper;
		}
	}
}