package view.property 
{
	import view.gui.LoadingPane;
	
	/**
	 * ...
	 * @author 曾宪荣
	 */
	public class LoadPane extends LoadingPane 
	{
		
		public function LoadPane() 
		{
			
		}
		
		public function show():void
		{
			progressBar.setIndeterminate(true);
		}
		
		public function setProgress(cur:Number, total:Number, desc:String = "正在加载中："):void
		{
			label.setText(desc + int(cur / total * 100) + "%");
		}
		
		public function hide():void
		{
			progressBar.setIndeterminate(false);
			removeFromContainer();
		}
	}

}