package view.paper
{
	import com.greensock.transform.TransformItem;
	import model.ItemVo;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public interface IItemView
	{
		function get item():TransformItem;
		function set item(value:TransformItem):void;
		
		function get vo():ItemVo;
		function set vo(value:ItemVo):void;
		
		function update():void;
	}
	
}