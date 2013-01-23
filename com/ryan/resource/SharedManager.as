/**
 * @date	2012-4-23 上午11:10:42
 * @author  xr.zeng
 */
package com.ryan.resource
{
	import com.ryan.debug.Log;
	import com.ryan.resource.info.SharedInfo;
	import com.ryan.utils.AMFHelper;
	
	import flash.events.NetStatusEvent;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	import flash.utils.ByteArray;

	public class SharedManager
	{
		private static var _name:String = "smdLocalCache";
		private static var _instance:SharedManager;
		private var _data:SharedObject;
		private var _isDebug:Boolean = false;
		private var _isHoldApply:Boolean = false;
		public var showTipWin:Function;
		public var closeTipWin:Function;

		public function SharedManager()
		{
			if (_instance)
			{
				throw new Error("单例");
			}
		}

		public static function get instance():SharedManager
		{
			if (!_instance)
			{
				_instance = new SharedManager();
			}
			return _instance;
		}
		
		public function set isDebug(value:Boolean):void
		{
			_isDebug = value;
		}
		
		public function get isDebug():Boolean
		{
			return _isDebug;
		}
		
		public function get isHoldApply():Boolean
		{
			return _isHoldApply;
		}
		
		public function get hasInit():Boolean
		{
			return _data != null;
		}
		
		public function get isOpen():Boolean
		{
			if (!_isDebug && _data)
			{
				if (_data.data["isOpen"] == true || _data.data["isOpen"] == "true")
				{
					return true;
				}
			}
			return false;
		}

		public function init(name:String = "smdLocalCache"):void
		{
			_name = escape(name); 
			if (_data)
			{
				return;
			}
			try
			{
				_data = SharedObject.getLocal(_name);
				_data.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
				if (isOpen)
				{
					flushInfinity(); // 如果上次选择了开启，再次检查是否开启无限空间
				}
			}
			catch (e:Error)
			{
				Log.error("初始化本地缓存不成功");
			}
		}

		public function applyForInfinity():void
		{
			if (!_isDebug && !isOpen)
			{
				try
				{
					flushInfinity();
				}
				catch (e:Error)
				{
					Log.error(e.message);
				}
			}
		}
		
		public function deleteInfo(url:String):void
		{
			if (isOpen)
			{
				delete _data.data[escape(url)];
				try
				{
					var so:SharedObject = SharedObject.getLocal(escape(url));
					for (var key:String in so.data)
					{
						delete so.data[key];
					}
				}
				catch (e:Error)
				{
					Log.error("删除缓存失败：" + e.message);
				}
			}
		}

		public function write(si:SharedInfo):void
		{
			if (isOpen)
			{
				if (si.data != null)
				{
					var url:String = escape(si.url);
					try
					{
						var so:SharedObject = SharedObject.getLocal(url);
						so.data[si.url] = si.url;
						so.data["version"] = si.version;
						so.data["data"] = si.data;
						_data.data[url] = si.version;
					}
					catch (e:Error)
					{
						Log.error("写入缓存失败：" + e.message);
						_data.data["isOpen"] = false;
					}
				}
			}
		}
		
		public function checkIsExist(url:String, version:String):Boolean
		{
			if (isOpen)
			{
				return _data && _data.data[escape(url)] == version;
			}
			return false;
		}

		public function read(url:String):SharedInfo
		{
			if (isOpen)
			{
				try
				{
					var so:SharedObject = SharedObject.getLocal(escape(url));
					var ci:SharedInfo = new SharedInfo();
					ci.read(so.data);
					return ci;
				}
				catch (e:Error)
				{
					Log.error("读取缓存失败：" + e.message);
				}
			}
			return null;
		}

		private function escape(url:String):String
		{
			if (url)
			{
				var reg:RegExp = new RegExp("[~%&\\;:\"',<>?#]", "g");
				return url.replace(reg, "");
			}
			return null;
		}
		
		private function setIsOpen(value:Boolean):void
		{
			if (_data)
			{
				_data.data["isOpen"] = value;
			}
		}
		
		private function flushInfinity():void
		{
			if (!_isHoldApply && _data)
			{
				var status:String = _data.flush(11000000);
				if (status == SharedObjectFlushStatus.FLUSHED)
				{
					setIsOpen(true);
				}
				else if (status == SharedObjectFlushStatus.PENDING)
				{
					setIsOpen(false);
					_isHoldApply = true;
					if (showTipWin is Function)
					{
						showTipWin();
					}
				}
			}
		}

		private function onNetStatus(e:NetStatusEvent):void
		{
			if (_isHoldApply)
			{
				setIsOpen(e.info.code == "SharedObject.Flush.Success");
			}
			if (closeTipWin is Function)
			{
				closeTipWin();
			}
		}
	}
}
