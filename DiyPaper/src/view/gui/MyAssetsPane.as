package view.gui{

import org.aswing.*;
import org.aswing.border.*;
import org.aswing.geom.*;
import org.aswing.colorchooser.*;
import org.aswing.ext.*;

/**
 * MyAssets
 */
public class MyAssetsPane extends JPanel{
	
	//members define
	private var panel158:JPanel;
	private var button157:JButton;
	private var spacer159:JSpacer;
	private var textfield160:JTextField;
	private var panel161:JPanel;
	private var button162:JButton;
	private var spacer163:JSpacer;
	private var label164:JLabel;
	private var textfield165:JTextField;
	private var panel166:JPanel;
	private var button167:JButton;
	
	/**
	 * MyAssets Constructor
	 */
	public function MyAssetsPane(){
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
		setLayout(layout1);
		
		panel158 = new JPanel();
		panel158.setLocation(new IntPoint(5, 5));
		panel158.setSize(new IntDimension(265, 26));
		var layout2:CenterLayout = new CenterLayout();
		panel158.setLayout(layout2);
		
		button157 = new JButton();
		button157.setLocation(new IntPoint(91, 0));
		button157.setSize(new IntDimension(82, 26));
		button157.setText("　　返　　回　　");
		
		spacer159 = new JSpacer();
		spacer159.setLocation(new IntPoint(10, 41));
		spacer159.setSize(new IntDimension(265, 10));
		spacer159.setPreferredSize(new IntDimension(265, 10));
		
		textfield160 = new JTextField();
		textfield160.setLocation(new IntPoint(10, 51));
		textfield160.setSize(new IntDimension(265, 22));
		textfield160.setText("从本地上传图片(jpg,png),不可大于500k!");
		textfield160.setEditable(false);
		
		panel161 = new JPanel();
		panel161.setLocation(new IntPoint(10, 73));
		panel161.setSize(new IntDimension(265, 10));
		
		button162 = new JButton();
		button162.setLocation(new IntPoint(5, 5));
		button162.setSize(new IntDimension(40, 26));
		button162.setText(" 浏览 ");
		
		spacer163 = new JSpacer();
		spacer163.setLocation(new IntPoint(10, 109));
		spacer163.setSize(new IntDimension(265, 50));
		spacer163.setPreferredSize(new IntDimension(265, 50));
		
		label164 = new JLabel();
		label164.setLocation(new IntPoint(10, 159));
		label164.setSize(new IntDimension(265, 19));
		label164.setText("为了确保您能顺利加载,请您选择小于500k的图片");
		label164.setHorizontalAlignment(AsWingConstants.LEFT);
		
		textfield165 = new JTextField();
		textfield165.setLocation(new IntPoint(10, 178));
		textfield165.setSize(new IntDimension(265, 22));
		textfield165.setText("http://");
		textfield165.setEditable(true);
		
		panel166 = new JPanel();
		panel166.setLocation(new IntPoint(10, 200));
		panel166.setSize(new IntDimension(265, 10));
		
		button167 = new JButton();
		button167.setLocation(new IntPoint(5, 5));
		button167.setSize(new IntDimension(82, 26));
		button167.setText("加载网络图片");
		
		//component layoution
		append(panel158);
		append(spacer159);
		append(textfield160);
		append(panel161);
		append(spacer163);
		append(label164);
		append(textfield165);
		append(panel166);
		
		panel158.append(button157);
		
		panel161.append(button162);
		
		panel166.append(button167);
		
	}
	
	//_________getters_________
	
	
	public function getButton157():JButton{
		return button157;
	}
	
	
	public function getTextfield160():JTextField{
		return textfield160;
	}
	
	
	public function getButton162():JButton{
		return button162;
	}
	
	
	
	public function getTextfield165():JTextField{
		return textfield165;
	}
	
	
	public function getButton167():JButton{
		return button167;
	}
	
	
}
}
