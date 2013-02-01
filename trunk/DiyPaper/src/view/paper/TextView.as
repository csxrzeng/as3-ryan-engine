package view.paper
{
	import com.greensock.transform.TransformItem;
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import model.ItemVo;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class TextView extends Sprite implements IItemView
	{
		private var _vo:ItemVo;
		private var formate:TextFormat;
		private var _item:TransformItem;
		private var _textfield:TextField;
		
		public function TextView()
		{
			_textfield = new TextField();
			//_textfield.multiline = true;
			//_textfield.wordWrap = true;
			//_textfield.embedFonts = true;
			_textfield.type = TextFieldType.INPUT;
			_textfield.antiAliasType = AntiAliasType.ADVANCED;
			_textfield.autoSize = TextFieldAutoSize.LEFT;
			addChild(_textfield);
			
			_vo = new ItemVo(ItemVo.STATIC_TEXT);
			formate = new TextFormat();
		}
		
		/* INTERFACE view.paper.IItemView */
		
		public function update():void 
		{
			alpha = _vo.alpha;
			formate.font = _vo.font;
			formate.size = _vo.size;
			formate.color = _vo.color;
			formate.bold = _vo.bold;
			formate.italic = _vo.italic;
			formate.leading = _vo.leading;
			formate.letterSpacing = _vo.letterSpacing;
			formate.align = _vo.align;
			formate.underline = _vo.underline;
			_textfield.defaultTextFormat = formate;
			if (_textfield.length > 0)
			{
				_textfield.setTextFormat(formate, 0, _textfield.length);
			}
			_textfield.text = _vo.text;
		}
		
		public function get item():TransformItem
		{
			return _item;
		}
		
		public function set item(value:TransformItem):void
		{
			_item = value;
		}
		
		public function get vo():ItemVo
		{
			if (_textfield.length == 0)
			{
				formate = _textfield.defaultTextFormat;
			}
			else
			{
				formate = _textfield.getTextFormat(0, _textfield.length);
			}
			//_vo.matrix = transform.matrix;
			_vo.alpha = alpha;
			_vo.font = formate.font;
			_vo.size = int(formate.size);
			_vo.color = uint(formate.color);
			_vo.bold = Boolean(formate.bold);
			_vo.italic = Boolean(formate.italic);
			_vo.leading = int(formate.leading);
			_vo.letterSpacing = int(formate.letterSpacing);
			_vo.align = formate.align;
			_vo.underline = formate.underline;
			_vo.text = _textfield.text;
			return _vo;
		}
		
		public function set vo(value:ItemVo):void
		{
			_vo = value;
			update();
		}
	}
}