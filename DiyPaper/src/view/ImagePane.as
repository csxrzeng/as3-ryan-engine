package view{

import com.greensock.transform.TransformItem;
import controller.Dispatcher;
import controller.GameController;
import controller.GameEvent;
import model.ItemVo;
import org.aswing.*;
import org.aswing.border.*;
import org.aswing.colorchooser.*;
import org.aswing.event.AWEvent;
import org.aswing.event.ColorChooserEvent;
import org.aswing.ext.*;
import org.aswing.geom.*;
import view.paper.ImageView;

/**
 * ImagePane
 */
public class ImagePane extends JPanel{
	
	//members define
	private var colormixer:JColorMixer;
	private var btnReplace:JButton;
	private var btnDelete:JButton;
	private var paneThumb:JPanel;
	private var txtR:JLabel;
	private var sliderR:JSlider;
	private var label11:JLabel;
	private var label12:JLabel;
	private var label15:JLabel;
	private var label16:JLabel;
	private var txtW:JTextField;
	private var txtH:JTextField;
	private var label18:JLabel;
	private var label19:JLabel;
	private var txtX:JTextField;
	private var txtY:JTextField;
	private var label22:JLabel;
	private var label23:JLabel;
	private var label24:JLabel;
	private var label25:JLabel;
	private var aRP:JAdjuster;
	private var aGP:JAdjuster;
	private var aBP:JAdjuster;
	private var label30:JLabel;
	private var label31:JLabel;
	private var label32:JLabel;
	private var txtHue:JLabel;
	private var sHue:JSlider;
	private var aRV:JAdjuster;
	private var aGV:JAdjuster;
	private var aBV:JAdjuster;
	
	/**
	 * ImagePane Constructor
	 */
	public function ImagePane(){
		//component creation
		setOpaque(true);
		setLocation(new IntPoint(0, 0));
		setSize(new IntDimension(350, 500));
		var border0:LineBorder = new LineBorder();
		border0.setColor(new ASColor(0x0, 1));
		border0.setThickness(1);
		border0.setRound(5);
		setBorder(border0);
		var layout1:EmptyLayout = new EmptyLayout();
		setLayout(layout1);
		
		colormixer = new JColorMixer();
		colormixer.setLocation(new IntPoint(20, 90));
		colormixer.setSize(new IntDimension(291, 192));
		
		btnReplace = new JButton();
		btnReplace.setLocation(new IntPoint(120, 40));
		btnReplace.setSize(new IntDimension(80, 26));
		btnReplace.setText("替换素材");
		
		btnDelete = new JButton();
		btnDelete.setLocation(new IntPoint(220, 40));
		btnDelete.setSize(new IntDimension(80, 26));
		btnDelete.setText("删除素材");
		
		paneThumb = new JPanel();
		paneThumb.setLocation(new IntPoint(25, 15));
		paneThumb.setSize(new IntDimension(60, 60));
		
		txtR = new JLabel();
		txtR.setLocation(new IntPoint(20, 400));
		txtR.setSize(new IntDimension(70, 19));
		txtR.setText("旋转(0°)");
		txtR.setHorizontalAlignment(AsWingConstants.LEFT);
		
		sliderR = new JSlider();
		sliderR.setLocation(new IntPoint(100, 404));
		sliderR.setSize(new IntDimension(200, 14));
		sliderR.setValue(0);
		sliderR.setExtent(0);
		sliderR.setMinimum(0);
		sliderR.setMaximum(360);
		
		label11 = new JLabel();
		label11.setLocation(new IntPoint(20, 430));
		label11.setSize(new IntDimension(34, 19));
		label11.setConstraints("West");
		label11.setText("大小");
		label11.setHorizontalAlignment(AsWingConstants.LEFT);
		
		label12 = new JLabel();
		label12.setLocation(new IntPoint(20, 460));
		label12.setSize(new IntDimension(34, 19));
		label12.setText("位置");
		label12.setHorizontalAlignment(AsWingConstants.LEFT);
		
		label15 = new JLabel();
		label15.setLocation(new IntPoint(70, 430));
		label15.setSize(new IntDimension(28, 19));
		label15.setText("宽：");
		
		label16 = new JLabel();
		label16.setLocation(new IntPoint(180, 430));
		label16.setSize(new IntDimension(22, 19));
		label16.setText("高：");
		
		txtW = new JTextField();
		txtW.setLocation(new IntPoint(100, 429));
		txtW.setSize(new IntDimension(60, 22));
		txtW.setEditable(true);
		
		txtH = new JTextField();
		txtH.setLocation(new IntPoint(210, 429));
		txtH.setSize(new IntDimension(60, 22));
		txtH.setEditable(true);
		
		label18 = new JLabel();
		label18.setLocation(new IntPoint(70, 460));
		label18.setSize(new IntDimension(12, 19));
		label18.setText("x:");
		
		label19 = new JLabel();
		label19.setLocation(new IntPoint(180, 460));
		label19.setSize(new IntDimension(12, 19));
		label19.setText("y:");
		
		txtX = new JTextField();
		txtX.setLocation(new IntPoint(100, 460));
		txtX.setSize(new IntDimension(60, 22));
		txtX.setEditable(true);
		
		txtY = new JTextField();
		txtY.setLocation(new IntPoint(210, 460));
		txtY.setSize(new IntDimension(60, 22));
		txtY.setEditable(true);
		
		label22 = new JLabel();
		label22.setLocation(new IntPoint(20, 348));
		label22.setSize(new IntDimension(28, 19));
		label22.setText("高级");
		
		label23 = new JLabel();
		label23.setLocation(new IntPoint(70, 320));
		label23.setSize(new IntDimension(28, 19));
		label23.setText("红：");
		label23.setHorizontalAlignment(AsWingConstants.LEFT);
		label23.setVerticalAlignment(AsWingConstants.CENTER);
		
		label24 = new JLabel();
		label24.setLocation(new IntPoint(70, 347));
		label24.setSize(new IntDimension(28, 19));
		label24.setText("绿：");
		
		label25 = new JLabel();
		label25.setLocation(new IntPoint(70, 374));
		label25.setSize(new IntDimension(28, 19));
		label25.setText("蓝：");
		
		aRP = new JAdjuster();
		aRP.setLocation(new IntPoint(100, 320));
		aRP.setSize(new IntDimension(60, 22));
		aRP.setColumns(3);
		
		aGP = new JAdjuster();
		aGP.setLocation(new IntPoint(100, 347));
		aGP.setSize(new IntDimension(60, 22));
		aGP.setColumns(3);
		
		aBP = new JAdjuster();
		aBP.setLocation(new IntPoint(100, 374));
		aBP.setSize(new IntDimension(60, 22));
		aBP.setColumns(3);
		
		label30 = new JLabel();
		label30.setLocation(new IntPoint(180, 320));
		label30.setSize(new IntDimension(32, 19));
		label30.setText("×R＋");
		
		label31 = new JLabel();
		label31.setLocation(new IntPoint(180, 347));
		label31.setSize(new IntDimension(27, 19));
		label31.setText("×G+");
		
		label32 = new JLabel();
		label32.setLocation(new IntPoint(180, 374));
		label32.setSize(new IntDimension(26, 19));
		label32.setText("×B+");
		
		txtHue = new JLabel();
		txtHue.setLocation(new IntPoint(20, 288));
		txtHue.setSize(new IntDimension(70, 19));
		txtHue.setText("变色(0)");
		txtHue.setHorizontalAlignment(AsWingConstants.LEFT);
		
		sHue = new JSlider();
		sHue.setLocation(new IntPoint(100, 290));
		sHue.setSize(new IntDimension(200, 14));
		sHue.setValue(100);
		sHue.setExtent(0);
		sHue.setMinimum(0);
		sHue.setMaximum(100);
		
		aRV = new JAdjuster();
		aRV.setMaximum(255);
		aRV.setMinimum( -255);
		aRV.setLocation(new IntPoint(220, 320));
		aRV.setSize(new IntDimension(60, 22));
		aRV.setColumns(3);
		
		aGV = new JAdjuster();
		aGV.setMaximum(255);
		aGV.setMinimum( -255);
		aGV.setLocation(new IntPoint(220, 347));
		aGV.setSize(new IntDimension(60, 22));
		aGV.setColumns(3);
		
		aBV = new JAdjuster();
		aBV.setMaximum(255);
		aBV.setMinimum( -255);
		aBV.setLocation(new IntPoint(220, 374));
		aBV.setSize(new IntDimension(60, 22));
		aBV.setColumns(3);
		
		//component layoution
		append(colormixer);
		append(btnReplace);
		append(btnDelete);
		append(paneThumb);
		append(txtR);
		append(sliderR);
		append(label11);
		append(label12);
		append(label15);
		append(label16);
		append(txtW);
		append(txtH);
		append(label18);
		append(label19);
		append(txtX);
		append(txtY);
		append(label22);
		append(label23);
		append(label24);
		append(label25);
		append(aRP);
		append(aGP);
		append(aBP);
		append(label30);
		append(label31);
		append(label32);
		append(txtHue);
		append(sHue);
		append(aRV);
		append(aGV);
		append(aBV);
		
		colormixer.addEventListener(ColorChooserEvent.COLOR_ADJUSTING, onColorChange);
		aRP.addActionListener(onAdvancedColorChange);
		aGP.addActionListener(onAdvancedColorChange);
		aBP.addActionListener(onAdvancedColorChange);
		
		aRV.addActionListener(onColorOffsetChange);
		aGV.addActionListener(onColorOffsetChange);
		aBV.addActionListener(onColorOffsetChange);
		
		Dispatcher.addEventListener(GameEvent.ShowProperty, onItemSelected);
	}
	
	private function onColorOffsetChange(e:AWEvent):void
	{
		var red:int = Math.max(aRV.getValue(), 0);
		var green:int = Math.max(aGV.getValue(), 0);
		var blue:int = Math.max(aBV.getValue(), 0);
		
		var color:ASColor = colormixer.getSelectedColor();
		colormixer.setSelectedColor(ASColor.getASColor(red, green, blue, color.getAlpha()));
	}
	
	private function onItemSelected(e:GameEvent):void
	{
		var item:TransformItem = e.data as TransformItem;
		var image:ImageView = item.targetObject as ImageView;
		if (image)
		{
			var imgItem:ItemVo = image.vo;
			if (imgItem.type == ItemVo.IMAGE)
			{
				var color:ASColor = new ASColor(imgItem.colorTransform.color, imgItem.alpha);
				colormixer.setSelectedColor(color);
				aRP.setValue(imgItem.colorTransform.redMultiplier * 100);
				aGP.setValue(imgItem.colorTransform.greenMultiplier * 100);
				aBP.setValue(imgItem.colorTransform.blueMultiplier * 100);
				
				aRV.setValue(imgItem.colorTransform.redOffset);
				aGV.setValue(imgItem.colorTransform.greenOffset);
				aBV.setValue(imgItem.colorTransform.blueOffset);
			}
		}
	}
	
	private function onColorChange(e:ColorChooserEvent):void
	{
		var color:ASColor = e.getColor();
		aRV.setValue(color.getRed());
		aGV.setValue(color.getGreen());
		aBV.setValue(color.getBlue());
		GameController.property.changeImgColor(color.getRGB(), color.getAlpha(),
												aRP.getValue() / 100, aGP.getValue() / 100, aBP.getValue() / 100);
	}
	
	private function onAdvancedColorChange(e:AWEvent):void
	{
		var color:ASColor = colormixer.getSelectedColor();
		GameController.property.changeImgColor(color.getRGB(), color.getAlpha(),
												aRP.getValue() / 100, aGP.getValue() / 100, aBP.getValue() / 100);
	}
	
	//_________getters_________
	
	public function getColormixer():JColorMixer{
		return colormixer;
	}
	
	public function getBtnReplace():JButton{
		return btnReplace;
	}
	
	public function getBtnDelete():JButton{
		return btnDelete;
	}
	
	
	
	public function getSliderR():JSlider{
		return sliderR;
	}
	
	
	
	
	
	public function getTxtW():JTextField{
		return txtW;
	}
	
	public function getTxtH():JTextField{
		return txtH;
	}
	
	
	
	public function getTxtX():JTextField{
		return txtX;
	}
	
	public function getTxtY():JTextField{
		return txtY;
	}
	
	
	
	
	
	public function getARP():JAdjuster{
		return aRP;
	}
	
	public function getAGP():JAdjuster{
		return aGP;
	}
	
	public function getABP():JAdjuster{
		return aBP;
	}
	
	
	
	
	
	public function getSHue():JSlider{
		return sHue;
	}
	
	public function getARV():JAdjuster{
		return aRV;
	}
	
	public function getAGV():JAdjuster{
		return aGV;
	}
	
	public function getABV():JAdjuster{
		return aBV;
	}
	
	public function setItem(item:TransformItem):void 
	{
		
	}
	
	
}
}
