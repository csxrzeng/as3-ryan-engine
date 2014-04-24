package 
{
	import com.ryan.particle.TrianglesFall;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 曾宪荣
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			addChild(new TrianglesFall());
		}
		
	}
	
}