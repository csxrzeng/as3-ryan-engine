package com.ryan.keyBoard
{
	import com.ryan.global.Global;
	
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;
	import flash.system.IME;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	[Event(name="key_down", type="com.ryan.keyBoard.KeyEvent")]
	[Event(name="key_up", type="com.ryan.keyBoard.KeyEvent")]
	/**
	 *  键盘按键管理
	 * @author kbq
	 * 
	 */	
	public class KeyBoardManager extends EventDispatcher
	{
		private static var _keyMap:Object = {};
		
		private static var _instance:KeyBoardManager;
		
		private static var _stage:Stage;
		
		public static var ctrlKey:Boolean;
		
		public static var altKey:Boolean;
		
		public function KeyBoardManager()
		{
			if(_instance != null) throw new Error("KeyBoardManager 不能实例化");
			_instance = this;
		}

		public static function get instance():KeyBoardManager
		{
			if(_instance == null)
			{
				_instance = new KeyBoardManager();
			}
			return _instance;
		}
		
		public function start():void
		{
			_stage = Global.stage;
			if( _stage )
			{
				addListener();
			}
		}
		
		public static function addkeys(value:Array):void
		{
			if(value == null || value.length ==0) return;
			if(value[0] as KeyData == null)
			{
				throw new Error("addkeys(value:Array) value中不是KeyData类型");
			}
			
			var len:int = value.length;
			var itemData:KeyData;
			for(var i:int=0;i<len;i++)
			{
				itemData = value[i] as KeyData;
				_keyMap[itemData.keyCode] = itemData;
			}
		}
		
		public static function getKeyData(value:uint):KeyData
		{
			var keyData:KeyData = _keyMap[value] as KeyData;
			if(keyData == null)
			{
				keyData = new KeyData(value);
				keyData.isKeyDown = false;
				_keyMap[value] = keyData;
			}
			return keyData;
		}
		
		public function cancelListener():void
		{
			if(_stage)
			{
				_stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDownHandler);
				_stage.removeEventListener(KeyboardEvent.KEY_UP,onKeyUpHandler);
				_stage.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,onMouseFocusChangeHandler);
				_stage.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
			}
		}
		public function addListener():void
		{
			if(_stage)
			{
				_stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDownHandler,false,9999,false);
				_stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUpHandler,false,9999,false);
				_stage.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,onMouseFocusChangeHandler,false,9999,false);
				_stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler,false,9999,false);
			}
		}

		
		private function onMouseFocusChangeHandler( event:FocusEvent ):void
		{
			if( event.relatedObject is TextField)
			{
				if((event.relatedObject as TextField).type == TextFieldType.INPUT)
				{
					changeImeEnable(true);
				}
			}
			else
			{
				_stage.focus = _stage;
				changeImeEnable(false);
			}
		}
		
		public function changeImeEnable( enbled:Boolean ):void
		{
			if( enbled == IME.enabled ) return;
			if(Capabilities.hasIME)
			{
				try
				{
					IME.enabled = enbled;
				}
				catch(e:Error){};
			}
		}
		
		private function onMouseDownHandler(event:MouseEvent):void
		{
			KeyBoardManager.ctrlKey = event.ctrlKey;
			KeyBoardManager.altKey = event.altKey;
		}
		
		private function onKeyDownHandler(event:KeyboardEvent):void
		{	 
			var key:uint = event.keyCode;
			var keyData:KeyData = getKeyData(key);
//			if(keyData.isKeyDown == false) // 不限制按键重复
			{
				keyData.isKeyDown = true;
				var evt:KeyEvent = new KeyEvent(KeyEvent.KEY_DOWN);
				evt.keyEvent = event;
				dispatchEvent(evt);
			}
			event.stopImmediatePropagation();
		}
		
		private function onKeyUpHandler(event:KeyboardEvent):void
		{
			var key:uint = event.keyCode;
			var keyData:KeyData = getKeyData(key);
			if(keyData.isKeyDown == true)
			{
				keyData.isKeyDown = false;
				var evt:KeyEvent = new KeyEvent(KeyEvent.KEY_UP);
				evt.keyEvent = event;
				dispatchEvent(evt);
			}
			event.stopImmediatePropagation();
		}
	}
}