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
	import org.aswing.ASColor;
	import utils.ColorUtil;
	
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
			_textfield.embedFonts = true;
			_textfield.type = TextFieldType.DYNAMIC;
			_textfield.antiAliasType = AntiAliasType.ADVANCED;
			_textfield.autoSize = TextFieldAutoSize.LEFT;
			addChild(_textfield);
			
			_vo = new ItemVo(ItemVo.STATIC_TEXT);
			formate = new TextFormat();
		}
		
		/* INTERFACE view.paper.IItemView */
		
		public function update():void
		{
			var color:ASColor = ColorUtil.transform2Color(_vo.colorTransform);
			alpha = color.getAlpha();
			formate.color = color.getRGB();
			formate.font = _vo.font;
			formate.size = _vo.size;
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
			_item.update();
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
			return _vo;
		}
		
		public function set vo(value:ItemVo):void
		{
			_vo = value;
			update();
		}
	}
}