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
	protected var spLibrary:JScrollPane;
	protected var pane:JPanel;
	
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
		
		btnOnline = new JToggleButton();
		btnOnline.setLocation(new IntPoint(104, 0));
		btnOnline.setSize(new IntDimension(58, 26));
		btnOnline.setText("在线图标");
		
		btnMyAssets = new JButton();
		btnMyAssets.setLocation(new IntPoint(133, 0));
		btnMyAssets.setSize(new IntDimension(58, 26));
		btnMyAssets.setText("我的素材");
		
		spLibrary = new JScrollPane();
		spLibrary.setLocation(new IntPoint(10, 45));
		spLibrary.setSize(new IntDimension(265, 380));
		
		pane = new JPanel();
		pane.setLocation(new IntPoint(0, 0));
		pane.setSize(new IntDimension(265, 380));
		pane.setPreferredSize(new IntDimension(265, 380));
		var layout3:FlowWrapLayout = new FlowWrapLayout();
		layout3.setPreferWidth(265);
		layout3.setAlignment(AsWingConstants.LEFT);
		layout3.setHgap(1);
		layout3.setVgap(1);
		pane.setLayout(layout3);
		
		//component layoution
		append(panel117);
		append(spLibrary);
		
		panel117.append(btnOnline);
		panel117.append(btnMyAssets);
		
		spLibrary.append(pane);
		
	}
	
	//_________getters_________
	
	
	public function getBtnOnline():JToggleButton{
		return btnOnline;
	}
	
	public function getBtnMyAssets():JButton{
		return btnMyAssets;
	}
	
	
	
	
}
}
