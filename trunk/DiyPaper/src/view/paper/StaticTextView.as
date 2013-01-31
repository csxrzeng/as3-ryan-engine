package view.paper 
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import model.ItemVo;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class StaticTextView extends TextField 
	{
		private var _vo:ItemVo;
		private var formate:TextFormat;
		
		public function StaticTextView() 
		{
			multiline = true;
			wordWrap = true;
			formate = new TextFormat();
		}
		
		public function get vo():ItemVo
		{
			
		}
		
		public function set vo(value:ItemVo):void
		{
			if (length == 0)
			{
				formate = defaultTextFormat;
			}
			else
			{
				formate = getTextFormat(0, length);
			}
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
	}

}