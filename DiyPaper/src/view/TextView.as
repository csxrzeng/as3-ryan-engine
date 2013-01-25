package view
{
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import model.ItemVo;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class TextView extends TextField
	{
		private var _vo:ItemVo;
		private var formate:TextFormat;
		
		public function TextView()
		{
			_vo = new ItemVo(ItemVo.TEXT);
			type = TextFieldType.INPUT;
			multiline = true;
			wordWrap = true;
			embedFonts = true;
			formate = new TextFormat();
		}
		
		public function get vo():ItemVo
		{
			formate = getTextFormat(0, length);
			_vo.matrix = transform.matrix;
			_vo.alpha = alpha;
			_vo.font = formate.font;
			_vo.size = int(formate.size);
			_vo.color = uint(formate.color);
			_vo.bold = Boolean(formate.bold);
			_vo.italic = Boolean(formate.italic);
			_vo.leading = int(formate.leading);
			_vo.letterSpacing = int(formate.letterSpacing);
			_vo.text = text;
			return _vo;
		}
		
		public function set vo(value:ItemVo):void
		{
			_vo = value;
			transform.matrix = _vo.matrix.clone();
			alpha = _vo.alpha;
			formate.font = _vo.font;
			formate.size = _vo.size;
			formate.color = _vo.color;
			formate.bold = _vo.bold;
			formate.italic = _vo.italic;
			formate.leading = _vo.leading;
			formate.letterSpacing = _vo.letterSpacing;
			defaultTextFormat = formate;
			setTextFormat(formate);
			text = _vo.text;
		}
	}

}