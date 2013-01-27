package view.gui{

import org.aswing.*;
import org.aswing.border.*;
import org.aswing.geom.*;
import org.aswing.colorchooser.*;
import org.aswing.ext.*;

/**
 * ImageLibrary
 */
public class ImageLibrary extends JPanel{
	
	//members define
	private var panel117:JPanel;
	private var togglebutton120:JToggleButton;
	private var button121:JButton;
	private var scrollpane122:JScrollPane;
	private var panel123:JPanel;
	
	/**
	 * ImageLibrary Constructor
	 */
	public function ImageLibrary(){
		//component creation
		setSize(new IntDimension(285, 440));
		var border0:EmptyBorder = new EmptyBorder();
		border0.setTop(15);
		border0.setLeft(10);
		border0.setBottom(15);
		border0.setRight(10);
		setBorder(border0);
		var layout1:SoftBoxLayout = new SoftBoxLayout();
		layout1.setAxis(AsWingConstants.VERTICAL);
		layout1.setAlign(AsWingConstants.TOP);
		layout1.setGap(5);
		setLayout(layout1);
		
		panel117 = new JPanel();
		panel117.setLocation(new IntPoint(5, 5));
		panel117.setSize(new IntDimension(265, 26));
		var layout2:SoftBoxLayout = new SoftBoxLayout();
		layout2.setAxis(AsWingConstants.HORIZONTAL);
		layout2.setAlign(AsWingConstants.CENTER);
		panel117.setLayout(layout2);
		
		togglebutton120 = new JToggleButton();
		togglebutton120.setLocation(new IntPoint(104, 0));
		togglebutton120.setSize(new IntDimension(58, 26));
		togglebutton120.setText("在线图标");
		
		button121 = new JButton();
		button121.setLocation(new IntPoint(133, 0));
		button121.setSize(new IntDimension(58, 26));
		button121.setText("我的素材");
		
		scrollpane122 = new JScrollPane();
		scrollpane122.setLocation(new IntPoint(10, 45));
		scrollpane122.setSize(new IntDimension(265, 380));
		
		panel123 = new JPanel();
		panel123.setLocation(new IntPoint(0, 0));
		panel123.setSize(new IntDimension(265, 380));
		panel123.setPreferredSize(new IntDimension(265, 380));
		var layout3:FlowWrapLayout = new FlowWrapLayout();
		layout3.setPreferWidth(265);
		layout3.setAlignment(AsWingConstants.LEFT);
		layout3.setHgap(1);
		layout3.setVgap(1);
		panel123.setLayout(layout3);
		
		//component layoution
		append(panel117);
		append(scrollpane122);
		
		panel117.append(togglebutton120);
		panel117.append(button121);
		
		scrollpane122.append(panel123);
		
	}
	
	//_________getters_________
	
	
	public function getTogglebutton120():JToggleButton{
		return togglebutton120;
	}
	
	public function getButton121():JButton{
		return button121;
	}
	
	
	
	
}
}
