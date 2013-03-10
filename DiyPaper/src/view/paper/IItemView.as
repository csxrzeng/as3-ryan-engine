package view.paper
{
	import com.greensock.transform.TransformItem;
	import flash.display.IBitmapDrawable;
	import model.ItemVo;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public interface IItemView extends IBitmapDrawable
	{
		function get item():TransformItem;
		function set item(value:TransformItem):void;
		
		function get vo():ItemVo;
		function set vo(value:ItemVo):void;
		
		function toXML():XML;
		
		function update():void;
	}
	
}