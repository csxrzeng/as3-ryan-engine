package controller 
{
	import com.greensock.transform.TransformItem;
	import com.ryan.global.Global;
	import org.aswing.AsWingUtils;
	import org.aswing.JFrame;
	import view.ImagePane;
	import view.ImageView;
	import view.TextPane;
	import view.TextView;
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class PropertyController extends Controller 
	{
		private var _property:JFrame;
		private var _textPane:TextPane;
		private var _imagePane:ImagePane;
		
		public function PropertyController() 
		{
			
		}
		
		override protected function initServer():void 
		{
			Dispatcher.addEventListener(GameEvent.ShowProperty, showPropertyProcessor);
		}
		
		private function showPropertyProcessor(e:GameEvent):void 
		{
			if (!e.data)
			{
				property.hide();
				return;
			}
			var item:TransformItem = e.data as TransformItem;
			if (item.targetObject is TextView)
			{
				property.setContentPane(textPane);
			}
			else if (item.targetObject is ImageView)
			{
				property.setContentPane(imagePane);
			}
			property.pack();
			property.show();
			property.x = Global.stage.stageWidth - property.width;
			property.y = 30;
		}
		
		public function get property():JFrame 
		{
			if (!_property)
			{
				_property = new JFrame(AsWingUtils.getPopupAncestor(Main.uiContainer), "属性");
				_property.setResizable(false);
			}
			return _property;
		}
		
		public function get textPane():TextPane 
		{
			if (!_textPane)
			{
				_textPane = new TextPane();
			}
			return _textPane;
		}
		
		public function get imagePane():ImagePane 
		{
			if (!_imagePane)
			{
				_imagePane = new ImagePane();
			}
			return _imagePane;
		}
	}

}