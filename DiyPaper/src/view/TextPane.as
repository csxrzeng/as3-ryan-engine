package view{

import org.aswing.*;
import org.aswing.border.*;
import org.aswing.geom.*;
import org.aswing.colorchooser.*;
import org.aswing.ext.*;

/**
 * TextPane
 */
public class TextPane extends JPanel{
	
	//members define
	private var btnDelete:JButton;
	private var colormixer:JColorMixer;
	private var label80:JLabel;
	private var sSpacing:JStepper;
	private var label83:JLabel;
	private var sLeading:JStepper;
	private var cBlod:JCheckBox;
	private var cItalic:JCheckBox;
	private var label88:JLabel;
	private var aSize:JAdjuster;
	private var txtR:JLabel;
	private var sR:JSlider;
	private var label93:JLabel;
	private var label94:JLabel;
	private var sX:JStepper;
	private var label96:JLabel;
	private var sY:JStepper;
	
	/**
	 * TextPane Constructor
	 */
	public function TextPane(){
		//component creation
		setOpaque(true);
		setSize(new IntDimension(350, 500));
		var border0:LineBorder = new LineBorder();
		border0.setColor(new ASColor(0x0, 1));
		border0.setThickness(1);
		border0.setRound(5);
		setBorder(border0);
		var layout1:EmptyLayout = new EmptyLayout();
		setLayout(layout1);
		
		btnDelete = new JButton();
		btnDelete.setLocation(new IntPoint(215, 40));
		btnDelete.setSize(new IntDimension(80, 26));
		btnDelete.setText("删除文字");
		
		colormixer = new JColorMixer();
		colormixer.setLocation(new IntPoint(20, 90));
		colormixer.setSize(new IntDimension(291, 192));
		
		label80 = new JLabel();
		label80.setLocation(new IntPoint(20, 295));
		label80.setSize(new IntDimension(64, 19));
		label80.setText("字符间距");
		label80.setHorizontalAlignment(AsWingConstants.LEFT);
		
		sSpacing = new JStepper();
		sSpacing.setLocation(new IntPoint(85, 295));
		sSpacing.setSize(new IntDimension(58, 22));
		sSpacing.setColumns(3);
		
		label83 = new JLabel();
		label83.setLocation(new IntPoint(20, 325));
		label83.setSize(new IntDimension(34, 19));
		label83.setText("行距");
		label83.setHorizontalAlignment(AsWingConstants.LEFT);
		
		sLeading = new JStepper();
		sLeading.setLocation(new IntPoint(85, 325));
		sLeading.setSize(new IntDimension(58, 22));
		sLeading.setColumns(3);
		
		cBlod = new JCheckBox();
		cBlod.setLocation(new IntPoint(85, 385));
		cBlod.setSize(new IntDimension(49, 19));
		cBlod.setText("粗体");
		
		cItalic = new JCheckBox();
		cItalic.setLocation(new IntPoint(165, 385));
		cItalic.setSize(new IntDimension(46, 19));
		cItalic.setText("斜体");
		
		label88 = new JLabel();
		label88.setLocation(new IntPoint(20, 355));
		label88.setSize(new IntDimension(34, 19));
		label88.setText("字号");
		label88.setHorizontalAlignment(AsWingConstants.LEFT);
		
		aSize = new JAdjuster();
		aSize.setLocation(new IntPoint(85, 355));
		aSize.setSize(new IntDimension(60, 22));
		aSize.setColumns(3);
		
		txtR = new JLabel();
		txtR.setLocation(new IntPoint(20, 415));
		txtR.setSize(new IntDimension(70, 19));
		txtR.setText("旋转(0°)");
		txtR.setHorizontalAlignment(AsWingConstants.LEFT);
		
		sR = new JSlider();
		sR.setLocation(new IntPoint(95, 418));
		sR.setSize(new IntDimension(200, 14));
		sR.setValue(0);
		sR.setExtent(0);
		sR.setMinimum(0);
		sR.setMaximum(100);
		
		label93 = new JLabel();
		label93.setLocation(new IntPoint(20, 445));
		label93.setSize(new IntDimension(34, 19));
		label93.setText("位置");
		
		label94 = new JLabel();
		label94.setLocation(new IntPoint(80, 447));
		label94.setSize(new IntDimension(12, 19));
		label94.setText("x:");
		
		sX = new JStepper();
		sX.setLocation(new IntPoint(100, 445));
		sX.setSize(new IntDimension(58, 22));
		sX.setColumns(3);
		
		label96 = new JLabel();
		label96.setLocation(new IntPoint(190, 445));
		label96.setSize(new IntDimension(12, 19));
		label96.setText("y:");
		
		sY = new JStepper();
		sY.setLocation(new IntPoint(210, 445));
		sY.setSize(new IntDimension(58, 22));
		sY.setColumns(3);
		
		//component layoution
		append(btnDelete);
		append(colormixer);
		append(label80);
		append(sSpacing);
		append(label83);
		append(sLeading);
		append(cBlod);
		append(cItalic);
		append(label88);
		append(aSize);
		append(txtR);
		append(sR);
		append(label93);
		append(label94);
		append(sX);
		append(label96);
		append(sY);
		
	}
	
	//_________getters_________
	
	public function getBtnDelete():JButton{
		return btnDelete;
	}
	
	public function getColormixer():JColorMixer{
		return colormixer;
	}
	
	
	public function getSSpacing():JStepper{
		return sSpacing;
	}
	
	
	public function getSLeading():JStepper{
		return sLeading;
	}
	
	public function getCBlod():JCheckBox{
		return cBlod;
	}
	
	public function getCItalic():JCheckBox{
		return cItalic;
	}
	
	
	public function getASize():JAdjuster{
		return aSize;
	}
	
	
	public function getSR():JSlider{
		return sR;
	}
	
	
	
	public function getSX():JStepper{
		return sX;
	}
	
	
	public function getSY():JStepper{
		return sY;
	}
	
	
}
}
