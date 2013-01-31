package view.gui{

import org.aswing.*;
import org.aswing.border.*;
import org.aswing.geom.*;
import org.aswing.colorchooser.*;
import org.aswing.ext.*;

/**
 * StaticTextProperty
 */
public class StaticTextProperty extends JPanel{
	
	//members define
	protected var panel28:JPanel;
	private var panel25:JPanel;
	protected var btnSpecial:JToggleButton;
	protected var btnStatic:JToggleButton;
	protected var txtInput:JTextArea;
	private var panel29:JPanel;
	protected var combobox:JComboBox;
	protected var btnAdd:JButton;
	private var panel32:JPanel;
	private var panel46:JPanel;
	protected var btnLeft:JToggleButton;
	protected var btnCenter:JToggleButton;
	protected var btnRight:JToggleButton;
	protected var btnBold:JToggleButton;
	protected var btnItalic:JToggleButton;
	protected var btnUnderline:JToggleButton;
	private var panel47:JPanel;
	protected var btnLtr:JToggleButton;
	protected var btnTtb:JToggleButton;
	private var spacer68:JSpacer;
	private var panel82:JPanel;
	private var panel48:JPanel;
	protected var txtSize:JLabel;
	protected var sliderSize:JSlider;
	private var panel52:JPanel;
	private var label53:JLabel;
	protected var btnBlur:JButton;
	private var separator56:JSeparator;
	private var panel57:JPanel;
	protected var txtBlur:JLabel;
	protected var sliderBlur:JSlider;
	private var panel60:JPanel;
	protected var txtBlurAlpha:JLabel;
	protected var sliderBlurAlpha:JSlider;
	private var panel63:JPanel;
	private var label64:JLabel;
	protected var btnDrop:JButton;
	private var separator66:JSeparator;
	private var panel70:JPanel;
	protected var txtDrop:JLabel;
	protected var sliderDrop:JSlider;
	private var panel73:JPanel;
	protected var txtDropAlpha:JLabel;
	protected var sliderDropAlpha:JSlider;
	private var panel76:JPanel;
	protected var txtDropAngle:JLabel;
	protected var sliderDropAngle:JSlider;
	private var panel79:JPanel;
	protected var txtDropDistance:JLabel;
	protected var sliderDropDistance:JSlider;
	
	/**
	 * StaticTextProperty Constructor
	 */
	public function StaticTextProperty(){
		//component creation
		setSize(new IntDimension(285, 440));
		setPreferredSize(new IntDimension(285, 440));
		var layout0:CenterLayout = new CenterLayout();
		setLayout(layout0);
		
		panel28 = new JPanel();
		panel28.setLocation(new IntPoint(10, 15));
		panel28.setSize(new IntDimension(265, 410));
		panel28.setPreferredSize(new IntDimension(265, 410));
		var layout1:SoftBoxLayout = new SoftBoxLayout();
		layout1.setAxis(AsWingConstants.VERTICAL);
		layout1.setAlign(AsWingConstants.TOP);
		layout1.setGap(5);
		panel28.setLayout(layout1);
		
		panel25 = new JPanel();
		panel25.setLocation(new IntPoint(0, 183));
		panel25.setSize(new IntDimension(275, 60));
		var layout2:SoftBoxLayout = new SoftBoxLayout();
		layout2.setAxis(AsWingConstants.HORIZONTAL);
		layout2.setAlign(AsWingConstants.CENTER);
		panel25.setLayout(layout2);
		
		btnSpecial = new JToggleButton();
		btnSpecial.setLocation(new IntPoint(0, 202));
		btnSpecial.setSize(new IntDimension(58, 26));
		btnSpecial.setText("特效文字");
		
		btnStatic = new JToggleButton();
		btnStatic.setLocation(new IntPoint(143, 0));
		btnStatic.setSize(new IntDimension(58, 26));
		btnStatic.setText("静态文字");
		
		txtInput = new JTextArea();
		txtInput.setLocation(new IntPoint(0, 206));
		txtInput.setSize(new IntDimension(265, 60));
		txtInput.setPreferredSize(new IntDimension(265, 60));
		txtInput.setEditable(true);
		txtInput.setMaxChars(200);
		txtInput.setWordWrap(true);
		
		panel29 = new JPanel();
		panel29.setLocation(new IntPoint(0, 96));
		panel29.setSize(new IntDimension(265, 26));
		var layout3:BorderLayout = new BorderLayout();
		layout3.setHgap(0);
		layout3.setVgap(0);
		panel29.setLayout(layout3);
		
		combobox = new JComboBox();
		combobox.setLocation(new IntPoint(0, 0));
		combobox.setSize(new IntDimension(60, 22));
		combobox.setPreferredSize(new IntDimension(60, 22));
		combobox.setConstraints("West");
		combobox.setMaximumRowCount(7);
		
		btnAdd = new JButton();
		btnAdd.setLocation(new IntPoint(207, 0));
		btnAdd.setSize(new IntDimension(58, 26));
		btnAdd.setConstraints("East");
		btnAdd.setText("添加文字");
		
		panel32 = new JPanel();
		panel32.setLocation(new IntPoint(0, 127));
		panel32.setSize(new IntDimension(265, 26));
		var layout4:BorderLayout = new BorderLayout();
		layout4.setHgap(0);
		layout4.setVgap(0);
		panel32.setLayout(layout4);
		
		panel46 = new JPanel();
		panel46.setLocation(new IntPoint(0, 0));
		panel46.setSize(new IntDimension(231, 36));
		var layout5:FlowLayout = new FlowLayout();
		layout5.setHgap(0);
		layout5.setVgap(0);
		panel46.setLayout(layout5);
		
		btnLeft = new JToggleButton();
		btnLeft.setLocation(new IntPoint(5, 5));
		btnLeft.setSize(new IntDimension(22, 26));
		btnLeft.setConstraints("West");
		btnLeft.setText("左");
		
		btnCenter = new JToggleButton();
		btnCenter.setLocation(new IntPoint(0, 0));
		btnCenter.setSize(new IntDimension(22, 26));
		btnCenter.setConstraints("West");
		btnCenter.setText("中");
		
		btnRight = new JToggleButton();
		btnRight.setLocation(new IntPoint(0, 0));
		btnRight.setSize(new IntDimension(22, 26));
		btnRight.setConstraints("West");
		btnRight.setText("右");
		
		btnBold = new JToggleButton();
		btnBold.setLocation(new IntPoint(0, 0));
		btnBold.setSize(new IntDimension(22, 26));
		btnBold.setConstraints("West");
		btnBold.setText("粗");
		
		btnItalic = new JToggleButton();
		btnItalic.setLocation(new IntPoint(0, 0));
		btnItalic.setSize(new IntDimension(22, 26));
		btnItalic.setConstraints("West");
		btnItalic.setText("斜");
		
		btnUnderline = new JToggleButton();
		btnUnderline.setLocation(new IntPoint(0, 0));
		btnUnderline.setSize(new IntDimension(22, 26));
		btnUnderline.setConstraints("West");
		btnUnderline.setText("线");
		
		panel47 = new JPanel();
		panel47.setLocation(new IntPoint(197, 0));
		panel47.setSize(new IntDimension(68, 26));
		panel47.setConstraints("East");
		var layout6:FlowLayout = new FlowLayout();
		layout6.setHgap(0);
		layout6.setVgap(0);
		panel47.setLayout(layout6);
		
		btnLtr = new JToggleButton();
		btnLtr.setLocation(new IntPoint(167, 5));
		btnLtr.setSize(new IntDimension(34, 26));
		btnLtr.setConstraints("East");
		btnLtr.setText("横排");
		
		btnTtb = new JToggleButton();
		btnTtb.setLocation(new IntPoint(231, 0));
		btnTtb.setSize(new IntDimension(34, 26));
		btnTtb.setConstraints("East");
		btnTtb.setText("竖排");
		
		spacer68 = new JSpacer();
		spacer68.setLocation(new IntPoint(0, 186));
		spacer68.setSize(new IntDimension(265, 0));
		
		panel82 = new JPanel();
		panel82.setLocation(new IntPoint(0, 304));
		panel82.setSize(new IntDimension(265, 246));
		panel82.setPreferredSize(new IntDimension(265, 246));
		var layout7:SoftBoxLayout = new SoftBoxLayout();
		layout7.setAxis(AsWingConstants.VERTICAL);
		layout7.setAlign(AsWingConstants.TOP);
		layout7.setGap(5);
		panel82.setLayout(layout7);
		
		panel48 = new JPanel();
		panel48.setLocation(new IntPoint(0, 0));
		panel48.setSize(new IntDimension(255, 20));
		var layout8:EmptyLayout = new EmptyLayout();
		panel48.setLayout(layout8);
		
		txtSize = new JLabel();
		txtSize.setLocation(new IntPoint(0, 0));
		txtSize.setSize(new IntDimension(50, 19));
		txtSize.setConstraints("West");
		txtSize.setText("字号(12)");
		
		sliderSize = new JSlider();
		sliderSize.setLocation(new IntPoint(60, 4));
		sliderSize.setSize(new IntDimension(200, 14));
		sliderSize.setConstraints("East");
		sliderSize.setValue(0);
		sliderSize.setExtent(0);
		sliderSize.setMinimum(0);
		sliderSize.setMaximum(100);
		
		panel52 = new JPanel();
		panel52.setLocation(new IntPoint(0, 27));
		panel52.setSize(new IntDimension(265, 27));
		var border9:EmptyBorder = new EmptyBorder();
		border9.setRight(10);
		panel52.setBorder(border9);
		var layout10:BorderLayout = new BorderLayout();
		layout10.setHgap(0);
		layout10.setVgap(0);
		panel52.setLayout(layout10);
		
		label53 = new JLabel();
		label53.setLocation(new IntPoint(5, 5));
		label53.setSize(new IntDimension(40, 26));
		label53.setConstraints("West");
		label53.setText("描边：");
		
		btnBlur = new JButton();
		btnBlur.setLocation(new IntPoint(239, 0));
		btnBlur.setSize(new IntDimension(26, 26));
		btnBlur.setConstraints("East");
		btnBlur.setText("　");
		
		separator56 = new JSeparator();
		separator56.setLocation(new IntPoint(0, 26));
		separator56.setSize(new IntDimension(265, 1));
		separator56.setConstraints("South");
		
		panel57 = new JPanel();
		panel57.setLocation(new IntPoint(0, 54));
		panel57.setSize(new IntDimension(255, 20));
		var layout11:EmptyLayout = new EmptyLayout();
		panel57.setLayout(layout11);
		
		txtBlur = new JLabel();
		txtBlur.setLocation(new IntPoint(0, 0));
		txtBlur.setSize(new IntDimension(43, 19));
		txtBlur.setConstraints("West");
		txtBlur.setText("粗细(1)");
		
		sliderBlur = new JSlider();
		sliderBlur.setLocation(new IntPoint(60, 4));
		sliderBlur.setSize(new IntDimension(200, 14));
		sliderBlur.setConstraints("East");
		sliderBlur.setValue(1);
		sliderBlur.setExtent(0);
		sliderBlur.setMinimum(1);
		sliderBlur.setMaximum(5);
		
		panel60 = new JPanel();
		panel60.setLocation(new IntPoint(0, 81));
		panel60.setSize(new IntDimension(255, 20));
		var layout12:EmptyLayout = new EmptyLayout();
		panel60.setLayout(layout12);
		
		txtBlurAlpha = new JLabel();
		txtBlurAlpha.setLocation(new IntPoint(0, 0));
		txtBlurAlpha.setSize(new IntDimension(43, 19));
		txtBlurAlpha.setConstraints("West");
		txtBlurAlpha.setText("透明(0)");
		
		sliderBlurAlpha = new JSlider();
		sliderBlurAlpha.setLocation(new IntPoint(60, 4));
		sliderBlurAlpha.setSize(new IntDimension(200, 14));
		sliderBlurAlpha.setConstraints("East");
		sliderBlurAlpha.setValue(0);
		sliderBlurAlpha.setExtent(0);
		sliderBlurAlpha.setMinimum(0);
		sliderBlurAlpha.setMaximum(100);
		
		panel63 = new JPanel();
		panel63.setLocation(new IntPoint(0, 108));
		panel63.setSize(new IntDimension(265, 27));
		var border13:EmptyBorder = new EmptyBorder();
		border13.setRight(10);
		panel63.setBorder(border13);
		var layout14:BorderLayout = new BorderLayout();
		panel63.setLayout(layout14);
		
		label64 = new JLabel();
		label64.setLocation(new IntPoint(5, 5));
		label64.setSize(new IntDimension(34, 19));
		label64.setConstraints("West");
		label64.setText("投影：");
		
		btnDrop = new JButton();
		btnDrop.setLocation(new IntPoint(237, 0));
		btnDrop.setSize(new IntDimension(18, 26));
		btnDrop.setConstraints("East");
		btnDrop.setText("　");
		
		separator66 = new JSeparator();
		separator66.setLocation(new IntPoint(0, 26));
		separator66.setSize(new IntDimension(265, 1));
		separator66.setConstraints("South");
		
		panel70 = new JPanel();
		panel70.setLocation(new IntPoint(0, 135));
		panel70.setSize(new IntDimension(255, 20));
		var layout15:EmptyLayout = new EmptyLayout();
		panel70.setLayout(layout15);
		
		txtDrop = new JLabel();
		txtDrop.setLocation(new IntPoint(0, 0));
		txtDrop.setSize(new IntDimension(43, 19));
		txtDrop.setConstraints("West");
		txtDrop.setText("效果(1)");
		
		sliderDrop = new JSlider();
		sliderDrop.setLocation(new IntPoint(60, 4));
		sliderDrop.setSize(new IntDimension(200, 14));
		sliderDrop.setConstraints("East");
		sliderDrop.setValue(1);
		sliderDrop.setExtent(0);
		sliderDrop.setMinimum(1);
		sliderDrop.setMaximum(5);
		
		panel73 = new JPanel();
		panel73.setLocation(new IntPoint(0, 332));
		panel73.setSize(new IntDimension(255, 20));
		var layout16:EmptyLayout = new EmptyLayout();
		panel73.setLayout(layout16);
		
		txtDropAlpha = new JLabel();
		txtDropAlpha.setLocation(new IntPoint(0, 0));
		txtDropAlpha.setSize(new IntDimension(43, 19));
		txtDropAlpha.setConstraints("West");
		txtDropAlpha.setText("透明(0)");
		
		sliderDropAlpha = new JSlider();
		sliderDropAlpha.setLocation(new IntPoint(60, 4));
		sliderDropAlpha.setSize(new IntDimension(200, 14));
		sliderDropAlpha.setConstraints("East");
		sliderDropAlpha.setValue(0);
		sliderDropAlpha.setExtent(0);
		sliderDropAlpha.setMinimum(0);
		sliderDropAlpha.setMaximum(100);
		
		panel76 = new JPanel();
		panel76.setLocation(new IntPoint(0, 189));
		panel76.setSize(new IntDimension(255, 20));
		var layout17:EmptyLayout = new EmptyLayout();
		panel76.setLayout(layout17);
		
		txtDropAngle = new JLabel();
		txtDropAngle.setLocation(new IntPoint(0, 0));
		txtDropAngle.setSize(new IntDimension(50, 19));
		txtDropAngle.setConstraints("West");
		txtDropAngle.setText("角度(45)");
		
		sliderDropAngle = new JSlider();
		sliderDropAngle.setLocation(new IntPoint(60, 4));
		sliderDropAngle.setSize(new IntDimension(200, 14));
		sliderDropAngle.setConstraints("East");
		sliderDropAngle.setValue(45);
		sliderDropAngle.setExtent(0);
		sliderDropAngle.setMinimum(0);
		sliderDropAngle.setMaximum(360);
		
		panel79 = new JPanel();
		panel79.setLocation(new IntPoint(0, 216));
		panel79.setSize(new IntDimension(255, 20));
		var layout18:EmptyLayout = new EmptyLayout();
		panel79.setLayout(layout18);
		
		txtDropDistance = new JLabel();
		txtDropDistance.setLocation(new IntPoint(0, 0));
		txtDropDistance.setSize(new IntDimension(43, 19));
		txtDropDistance.setConstraints("West");
		txtDropDistance.setText("距离(1)");
		
		sliderDropDistance = new JSlider();
		sliderDropDistance.setLocation(new IntPoint(60, 4));
		sliderDropDistance.setSize(new IntDimension(200, 14));
		sliderDropDistance.setConstraints("East");
		sliderDropDistance.setValue(1);
		sliderDropDistance.setExtent(0);
		sliderDropDistance.setMinimum(1);
		sliderDropDistance.setMaximum(5);
		
		//component layoution
		append(panel28);
		
		panel28.append(panel25);
		panel28.append(txtInput);
		panel28.append(panel29);
		panel28.append(panel32);
		panel28.append(spacer68);
		panel28.append(panel82);
		
		panel25.append(btnSpecial);
		panel25.append(btnStatic);
		
		panel29.append(combobox);
		panel29.append(btnAdd);
		
		panel32.append(panel46);
		panel32.append(panel47);
		
		panel46.append(btnLeft);
		panel46.append(btnCenter);
		panel46.append(btnRight);
		panel46.append(btnBold);
		panel46.append(btnItalic);
		panel46.append(btnUnderline);
		
		panel47.append(btnLtr);
		panel47.append(btnTtb);
		
		panel82.append(panel48);
		panel82.append(panel52);
		panel82.append(panel57);
		panel82.append(panel60);
		panel82.append(panel63);
		panel82.append(panel70);
		panel82.append(panel73);
		panel82.append(panel76);
		panel82.append(panel79);
		
		panel48.append(txtSize);
		panel48.append(sliderSize);
		
		panel52.append(label53);
		panel52.append(btnBlur);
		panel52.append(separator56);
		
		panel57.append(txtBlur);
		panel57.append(sliderBlur);
		
		panel60.append(txtBlurAlpha);
		panel60.append(sliderBlurAlpha);
		
		panel63.append(label64);
		panel63.append(btnDrop);
		panel63.append(separator66);
		
		panel70.append(txtDrop);
		panel70.append(sliderDrop);
		
		panel73.append(txtDropAlpha);
		panel73.append(sliderDropAlpha);
		
		panel76.append(txtDropAngle);
		panel76.append(sliderDropAngle);
		
		panel79.append(txtDropDistance);
		panel79.append(sliderDropDistance);
		
	}
	
	//_________getters_________
	
	
	
	public function getBtnSpecial():JToggleButton{
		return btnSpecial;
	}
	
	public function getBtnStatic():JToggleButton{
		return btnStatic;
	}
	
	public function getTxtInput():JTextArea{
		return txtInput;
	}
	
	
	public function getCombobox():JComboBox{
		return combobox;
	}
	
	public function getBtnAdd():JButton{
		return btnAdd;
	}
	
	
	
	public function getBtnLeft():JToggleButton{
		return btnLeft;
	}
	
	public function getBtnCenter():JToggleButton{
		return btnCenter;
	}
	
	public function getBtnRight():JToggleButton{
		return btnRight;
	}
	
	public function getBtnBold():JToggleButton{
		return btnBold;
	}
	
	public function getBtnItalic():JToggleButton{
		return btnItalic;
	}
	
	public function getBtnUnderline():JToggleButton{
		return btnUnderline;
	}
	
	
	public function getBtnLtr():JToggleButton{
		return btnLtr;
	}
	
	public function getBtnTtb():JToggleButton{
		return btnTtb;
	}
	
	
	
	
	
	public function getSliderSize():JSlider{
		return sliderSize;
	}
	
	
	
	public function getBtnBlur():JButton{
		return btnBlur;
	}
	
	
	
	
	public function getSliderBlur():JSlider{
		return sliderBlur;
	}
	
	
	
	public function getSliderBlurAlpha():JSlider{
		return sliderBlurAlpha;
	}
	
	
	
	public function getBtnDrop():JButton{
		return btnDrop;
	}
	
	
	
	
	public function getSliderDrop():JSlider{
		return sliderDrop;
	}
	
	
	
	public function getSliderDropAlpha():JSlider{
		return sliderDropAlpha;
	}
	
	
	
	public function getSliderDropAngle():JSlider{
		return sliderDropAngle;
	}
	
	
	
	public function getSliderDropDistance():JSlider{
		return sliderDropDistance;
	}
	
	
}
}
