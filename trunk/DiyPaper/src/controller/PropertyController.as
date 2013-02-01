package controller
{
	import com.greensock.transform.TransformItem;
	import com.ryan.global.Global;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import model.ItemVo;
	import org.aswing.AsWingUtils;
	import org.aswing.JFrame;
	import view.ImagePane;
	import view.MainWindow;
	import view.paper.ImageView;
	import view.paper.TextView;
	import view.property.PropertyWin;
	import view.TextPane;
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
			Dispatcher.addEventListener(GameEvent.ShowProperty, showPropertyWin);
			Dispatcher.addEventListener(GameEvent.SWITCH_PROPERTY, switchPropertyWin);
			Dispatcher.addEventListener(GameEvent.BasePropertyChange, basePropertyChange);
		}
		
		private function basePropertyChange(e:GameEvent):void
		{
			for (var key:String in e.data)
			{
				cache.paper[key] = e.data[key];
			}
			MainWindow.paper.updateBase();
		}
		
		private function showPropertyWin(e:GameEvent):void
		{
			var winType:int = e.data.winType;
			var vo:ItemVo = e.data.vo;
			MainWindow.toolBar.propertyBar.setButtonType(winType);
			MainWindow.propertyWin.setType(winType, vo);
		}
		
		private function switchPropertyWin(e:GameEvent):void
		{
			var winType:int = e.data.winType;
			MainWindow.toolBar.propertyBar.setButtonType(winType);
			MainWindow.propertyWin.setType(winType);
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
				_property = new JFrame(AsWingUtils.getPopupAncestor(MainWindow.uiLayer), "属性");
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
		
//——————————————————————————————————————文字属性设置——————————————————————————————————————————
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
			//var matrix:Matrix = getTextVo().matrix;
			//var m:Matrix = new Matrix();
			//m.rotate(rotate / 180 * Math.PI);
			//matrix.concat(m);
			//changeTextProperty(["matrix"], [matrix]);
		}
		
		public function setTextXpos(x:Number):void
		{
			//var matrix:Matrix = getTextVo().matrix;
			//matrix.tx = x;
			//changeTextProperty(["matrix"], [matrix]);
		}
		
		public function setTextYpos(y:Number):void
		{
			//var matrix:Matrix = getTextVo().matrix;
			//matrix.ty = y;
			//changeTextProperty(["matrix"], [matrix]);
		}
		
		private function changeTextProperty(propertyList:Array, valueList:Array):void
		{
			if (item == null || propertyList == null || valueList == null || propertyList.length != valueList.length)
			{
				return;
			}
			
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
		
//——————————————————————————————————————图片属性设置——————————————————————————————————————————
		public function changeImgColor(color:uint, alpha:Number, redMultiplier:Number, greenMultiplier:Number, blueMultiplier:Number):void
		{
			
			var colorTransform:ColorTransform = new ColorTransform();
			colorTransform.color = color;
			colorTransform.redMultiplier = redMultiplier;
			colorTransform.greenMultiplier = greenMultiplier;
			colorTransform.blueMultiplier = blueMultiplier;
			
			changeImgProperty(["colorTransform", "alpha"], [colorTransform, alpha]);
		}
		
		private function changeImgProperty(propertyList:Array, valueList:Array):void
		{
			if (item == null || propertyList == null || valueList == null || propertyList.length != valueList.length)
			{
				return;
			}
			var img:ImageView = item.targetObject as ImageView;
			if (img == null)
			{
				return;
			}
			var vo:ItemVo = img.vo;
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
			img.vo = vo;
		}
		
		private function getImgVo():ItemVo
		{
			if (item == null)
			{
				return null;
			}
			var img:ImageView = item.targetObject as ImageView;
			if (img == null)
			{
				return null;
			}
			return img.vo;
		}
	}
}