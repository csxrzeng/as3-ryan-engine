package view.paper
{
	import com.ryan.global.Global;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import model.PaperVo;
	import org.aswing.AssetPane;
	import org.aswing.AsWingConstants;
	import org.aswing.event.AWEvent;
	import org.aswing.FlowLayout;
	import org.aswing.JButton;
	import org.aswing.JPanel;
	
	/**
	 * 预览面板
	 * @author WorrySprite
	 */
	public class PreviewWin extends JPanel
	{
		private var asset:AssetPane;
		private var preview:Bitmap;
		private var pbSave:JButton;
		
		public function PreviewWin()
		{
			super(new FlowLayout(AsWingConstants.CENTER));
			initView();
		}
		
		private function initView():void
		{
			setPreferredWidth(Global.stage.stageWidth);
			setPreferredHeight(Global.stage.stageHeight);
			
			preview = new Bitmap();
			asset = new AssetPane(preview);
			asset.setPreferredWidth(Global.stage.stageWidth);
			asset.setPreferredHeight(200);
			append(asset, AsWingConstants.CENTER);
			
			pbSave = new JButton("保存");
			append(pbSave);
			
			pbSave.addActionListener(onSaveClick);
		}
		
		private function onSaveClick(e:AWEvent):void
		{
			savePaper();
		}
		
		public function previewPaper(paper:PaperView):void
		{
			var bmd:BitmapData = new BitmapData(paper.width, paper.height);
			bmd.draw(paper);
			preview.bitmapData = bmd;
			
			var vo:PaperVo = paper.getVo();
			asset.setPreferredHeight(vo.height);
		}
		
		private function savePaper():void
		{
			
		}
	}
}