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
	protected var btnOnline:JToggleButton;
	protected var btnMyAssets:JButton;
	private var panel7:JPanel;
	private var label10:JLabel;
	protected var cbType:JComboBox;
	protected var spLibrary:JScrollPane;
	protected var pane:JPanel;
	private var panel21:JPanel;
	protected var btnPre:JLabelButton;
	protected var txtPage:JTextField;
	protected var btnNext:JLabelButton;
	
	/**
	 * ImageLibrary Constructor
	 */
	public function ImageLibrary(){
		//component creation
		setSize(new IntDimension(285, 440));
		setPreferredSize(new IntDimension(285, 440));
		var border0:EmptyBorder = new EmptyBorder();
		border0.setTop(15);
		border0.setLeft(0);
		border0.setBottom(15);
		border0.setRight(0);
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
		
		btnOnline = new JToggleButton();
		btnOnline.setLocation(new IntPoint(104, 0));
		btnOnline.setSize(new IntDimension(58, 26));
		btnOnline.setText("在线图标");
		
		btnMyAssets = new JButton();
		btnMyAssets.setLocation(new IntPoint(133, 0));
		btnMyAssets.setSize(new IntDimension(58, 26));
		btnMyAssets.setText("我的素材");
		
		panel7 = new JPanel();
		panel7.setLocation(new IntPoint(10, 46));
		panel7.setSize(new IntDimension(265, 22));
		var layout3:SoftBoxLayout = new SoftBoxLayout();
		layout3.setAxis(AsWingConstants.HORIZONTAL);
		layout3.setAlign(AsWingConstants.CENTER);
		panel7.setLayout(layout3);
		
		label10 = new JLabel();
		label10.setLocation(new IntPoint(5, 6));
		label10.setSize(new IntDimension(64, 19));
		label10.setText("素材分类：");
		
		cbType = new JComboBox();
		cbType.setLocation(new IntPoint(105, 0));
		cbType.setSize(new IntDimension(120, 22));
		cbType.setPreferredSize(new IntDimension(120, 22));
		cbType.setMaximumRowCount(7);
		
		spLibrary = new JScrollPane();
		spLibrary.setLocation(new IntPoint(10, 45));
		spLibrary.setSize(new IntDimension(285, 332));
		spLibrary.setPreferredSize(new IntDimension(285, 332));
		var border4:LineBorder = new LineBorder();
		border4.setColor(new ASColor(0x666666, 1));
		border4.setThickness(1);
		border4.setRound(1);
		spLibrary.setBorder(border4);
		
		pane = new JPanel();
		pane.setLocation(new IntPoint(1, 0));
		pane.setSize(new IntDimension(265, 328));
		pane.setPreferredSize(new IntDimension(265, 328));
		var layout5:FlowWrapLayout = new FlowWrapLayout();
		layout5.setPreferWidth(265);
		layout5.setAlignment(AsWingConstants.LEFT);
		layout5.setHgap(1);
		layout5.setVgap(1);
		pane.setLayout(layout5);
		
		panel21 = new JPanel();
		panel21.setLocation(new IntPoint(0, 432));
		panel21.setSize(new IntDimension(285, 26));
		var layout6:FlowLayout = new FlowLayout();
		layout6.setAlignment(AsWingConstants.CENTER);
		layout6.setHgap(8);
		layout6.setVgap(2);
		panel21.setLayout(layout6);
		
		btnPre = new JLabelButton();
		btnPre.setLocation(new IntPoint(122, 5));
		btnPre.setSize(new IntDimension(40, 19));
		btnPre.setText("上一页");
		
		txtPage = new JTextField();
		txtPage.setLocation(new IntPoint(112, 5));
		txtPage.setSize(new IntDimension(60, 22));
		txtPage.setPreferredSize(new IntDimension(60, 22));
		txtPage.setText("1/1");
		txtPage.setEditable(true);
		txtPage.setMaxChars(7);
		txtPage.setRestrict("0-9/");
		txtPage.setWordWrap(false);
		
		btnNext = new JLabelButton();
		btnNext.setLocation(new IntPoint(145, 5));
		btnNext.setSize(new IntDimension(40, 19));
		btnNext.setText("下一页");
		
		//component layoution
		append(panel117);
		append(panel7);
		append(spLibrary);
		append(panel21);
		
		panel117.append(btnOnline);
		panel117.append(btnMyAssets);
		
		panel7.append(label10);
		panel7.append(cbType);
		
		spLibrary.append(pane);
		
		panel21.append(btnPre);
		panel21.append(txtPage);
		panel21.append(btnNext);
		
	}
	
	//_________getters_________
	
	
	public function getBtnOnline():JToggleButton{
		return btnOnline;
	}
	
	public function getBtnMyAssets():JButton{
		return btnMyAssets;
	}
	
	
	
	public function getCbType():JComboBox{
		return cbType;
	}
	
	
	
	
	public function getBtnPre():JLabelButton{
		return btnPre;
	}
	
	public function getTxtPage():JTextField{
		return txtPage;
	}
	
	public function getBtnNext():JLabelButton{
		return btnNext;
	}
	
	
}
}
