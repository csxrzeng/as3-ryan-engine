package view.paper 
{
	import com.greensock.transform.TransformItem;
	
	/**
	 * ...
	 * @author xr.zeng
	 */
	public interface IItemView 
	{
		function get item():TransformItem;
		function set item(value:TransformItem):void;
	}
	
}