package view.property
{
	import com.ryan.core.IDispose;
	import com.ryan.utils.pools.ObjectPool;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import model.BitmapDataCache;
	import model.style.FilterData;
	
	/**
	 * 图片项
	 * @author 曾宪荣
	 */
	public class BmpItem extends Sprite implements IDispose
	{
		public static const DEFAULT_SIZE:int = 36;
		
		protected var _size:Point = new Point(DEFAULT_SIZE, DEFAULT_SIZE);
		protected var _bmp:Bitmap;
		protected var _textField:TextField;
		protected var _vo:Object;
		protected var _icon:String = "";
		protected var _label:String = "";
		protected var _chosen:Boolean = false;
		protected var _gray:Boolean = false;
		
		public function BmpItem()
		{
			buttonMode = false;
			useHandCursor = false;
			mouseChildren = false;
			configUI();
		}
		
		/**
		 * 获取一个实例
		 * @param	vo
		 * @param	icon
		 * @param	num
		 * @return
		 */
		static public function create():BmpItem
		{
			return ObjectPool.getObject(BmpItem);
		}
		
		public function dispose():void
		{
			ObjectPool.disposeObject(this);
			_size.x = _size.y = DEFAULT_SIZE;
			_vo = null;
			_icon = "";
			_chosen = false;
			_gray = false;
			_bmp.bitmapData = null;
			_textField.text = "";
		}
		
		/**
		 * 获取或设置是否选中
		 * @param value
		 */
		public function get chosen():Boolean
		{
			return _chosen;
		}
		
		public function set chosen(value:Boolean):void
		{
			_chosen = value;
			setFilter();
		}
		
		public function get gray():Boolean
		{
			return _gray;
		}
		
		public function set gray(value:Boolean):void
		{
			_gray = value;
			setFilter();
		}
			
		/**
		 * 更新
		 * @param vo 数据VO
		 * @param icon 图标路径
		 * @param label 文字
		 */
		public function update(vo:*, icon:String = "", label:String = ""):void
		{
			_vo = vo;
			BitmapDataCache.getBmd(icon, _bmp, _size, null, true);
			this.label = label;
			setFilter();
		}
		
		public function get label():String
		{
			return _label;
		}
		
		public function set label(value:String):void
		{
			if (_label != value)
			{
				value == null && (value = ""); // 空对象处理
				_label = value;
				_textField.text = value;
			}
		}
		
		public function get bmp():Bitmap
		{
			return _bmp;
		}
		
		/**
		 * 子类可重写此方法实现不同的选中与变灰的效果
		 */
		protected function setFilter():void
		{
			var fts:Array = [];
			var fts2:Array = [];
			if (_chosen)
			{
				fts.push(FilterData.BagItemChosen);
			}
			if (_gray)
			{
				fts2.push(FilterData.colorMat);
			}
			this.filters = fts;
			this._bmp.filters = fts2;
		}
		
		protected function configUI():void
		{
			_bmp = new Bitmap();
			addChild(_bmp);
			_textField = new TextField();
			addChild(_textField);
			var tf:TextFormat = new TextFormat("宋体", 12, 0xFFFFFF);
			tf.align = TextFormatAlign.RIGHT;
			_textField.defaultTextFormat = tf;
			_textField.text = " ";
			_textField.height = _textField.textHeight + 4;
			_textField.filters = [FilterData.textShadow2]; // 文字描边
			_textField.mouseEnabled = false;
			_textField.selectable = false;
			setSizeWH(_size.x, _size.y);
		}
		
		/**
		 * 设置尺寸
		 * @param	w
		 * @param	h
		 */
		public function setSizeWH(w:int, h:int):void
		{
			_size.x = w;
			_size.y = h;
			_textField.width = _size.x;
			_textField.y = _size.y - _textField.height;
			update(_vo, _icon, label);
		}
		
		public function get dragView():DisplayObject
		{
			var result:Bitmap = ObjectPool.getObject(Bitmap);
			result.bitmapData = _bmp.bitmapData;
			result.width = _size.x;
			result.height = _size.y;
			result.x = x;
			result.y = y;
			return result;
		}
		
		public function get vo():*
		{
			return _vo;
		}
		
		public function get tipsVo():*
		{
			return _vo;
		}
	}
}