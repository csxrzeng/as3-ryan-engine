package controller
{
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class GameController
	{
		static public var addText:AddTextController;
		static public var addImage:AddImageController;
		static public var paper:PaperController;
		static public var property:PropertyController;
		static public var system:SystemController;
		
		public function GameController()
		{
		}
		
		static public function init():void 
		{
			addText = new AddTextController();
			addImage = new AddImageController();
			paper = new PaperController();
			property = new PropertyController();
			system = new SystemController();
		}
	}
}