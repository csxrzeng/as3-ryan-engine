package resource
{
	import flash.display.BitmapData;
	import flash.media.Sound;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author
	 */
	public class MediaProxy
	{
		private static var instance:MediaProxy = null;
		
		public static function Instance():MediaProxy
		{
			return instance ||= new MediaProxy;
		}
		private var vDataIndex:Dictionary = new Dictionary;
		private var vDataList:Vector.<SMedia> = new Vector.<SMedia>;
		private var vCallbackList:Vector.<Object> = new Vector.<Object>();
		private var vFinishCurIndex:int = -1; // [ 0 - index ] 范围SMedia均为Standby状态
		private var vFinishMaxIndex:int = -1; // index 为目前Standby状态最大索引(会有小于该index并且非Standby状态的可能性)
		private var vLoadingIndex:int = -1; // index 为最近 download 的索引
		private var vLoadingCount:int = 0; //正在加载的数量
		private var vLoadingMax:int = 4; //同时加载的最大值
		private var vLoadLog:Vector.<String> = null;
		private var vProtectRule:Dictionary = new Dictionary;
		
		public function MediaProxy()
		{
		}
		
		private function add_callback(complete:Function, process:Function, begin:int, end:int):int
		{
			if (complete != null || process != null)
			{
				vCallbackList.push({Complete: complete, Process: process, beg: begin, end: end});
			}
			return (end - begin + 1);
		}
		
		private function run_callback():void
		{
			var TempCallbackList:Vector.<Object> = vCallbackList;
			vCallbackList = new Vector.<Object>();
			for each (var v:Object in TempCallbackList)
			{
				v.Process && v.Process(1, 1);
				v.Complete && v.Complete();
			}
			TempCallbackList.splice(0, TempCallbackList.length);
		}
		
		private function get_index(url:String):int
		{
			if (typeof vDataIndex[url] == 'undefined')
				return -1;
			return vDataIndex[url];
		}
		
		private function get_media(index:int):SMedia
		{
			if (index < 0 || index >= vDataList.length)
				return null;
			return vDataList[index];
		}
		
		private function load_media(url:String, unite_list:Vector.<String> = null):SMedia
		{
			var Media:SMedia = get_media(get_index(url));
			if (Media == null)
			{
				Media = new SMedia(url, unite_list, on_download_complete, on_download_progress);
				vDataList.push(Media);
				vDataIndex[url] = vDataList.length - 1;
			}
			return Media;
		}
		
		//download_next 有3个入口
		//1) 正常的start, LoadingCount < LoadingMax 时会发起一个Loading行为
		//2) Loaded 结束后, 会对下一个Uninit资源进行Loading
		//3) GcUrl 会对当前资源进行识别, 如果正在Loading状态被gc, 会对下个资源发起 Loading行为
		private function download_next():void
		{
			if (vLoadingCount >= vLoadingMax)
				return;
			if (vLoadingIndex + 1 < vDataList.length)
			{
				var Media:SMedia = vDataList[++vLoadingIndex];
				Media.Download();
				trace_log(Media.url);
				if (vLoadLog != null)
					vLoadLog.push(Media.url);
				if (++vLoadingCount >= vLoadingMax)
					return;
			}
			//Gc后可能会影响到部分callback导至callback无法正常被调用
			//当downloadNext没有触发到资源 Loading 行为时, 对所有callback进行容错调用
			if (vLoadingCount <= 0)
				run_callback();
		}
		
		private function trace_log(url:String):void
		{
		/*
		   if ( url.indexOf( 'media_unite.swf' ) >= 0 || url.indexOf( '.swf' ) < 0 || url.indexOf( 'sep_' ) >= 0 )
		   return;
		
		   var date:Date = new Date;
		   var hour:String = ( date.getHours() < 10 ? '0' : '' ) + date.getHours();
		   var minute:String = ( date.getMinutes() < 10 ? '0' : '' ) + date.getMinutes();
		   var second:String = ( date.getSeconds() < 10 ? '0' : '' ) + date.getSeconds();
		   var millisecond:String = date.getMilliseconds() + '';
		   if ( date.getMilliseconds() < 10 )
		   millisecond = '00' + millisecond;
		   else if ( date.getMilliseconds() < 100 )
		   millisecond = '0' + millisecond;
		
		 trace( hour + ':' + minute + ':' + second + ':' + millisecond + ': ' + url );*/
		}
		
		private function tidy_index(index:int):void
		{
			if (index <= vFinishCurIndex)
				--vFinishCurIndex;
			if (index <= vFinishMaxIndex)
				--vFinishMaxIndex;
			if (index <= vLoadingIndex)
				--vLoadingIndex;
			for each (var data:Object in vCallbackList)
			{
				if (index <= data.beg)
					--data.beg;
				if (index <= data.end)
					--data.end;
			}
			for (var key:String in vDataIndex)
			{
				var value:int = vDataIndex[key];
				if (index <= value)
					vDataIndex[key] = value - 1;
			}
		}
		
		private function on_download_progress(Media:SMedia):void
		{
			var index:int = get_index(Media.url);
			//遍历所有注册回调
			for each (var data:Object in vCallbackList)
			{
				var finish_count:Number = 0;
				for (var load_index:int = data.beg; load_index <= data.end; ++load_index)
				{
					var media:SMedia = vDataList[load_index];
					switch (media.state)
					{
						case SMedia.FINISHED: 
							finish_count += 1.0;
							break;
						case SMedia.LOADING: 
							if (media.bytesTotal > 0)
								finish_count += media.bytesLoaded / media.bytesTotal;
							break;
					}
				}
				if (index >= data.beg && index <= data.end)
					data.Process && data.Process(finish_count, data.end - data.beg + 1);
			}
		}
		
		private function on_download_complete(Media:SMedia):void
		{
			//递减总加载数
			--vLoadingCount;
			//重置 FinishIndex
			var index:int = get_index(Media.url);
			vFinishMaxIndex = Math.max(vFinishMaxIndex, index);
			for (var load_index:int = vFinishCurIndex + 1; load_index <= vLoadingIndex; ++load_index)
			{
				if (vDataList[load_index].state == SMedia.FINISHED)
					vFinishCurIndex = load_index;
				else
					break;
			}
			var TempCallbackList:Vector.<Object> = vCallbackList;
			vCallbackList = new Vector.<Object>();
			//遍历所有注册回调
			for (var i:int = 0; i < TempCallbackList.length; )
			{
				var data:Object = TempCallbackList[i];
				if (vFinishCurIndex >= data.end)
				{
					data.Process && data.Process(data.end - data.beg + 1, data.end - data.beg + 1);
					data.Complete && data.Complete();
					TempCallbackList.splice(i, 1);
					continue;
				}
				++i;
			}
			vCallbackList = TempCallbackList.concat(vCallbackList);
			download_next();
		}
		
		public function idle():Boolean
		{
			return (vLoadingCount < vLoadingMax);
		}
		
		public function lazy_count():int
		{
			return vLoadingMax - vLoadingCount;
		}
		
		public function busy_count():int
		{
			return vLoadingCount;
		}
		
		public function load(url:String):SMedia
		{
			return Instance().load_media(url);
		}
		
		public function start(complete:Function = null, process:Function = null):int
		{
			if (end())
			{
				if (vCallbackList.length > 0)
				{
					run_callback();
					start(complete, process);
				}
				else
				{
					process && process(1, 1);
					complete && complete();
					complete = null;
				}
				return 0;
			}
			var count:int = add_callback(complete, process, vFinishCurIndex + 1, vDataList.length - 1);
			download_next();
			return count;
		}
		
		public function end():Boolean
		{
			return (vFinishCurIndex + 1 >= vDataList.length);
		}
		
		//严重，强制性释放该url, 不要乱调用, 调用需要经过阿琦同意
		public function gc(data:*):void
		{
			var url:String = data as String;
			if (data as Array || data as Vector.<String>)
			{
				for each (url in data)
					gc(url);
				return;
			}
			for each (var rule:RegExp in vProtectRule)
			{
				if (rule.test(data as String))
					return;
			}
			var Media:SMedia = load(data);
			if (Media != null)
			{
				var CanGC:Boolean = true;
				if (Media.type == SMedia.TYPE_UNITE)
					CanGC = Media.UniteGC(data.substr(data.lastIndexOf('/') + 1));
				if (CanGC)
				{
					var state:uint = Media.state;
					var index:int = vDataIndex[Media.url];
					delete vDataIndex[Media.url];
					vDataList.splice(index, 1);
					//索引被移除, 需要对当前所有索引进行整理
					tidy_index(index);
					Media.Release();
					Media = null;
					if (state == SMedia.LOADING)
					{
						--vLoadingCount;
						download_next();
					}
				}
			}
		}
		
		public function transform_url(url:String):String
		{
			return url;
		}
		
		public function GetState(url:String):int
		{
			url = transform_url(url);
			var Media:SMedia = get_media(get_index(url));
			if (Media == null)
				return SMedia.NOEXIST;
			return Media.state;
		}
		
		public function GetData(url:String, complete:Function = null):*
		{
			var Media:SMedia = load(url);
			switch (Media.state)
			{
				case SMedia.UNINIT: 
					start();
					break;
				case SMedia.LOADING: 
					break;
				case SMedia.FINISHED: 
					return Media.GetData(url);
			}
			if (complete != null)
			{
				var index:int = get_index(Media.url);
				add_callback(complete, null, index, index);
			}
			return null;
		}
		
		public function GetBitmap(url:String, complete:Function = null):BitmapData
		{
			return GetData(url, complete);
		}
		
		public function GetSound(url:String, complete:Function = null):Sound
		{
			return GetData(url, complete);
		}
		
		public function GetLoader(url:String, absolute:Boolean = false):*
		{
			var Media:SMedia = load(url);
			switch (Media.state)
			{
				case SMedia.UNINIT: 
					start();
					break;
			}
			return Media.GetLoader(absolute);
		}
		
		public function CopyLoader(url:String):*
		{
			var Media:SMedia = load(url);
			switch (Media.state)
			{
				case SMedia.UNINIT: 
					start();
					break;
				case SMedia.LOADING: 
					break;
				case SMedia.FINISHED: 
					return Media.CopyLoader();
			}
			return null;
		}
		
		public function PushArray(UrlList:*):void
		{
			for each (var url:String in UrlList)
				load(url);
		}
		
		public function CheckArray(UrlList:*):int
		{
			for each (var url:String in UrlList)
			{
				var state:int = GetState(url);
				if (state != SMedia.FINISHED)
					return state;
			}
			return SMedia.FINISHED;
		}
		
		public function AddProtectRule(rule:RegExp):void
		{
			vProtectRule[rule.source] = rule;
		}
		
		public function GetMediaList():Vector.<SMedia>
		{
			return vDataList;
		}
		
		public function ClearLog():void
		{
			if (vLoadLog != null)
				vLoadLog.splice(0, vLoadLog.length);
			else
				vLoadLog = new Vector.<String>;
		}
		
		public function GetLog():Vector.<String>
		{
			return vLoadLog;
		}
	}
}