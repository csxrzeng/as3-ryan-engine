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
	private var loadpane97:JLoadPane;
	private var panel100:JPanel;
	private var button101:JButton;
	private var button102:JButton;
	private var colormixer103:JColorMixer;
	private var panel108:JPanel;
	private var panel104:JPanel;
	private var label109:JLabel;
	private var slider110:JSlider;
	private var panel106:JPanel;
	private var label111:JLabel;
	private var slider112:JSlider;
	private var panel107:JPanel;
	private var label113:JLabel;
	private var slider114:JSlider;
	
	/**
	 * ImageProperty Constructor
	 */
	public function ImageProperty(){
		//component creation
		setSize(new IntDimension(285, 375));
		var layout0:CenterLayout = new CenterLayout();
		setLayout(layout0);
		
		panel98 = new JPanel();
		panel98.setLocation(new IntPoint(0, 12));
		panel98.setSize(new IntDimension(285, 350));
		panel98.setPreferredSize(new IntDimension(285, 350));
		var layout1:EmptyLayout = new EmptyLayout();
		panel98.setLayout(layout1);
		
		loadpane97 = new JLoadPane();
		loadpane97.setLocation(new IntPoint(30, 5));
		loadpane97.setSize(new IntDimension(45, 45));
		loadpane97.setPreferredSize(new IntDimension(46, 46));
		var border2:LineBorder = new LineBorder();
		var border3:LineBorder = new LineBorder();
		var border4:LineBorder = new LineBorder();
		border4.setColor(new ASColor(0x0, 1));
		border4.setThickness(1);
		border3.setInterior(border4);
		border3.setColor(new ASColor(0xffffff, 1));
		border3.setThickness(2);
		border2.setInterior(border3);
		border2.setColor(new ASColor(0x0, 1));
		border2.setThickness(1);
		loadpane97.setBorder(border2);
		
		panel100 = new JPanel();
		panel100.setLocation(new IntPoint(139, 11));
		panel100.setSize(new IntDimension(10, 10));
		
		button101 = new JButton();
		button101.setLocation(new IntPoint(5, 5));
		button101.setSize(new IntDimension(58, 26));
		button101.setText("替换素材");
		
		button102 = new JButton();
		button102.setLocation(new IntPoint(47, 5));
		button102.setSize(new IntDimension(58, 26));
		button102.setText("删除素材");
		
		colormixer103 = new JColorMixer();
		colormixer103.setLocation(new IntPoint(10, 60));
		colormixer103.setSize(new IntDimension(291, 192));
		
		panel108 = new JPanel();
		panel108.setLocation(new IntPoint(10, 265));
		panel108.setSize(new IntDimension(265, 90));
		var layout5:SoftBoxLayout = new SoftBoxLayout();
		layout5.setAxis(AsWingConstants.VERTICAL);
		layout5.setAlign(AsWingConstants.TOP);
		layout5.setGap(10);
		panel108.setLayout(layout5);
		
		panel104 = new JPanel();
		panel104.setLocation(new IntPoint(8, 261));
		panel104.setSize(new IntDimension(265, 19));
		var layout6:EmptyLayout = new EmptyLayout();
		panel104.setLayout(layout6);
		
		label109 = new JLabel();
		label109.setLocation(new IntPoint(5, 5));
		label109.setSize(new IntDimension(31, 19));
		label109.setText("变色(0)");
		
		slider110 = new JSlider();
		slider110.setLocation(new IntPoint(65, 4));
		slider110.setSize(new IntDimension(200, 14));
		slider110.setValue(0);
		slider110.setExtent(0);
		slider110.setMinimum(0);
		slider110.setMaximum(100);
		
		panel106 = new JPanel();
		panel106.setLocation(new IntPoint(14, 281));
		panel106.setSize(new IntDimension(265, 19));
		var layout7:EmptyLayout = new EmptyLayout();
		panel106.setLayout(layout7);
		
		label111 = new JLabel();
		label111.setLocation(new IntPoint(5, 5));
		label111.setSize(new IntDimension(31, 19));
		label111.setText("透明(100)");
		
		slider112 = new JSlider();
		slider112.setLocation(new IntPoint(65, 4));
		slider112.setSize(new IntDimension(200, 14));
		slider112.setValue(0);
		slider112.setExtent(0);
		slider112.setMinimum(0);
		slider112.setMaximum(100);
		
		panel107 = new JPanel();
		panel107.setLocation(new IntPoint(32, 324));
		panel107.setSize(new IntDimension(265, 19));
		var layout8:EmptyLayout = new EmptyLayout();
		panel107.setLayout(layout8);
		
		label113 = new JLabel();
		label113.setLocation(new IntPoint(5, 5));
		label113.setSize(new IntDimension(48, 19));
		label113.setText("旋转(0°)");
		
		slider114 = new JSlider();
		slider114.setLocation(new IntPoint(65, 4));
		slider114.setSize(new IntDimension(200, 14));
		slider114.setValue(0);
		slider114.setExtent(0);
		slider114.setMinimum(0);
		slider114.setMaximum(100);
		
		//component layoution
		append(panel98);
		
		panel98.append(loadpane97);
		panel98.append(panel100);
		panel98.append(colormixer103);
		panel98.append(panel108);
		
		panel100.append(button101);
		panel100.append(button102);
		
		panel108.append(panel104);
		panel108.append(panel106);
		panel108.append(panel107);
		
		panel104.append(label109);
		panel104.append(slider110);
		
		panel106.append(label111);
		panel106.append(slider112);
		
		panel107.append(label113);
		panel107.append(slider114);
		
	}
	
	//_________getters_________
	
	
	public function getLoadpane97():JLoadPane{
		return loadpane97;
	}
	
	
	public function getButton101():JButton{
		return button101;
	}
	
	public function getButton102():JButton{
		return button102;
	}
	
	public function getColormixer103():JColorMixer{
		return colormixer103;
	}
	
	
	
	
	public function getSlider110():JSlider{
		return slider110;
	}
	
	
	
	public function getSlider112():JSlider{
		return slider112;
	}
	
	
	
	public function getSlider114():JSlider{
		return slider114;
	}
	
	
}
}
