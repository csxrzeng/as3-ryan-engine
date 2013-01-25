package controller
{
	import com.greensock.transform.TransformItem;
	import com.ryan.global.Global;
	import flash.geom.Matrix;
	import model.ItemVo;
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
		private var item:TransformItem;
		
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
			item = e.data as TransformItem;
			if (item.targetObject is TextView)
			{
				textPane.setItem(item);
				property.setContentPane(textPane);
			}
			else if (item.targetObject is ImageView)
			{
				imagePane.setItem(item);
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
		
		public function deleteText():void
		{
			changeTextProperty(["text"], [""]);
		}
		
		public function changeTextColor(color:uint, alpha:Number):void
		{
			changeTextProperty(["color", "alpha"], [color, alpha]);
		}
		
		public function changeTextSpace(space:int):void
		{
			changeTextProperty(["letterSpacing"], [space]);
		}
		
		public function changeTextLeading(leading:int):void
		{
			changeTextProperty(["leading"], [leading]);
		}
		
		public function setTextBold(value:Boolean):void
		{
			changeTextProperty(["bold"], [value]);
		}
		
		public function setTextItalic(value:Boolean):void
		{
			changeTextProperty(["italic"], [value]);
		}
		
		public function changeTextSize(size:int):void
		{
			changeTextProperty(["size"], [size]);
		}
		
		public function changeTextRotate(rotate:Number):void
		{
			trace(rotate);
			var matrix:Matrix = getTextVo().matrix;
			var m:Matrix = new Matrix();
			m.rotate(rotate / 180 * Math.PI);
			matrix.concat(m);
			changeTextProperty(["matrix"], [matrix]);
		}
		
		public function setTextXpos(x:Number):void
		{
			var matrix:Matrix = getTextVo().matrix;
			matrix.tx = x;
			changeTextProperty(["matrix"], [matrix]);
		}
		
		public function setTextYpos(y:Number):void
		{
			var matrix:Matrix = getTextVo().matrix;
			matrix.ty = y;
			changeTextProperty(["matrix"], [matrix]);
		}
		
		private function changeTextProperty(propertyList:Array, valueList:Array):void
		{
			if (item == null || propertyList == null || valueList == null || propertyList.length != valueList.length)
			{
				return;
			}
			item.rotation
			var tf:TextView = item.targetObject as TextView;
			if (tf == null)
			{
				return;
			}
			var vo:ItemVo = tf.vo;
			try
			{
				for (var i:int = 0; i < propertyList.length; ++i)
				{
					vo[propertyList[i]] = valueList[i];
				}
			}
			catch (e:Error)
			{
				trace("要修改的属性不存在");
				return;
			}
			tf.vo = vo;
		}
		
		private function getTextVo():ItemVo
		{
			if (item == null)
			{
				return null;
			}
			var tf:TextView = item.targetObject as TextView;
			if (tf == null)
			{
				return null;
			}
			return tf.vo;
		}
	}

}