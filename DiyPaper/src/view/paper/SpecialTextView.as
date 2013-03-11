package view.paper
{
	import com.greensock.events.TransformEvent;
	import com.greensock.transform.TransformItem;
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import model.Cache;
	import model.FontVo;
	import model.ItemVo;
	import org.aswing.ASColor;
	import utils.ColorUtil;
	import utils.XMLUtil;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class SpecialTextView extends Sprite implements IItemView
	{
		private var _vo:ItemVo;
		private var formate:TextFormat;
		private var _item:TransformItem;
		private var _textfield:TextField;
		
		public function SpecialTextView()
		{
			mouseChildren = false;
			_textfield = new TextField();
			_textfield.embedFonts = true;
			_textfield.type = TextFieldType.DYNAMIC;
			_textfield.antiAliasType = AntiAliasType.ADVANCED;
			_textfield.autoSize = TextFieldAutoSize.LEFT;
			addChild(_textfield);
			
			//_vo = new ItemVo(ItemVo.STATIC_TEXT);
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
		
		public function toXML():XML
		{
			var xml:XML = <item/>;
			xml.type = _vo.type;
			xml.text = _vo.text;
			xml.font = _vo.font;
			xml.size = _vo.size;
			xml.bold = _vo.bold;
			xml.italic = _vo.italic;
			xml.leading = _vo.leading;
			xml.letterSpacing = _vo.letterSpacing;
			xml.align = _vo.align;
			xml.underline = _vo.underline;
			xml.appendChild(XMLUtil.colorTransformToXML(_vo.colorTransform));
			//xml.scaleX = _item.scaleX;
			//xml.scaleY = _item.scaleY;
			//xml.rotation = _item.rotation;
			//xml.x = _item.x;
			//xml.y = _item.y;
			return xml;
		}
	}
}