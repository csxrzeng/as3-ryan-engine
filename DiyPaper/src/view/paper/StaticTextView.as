package view.paper
{
	import com.greensock.transform.TransformItem;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import model.ItemVo;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class StaticTextView extends TextField implements IItemView
	{
		private var _vo:ItemVo;
		private var formate:TextFormat;
		private var _item:TransformItem;
		
		public function StaticTextView()
		{
			type = TextFieldType.INPUT;
			multiline = true;
			wordWrap = true;
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
			defaultTextFormat = formate;
			filters = [_vo.glowFilter, _vo.shadowFilter];
			if (length > 0)
			{
				setTextFormat(formate, 0, length);
			}
			text = _vo.text;
		}

		public function get item():TransformItem
		{
			return _item;
		}
		
		public function set item(value:TransformItem):void
		{
			_item = value;
		}
		
		public function set vo(value:ItemVo):void
		{
			_vo = value;
			update();
		}
		
		public function get vo():ItemVo
		{
			if (length == 0)
			{
				formate = defaultTextFormat;
			}
			else
			{
				formate = getTextFormat(0, length);
			}
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
			_vo.text = text;
			if (filters && filters.length)
			{
				_vo.glowFilter = filters[0];
				_vo.shadowFilter = filters[1];
			}
			return _vo;
		}
	}

}