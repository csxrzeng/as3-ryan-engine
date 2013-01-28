package view.gui{

import org.aswing.*;
import org.aswing.border.*;
import org.aswing.geom.*;
import org.aswing.colorchooser.*;
import org.aswing.ext.*;

/**
 * MyAssetsPane
 */
public class MyAssetsPane extends JPanel{
	
	//members define
	private var panel158:JPanel;
	protected var btnBack:JButton;
	private var spacer159:JSpacer;
	protected var txtUpload:JTextField;
	private var panel161:JPanel;
	protected var btnBrowse:JButton;
	private var spacer163:JSpacer;
	private var label164:JLabel;
	protected var txtDownload:JTextField;
	private var panel166:JPanel;
	protected var btnDownload:JButton;
	
	/**
	 * MyAssetsPane Constructor
	 */
	public function MyAssetsPane(){
		//component creation
		setSize(new IntDimension(285, 440));
		setPreferredSize(new IntDimension(285, 440));
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
		
		btnBack = new JButton();
		btnBack.setLocation(new IntPoint(91, 0));
		btnBack.setSize(new IntDimension(82, 26));
		btnBack.setText("　　返　　回　　");
		
		spacer159 = new JSpacer();
		spacer159.setLocation(new IntPoint(10, 41));
		spacer159.setSize(new IntDimension(265, 10));
		spacer159.setPreferredSize(new IntDimension(265, 10));
		
		txtUpload = new JTextField();
		txtUpload.setLocation(new IntPoint(10, 51));
		txtUpload.setSize(new IntDimension(265, 22));
		txtUpload.setText("从本地上传图片(jpg,png),不可大于500k!");
		txtUpload.setEditable(false);
		
		panel161 = new JPanel();
		panel161.setLocation(new IntPoint(10, 73));
		panel161.setSize(new IntDimension(265, 10));
		
		btnBrowse = new JButton();
		btnBrowse.setLocation(new IntPoint(5, 5));
		btnBrowse.setSize(new IntDimension(40, 26));
		btnBrowse.setText(" 浏览 ");
		
		spacer163 = new JSpacer();
		spacer163.setLocation(new IntPoint(10, 109));
		spacer163.setSize(new IntDimension(265, 50));
		spacer163.setPreferredSize(new IntDimension(265, 50));
		
		label164 = new JLabel();
		label164.setLocation(new IntPoint(10, 159));
		label164.setSize(new IntDimension(265, 19));
		label164.setText("为了确保您能顺利加载,请您选择小于500k的图片");
		label164.setHorizontalAlignment(AsWingConstants.LEFT);
		
		txtDownload = new JTextField();
		txtDownload.setLocation(new IntPoint(10, 178));
		txtDownload.setSize(new IntDimension(265, 22));
		txtDownload.setEditable(true);
		txtDownload.setMaxChars(200);
		
		panel166 = new JPanel();
		panel166.setLocation(new IntPoint(10, 200));
		panel166.setSize(new IntDimension(265, 10));
		
		btnDownload = new JButton();
		btnDownload.setLocation(new IntPoint(5, 5));
		btnDownload.setSize(new IntDimension(82, 26));
		btnDownload.setText("加载网络图片");
		
		//component layoution
		append(panel158);
		append(spacer159);
		append(txtUpload);
		append(panel161);
		append(spacer163);
		append(label164);
		append(txtDownload);
		append(panel166);
		
		panel158.append(btnBack);
		
		panel161.append(btnBrowse);
		
		panel166.append(btnDownload);
		
	}
	
	//_________getters_________
	
	
	public function getBtnBack():JButton{
		return btnBack;
	}
	
	
	public function getTxtUpload():JTextField{
		return txtUpload;
	}
	
	
	public function getBtnBrowse():JButton{
		return btnBrowse;
	}
	
	
	
	public function getTxtDownload():JTextField{
		return txtDownload;
	}
	
	
	public function getBtnDownload():JButton{
		return btnDownload;
	}
	
	
}
}
