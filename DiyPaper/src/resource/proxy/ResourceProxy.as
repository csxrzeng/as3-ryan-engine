package resource.proxy 
{
	import model.ItemVo;
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class ResourceProxy 
	{
		public function ResourceProxy()
		{
			
		}
		
		/**
		 * 加载本地图片
		 * 对于administrator，会吧本地文件上传到服务器再加载url
		 * 对于user，直接读取文件到内存
		 * @param	onComplete 完成的回调函数 onComplete(bitmapData, extData);
		 * @param	onError 失败的回调 onError(desc);
		 */
		static public function loadLocalImage(onComplete:Function, onError:Function = null, extData:Object = null):void
		{
			var vo:ImageFileVo = new ImageFileVo();
			vo.onComplete = onComplete;
			vo.onError = onError;
			vo.extData = extData;
			vo.start();
		}
		
		/**
		 * 加载远程图片
		 * @param	onComplete 完成的回调函数 onComplete(bitmapData, extData);
		 * @param	onError 失败的回调 onError(desc);
		 * @param	extData
		 */
		static public function loadRemoteImage(url:String, onComplete:Function, onError:Function = null, extData:Object = null):void
		{
			var vo:RemoteImageVo = new RemoteImageVo(url);
			vo.onComplete = onComplete;
			vo.onError = onError;
			vo.extData = extData;
			vo.start();
		}
		
		/**
		 * 加载swf文件
		 * @param	onComplete 完成的回调函数 onComplete(displayObject, extData);
		 * @param	onError 失败的回调 onError(desc);
		 * @param	extData
		 */
		static public function loadSwf(url:String, onComplete:Function, onError:Function = null, extData:Object = null):void
		{
			var vo:SwfFileVo = new SwfFileVo(url);
			vo.onComplete = onComplete;
			vo.onError = onError;
			vo.extData = extData;
			vo.start();
		}
		
		/**
		 * 加载文字swf，（暂时先加载字库，以后换成动态生成）
		 * @param	onComplete
		 * @param	onError
		 * @param	extData
		 */
		static public function loadFont(vo:ItemVo, onComplete:Function, onError:Function = null):void
		{
			
		}
	}

}