package com.ryan.resource.info
{
	import com.ryan.core.ClassProxy;
	import com.ryan.debug.Log;
	

	public class ResourceInfo extends ClassProxy
	{	
		public var name:String; // 名称
		
		public var time:String;	// 时间
		
		public var path:String; // 路径
		
		public var type:String; //类型
		
		private var _data:Object; // 数据
		
		public var extData:Object;// 扩展属性
		
		public var isLoaded:Boolean; // 是否加载
		
		public var isLoading:Boolean = false; //是否正在加载
		
		private var _referenceCount:int = 0;
		
		public function ResourceInfo( object:Object = null )
		{
			if( object )
			{
				//write(object);
				this.type = object.type;
				this.name = object.name;
				this.time = object.time;
				this.path = object.path + "?v="+object.time;
				Log.system(path);
			}
		}
		
		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data = value;
		}

		public function addReference():void
		{
			_referenceCount ++;
		}
		
		public function removeReference():void
		{
			_referenceCount --;
		}
		
		/**
		 * 销毁整个对象 
		 * 
		 */		
		public function dispose():void
		{
			_data = null;
			isLoaded = false;
			isLoading = false;
		}
		/**
		 * 卸载内部对象 
		 * 
		 */		
		public function unload():void
		{
			_data = null;
			isLoaded = false;
			isLoading = false;
			extData = null;
		}
	}
}