package view.gui{

import org.aswing.*;
import org.aswing.border.*;
import org.aswing.geom.*;
import org.aswing.colorchooser.*;
import org.aswing.ext.*;

/**
 * ImageProperty
 */
public class ImageProperty extends JPanel{
	
	//members define
	private var panel98:JPanel;
	protected var thumbPane:JPanel;
	private var panel100:JPanel;
	protected var btnReplace:JButton;
	protected var btnDelete:JButton;
	protected var colorMixer:JColorMixer;
	private var panel108:JPanel;
	private var panel104:JPanel;
	protected var txtColor:JLabel;
	protected var sliderColor:JSlider;
	private var panel106:JPanel;
	protected var txtAlpha:JLabel;
	protected var sliderAlpha:JSlider;
	private var panel107:JPanel;
	protected var txtRotation:JLabel;
	protected var sliderRotation:JSlider;
	
	/**
	 * ImageProperty Constructor
	 */
	public function ImageProperty(){
		//component creation
		setSize(new IntDimension(285, 400));
		setPreferredSize(new IntDimension(285, 400));
		var layout0:CenterLayout = new CenterLayout();
		setLayout(layout0);
		
		panel98 = new JPanel();
		panel98.setLocation(new IntPoint(0, 15));
		panel98.setSize(new IntDimension(285, 370));
		panel98.setPreferredSize(new IntDimension(285, 370));
		var layout1:EmptyLayout = new EmptyLayout();
		panel98.setLayout(layout1);
		
		thumbPane = new JPanel();
		thumbPane.setLocation(new IntPoint(30, 5));
		thumbPane.setSize(new IntDimension(46, 46));
		thumbPane.setPreferredSize(new IntDimension(46, 46));
		var border2:LineBorder = new LineBorder();
		border2.setColor(new ASColor(0x0, 1));
		border2.setThickness(1);
		thumbPane.setBorder(border2);
		
		panel100 = new JPanel();
		panel100.setLocation(new IntPoint(139, 11));
		panel100.setSize(new IntDimension(131, 36));
		
		btnReplace = new JButton();
		btnReplace.setLocation(new IntPoint(5, 5));
		btnReplace.setSize(new IntDimension(58, 26));
		btnReplace.setText("替换素材");
		
		btnDelete = new JButton();
		btnDelete.setLocation(new IntPoint(47, 5));
		btnDelete.setSize(new IntDimension(58, 26));
		btnDelete.setText("删除素材");
		
		colorMixer = new JColorMixer();
		colorMixer.setLocation(new IntPoint(5, 60));
		colorMixer.setSize(new IntDimension(291, 192));
		
		panel108 = new JPanel();
		panel108.setLocation(new IntPoint(10, 284));
		panel108.setSize(new IntDimension(265, 91));
		panel108.setPreferredSize(new IntDimension(265, 110));
		var layout3:SoftBoxLayout = new SoftBoxLayout();
		layout3.setAxis(AsWingConstants.VERTICAL);
		layout3.setAlign(AsWingConstants.TOP);
		layout3.setGap(10);
		panel108.setLayout(layout3);
		
		panel104 = new JPanel();
		panel104.setLocation(new IntPoint(8, 261));
		panel104.setSize(new IntDimension(265, 19));
		var layout4:EmptyLayout = new EmptyLayout();
		panel104.setLayout(layout4);
		
		txtColor = new JLabel();
		txtColor.setLocation(new IntPoint(0, 0));
		txtColor.setSize(new IntDimension(65, 19));
		txtColor.setPreferredSize(new IntDimension(60, 19));
		txtColor.setText("变色(0)");
		txtColor.setHorizontalAlignment(AsWingConstants.LEFT);
		txtColor.setHorizontalTextPosition(AsWingConstants.LEFT);
		
		sliderColor = new JSlider();
		sliderColor.setLocation(new IntPoint(65, 4));
		sliderColor.setSize(new IntDimension(200, 14));
		sliderColor.setValue(0);
		sliderColor.setExtent(0);
		sliderColor.setMinimum(0);
		sliderColor.setMaximum(100);
		
		panel106 = new JPanel();
		panel106.setLocation(new IntPoint(0, 24));
		panel106.setSize(new IntDimension(265, 19));
		var layout5:EmptyLayout = new EmptyLayout();
		panel106.setLayout(layout5);
		
		txtAlpha = new JLabel();
		txtAlpha.setLocation(new IntPoint(0, 0));
		txtAlpha.setSize(new IntDimension(65, 19));
		txtAlpha.setPreferredSize(new IntDimension(60, 19));
		txtAlpha.setText("透明(100)");
		txtAlpha.setHorizontalAlignment(AsWingConstants.LEFT);
		
		sliderAlpha = new JSlider();
		sliderAlpha.setLocation(new IntPoint(65, 4));
		sliderAlpha.setSize(new IntDimension(200, 14));
		sliderAlpha.setValue(0);
		sliderAlpha.setExtent(0);
		sliderAlpha.setMinimum(0);
		sliderAlpha.setMaximum(100);
		
		panel107 = new JPanel();
		panel107.setLocation(new IntPoint(0, 0));
		panel107.setSize(new IntDimension(265, 20));
		panel107.setPreferredSize(new IntDimension(265, 20));
		var layout6:EmptyLayout = new EmptyLayout();
		panel107.setLayout(layout6);
		
		txtRotation = new JLabel();
		txtRotation.setLocation(new IntPoint(0, 0));
		txtRotation.setSize(new IntDimension(65, 19));
		txtRotation.setPreferredSize(new IntDimension(65, 19));
		txtRotation.setText("旋转(359°)");
		txtRotation.setHorizontalAlignment(AsWingConstants.LEFT);
		
		sliderRotation = new JSlider();
		sliderRotation.setLocation(new IntPoint(65, 4));
		sliderRotation.setSize(new IntDimension(200, 14));
		sliderRotation.setValue(0);
		sliderRotation.setExtent(0);
		sliderRotation.setMinimum(0);
		sliderRotation.setMaximum(100);
		
		//component layoution
		append(panel98);
		
		panel98.append(thumbPane);
		panel98.append(panel100);
		panel98.append(colorMixer);
		panel98.append(panel108);
		
		panel100.append(btnReplace);
		panel100.append(btnDelete);
		
		panel108.append(panel104);
		panel108.append(panel106);
		panel108.append(panel107);
		
		panel104.append(txtColor);
		panel104.append(sliderColor);
		
		panel106.append(txtAlpha);
		panel106.append(sliderAlpha);
		
		panel107.append(txtRotation);
		panel107.append(sliderRotation);
		
	}
	
	//_________getters_________
	
	
	
	
	public function getBtnReplace():JButton{
		return btnReplace;
	}
	
	public function getBtnDelete():JButton{
		return btnDelete;
	}
	
	public function getColorMixer():JColorMixer{
		return colorMixer;
	}
	
	
	
	
	public function getSliderColor():JSlider{
		return sliderColor;
	}
	
	
	
	public function getSliderAlpha():JSlider{
		return sliderAlpha;
	}
	
	
	
	public function getSliderRotation():JSlider{
		return sliderRotation;
	}
	
	
}
}
