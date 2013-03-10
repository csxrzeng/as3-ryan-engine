package controller 
{
	import flash.display.BitmapData;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	import org.aswing.JOptionPane;
	import resource.Config;
	import utils.JPEGEncoder;
	import view.MainWindow;
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class SaveController extends Controller 
	{
		private var bitmapData:BitmapData;
		private var xml:XML;
		
		public function SaveController() 
		{
			
		}
		
		public function savePaper(bmd:BitmapData):void
		{
			bitmapData = bmd;
			xml = MainWindow.paper.getXML();
			setSaveButtonEnabled(false);
			saveBitmap();
		}
		
		private function saveXML():void
		{
			var request:URLRequest = new URLRequest(Config.UPLOAD_XML_URL);
			var vars:URLVariables = new URLVariables();
			if (true || !Config.PAPER_XML) // 每次都根据图片名字来保存XML
			{
				var index:int = Config.PAPER_IMAGE.lastIndexOf(".");
				if (index == -1)
				{
					JOptionPane.showMessageDialog("失败", "图片没有保存成功");
					return;
				}
				Config.PAPER_XML = Config.PAPER_IMAGE.substring(0, index) + ".xml";
			}
			vars.file = Config.PAPER_XML;
			vars.xml = xml.toXMLString();
			request.data = vars;
			request.method = URLRequestMethod.POST;
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onXMLSaveComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onXMLSaveError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onXMLSaveError);
			loader.load(request);
		}
		
		private function onXMLSaveComplete(e:Event):void 
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
			setSaveButtonEnabled(true);
		}
		
		private function onXMLSaveError(e:ErrorEvent):void 
		{
			JOptionPane.showMessageDialog("失败", "保存配置失败：" + e.text);
			setSaveButtonEnabled(true);
		}
		
		private function saveBitmap():void
		{
			var encoder:JPEGEncoder = new JPEGEncoder(80); // 设置图片品质，默认80
			var bytes:ByteArray = encoder.encode(bitmapData);

			var url:String = Config.UPLOAD_PAPER_URL;
			if (!Config.PAPER_IMAGE)
			{
				if (Config.isAdministrator && Config.TEMPLET_XML)
				{
					var index:int = Config.TEMPLET_XML.lastIndexOf(".");
					if (index != -1)
					{
						Config.PAPER_IMAGE = Config.PAPER_XML.substring(0, index) + ".jpg";
					}
				}
			}
			if (false && Config.PAPER_IMAGE) // 每次都用新的文件名，避免浏览器缓存的问题
			{
				url += "?file=" + encodeURIComponent(Config.PAPER_IMAGE);
			}
			var request:URLRequest = new URLRequest(url);
			request.contentType = encoder.contentType;
			request.data = bytes;
			request.method = URLRequestMethod.POST;
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onSaveComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSaveError);
			loader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			loader.load(request);
		}
		
		private function onProgress(e:ProgressEvent):void
		{
			trace("上传图片中：", e.bytesLoaded + "/" + e.bytesTotal);
		}

		private function onSaveError(e:ErrorEvent):void
		{
			//保存出错
			JOptionPane.showMessageDialog("失败", "保存图片失败：" + e.text);
			setSaveButtonEnabled(true);
		}
		
		private function onSaveComplete(e:Event):void
		{
			//检查php返回结果
			var loader:URLLoader = e.currentTarget as URLLoader;
			var vars:URLVariables = new URLVariables(loader.data);
			if (vars.result == 1)
			{
				if (Config.isAdministrator)
				{
					// 继续保存xml
					Config.PAPER_IMAGE = vars.file;
					saveXML();
					return;
				}
				else
				{
					JOptionPane.showMessageDialog("成功", vars.file);
				}
			}
			else
			{
				JOptionPane.showMessageDialog("失败", vars.desc);
			}
			setSaveButtonEnabled(true);
		}
		
		private function setSaveButtonEnabled(value:Boolean):void
		{
			MainWindow.previewWin.getBtnSave().setEnabled(value);
		}
	}
}