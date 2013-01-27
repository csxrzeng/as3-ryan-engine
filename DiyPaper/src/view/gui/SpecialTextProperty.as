package view.gui{

import org.aswing.*;
import org.aswing.border.*;
import org.aswing.geom.*;
import org.aswing.colorchooser.*;
import org.aswing.ext.*;

/**
 * SpecialTextProperty
 */
public class SpecialTextProperty extends JPanel{
	
	//members define
	private var panel84:JPanel;
	private var panel85:JPanel;
	private var togglebutton87:JToggleButton;
	private var togglebutton88:JToggleButton;
	protected var textarea89:JTextArea;
	private var panel91:JPanel;
	private var button92:JButton;
	private var scrollpane93:JScrollPane;
	private var panel95:JPanel;
	
	/**
	 * SpecialTextProperty Constructor
	 */
	public function SpecialTextProperty(){
		//component creation
		setSize(new IntDimension(285, 440));
		var layout0:EmptyLayout = new EmptyLayout();
		setLayout(layout0);
		
		panel84 = new JPanel();
		panel84.setLocation(new IntPoint(5, 5));
		panel84.setSize(new IntDimension(265, 410));
		panel84.setPreferredSize(new IntDimension(265, 410));
		var layout1:SoftBoxLayout = new SoftBoxLayout();
		layout1.setAxis(AsWingConstants.VERTICAL);
		layout1.setAlign(AsWingConstants.TOP);
		layout1.setGap(5);
		panel84.setLayout(layout1);
		
		panel85 = new JPanel();
		panel85.setSize(new IntDimension(265, 26));
		var layout2:SoftBoxLayout = new SoftBoxLayout();
		layout2.setAxis(AsWingConstants.HORIZONTAL);
		layout2.setAlign(AsWingConstants.CENTER);
		panel85.setLayout(layout2);
		
		togglebutton87 = new JToggleButton();
		togglebutton87.setLocation(new IntPoint(5, 5));
		togglebutton87.setSize(new IntDimension(58, 26));
		togglebutton87.setText("特效文字");
		
		togglebutton88 = new JToggleButton();
		togglebutton88.setLocation(new IntPoint(47, 5));
		togglebutton88.setSize(new IntDimension(58, 26));
		togglebutton88.setText("静态文字");
		
		textarea89 = new JTextArea();
		textarea89.setLocation(new IntPoint(0, 31));
		textarea89.setSize(new IntDimension(265, 60));
		textarea89.setPreferredSize(new IntDimension(265, 60));
		textarea89.setEditable(true);
		textarea89.setMaxChars(200);
		textarea89.setWordWrap(true);
		
		panel91 = new JPanel();
		panel91.setLocation(new IntPoint(0, 96));
		panel91.setSize(new IntDimension(265, 0));
		var layout3:BorderLayout = new BorderLayout();
		panel91.setLayout(layout3);
		
		button92 = new JButton();
		button92.setLocation(new IntPoint(104, 0));
		button92.setSize(new IntDimension(265, 26));
		button92.setConstraints("East");
		button92.setText("添加文字");
		
		scrollpane93 = new JScrollPane();
		scrollpane93.setLocation(new IntPoint(0, 127));
		scrollpane93.setSize(new IntDimension(265, 283));
		
		panel95 = new JPanel();
		panel95.setLocation(new IntPoint(0, 0));
		panel95.setSize(new IntDimension(265, 283));
		panel95.setPreferredSize(new IntDimension(265, 283));
		
		//component layoution
		append(panel84);
		
		panel84.append(panel85);
		panel84.append(textarea89);
		panel84.append(panel91);
		panel84.append(scrollpane93);
		
		panel85.append(togglebutton87);
		panel85.append(togglebutton88);
		
		panel91.append(button92);
		
		scrollpane93.append(panel95);
		
	}
	
	//_________getters_________
	
	
	
	public function getTogglebutton87():JToggleButton{
		return togglebutton87;
	}
	
	public function getTogglebutton88():JToggleButton{
		return togglebutton88;
	}
	
	public function getTextarea89():JTextArea{
		return textarea89;
	}
	
	
	public function getButton92():JButton{
		return button92;
	}
	
	
	
	
}
}
