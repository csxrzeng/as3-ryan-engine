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
	private var spacer7:JSpacer;
	private var panel117:JPanel;
	protected var btnOnline:JToggleButton;
	protected var btnMyAssets:JButton;
	protected var spLibrary:JScrollPane;
	
	/**
	 * ImageLibrary Constructor
	 */
	public function ImageLibrary(){
		//component creation
		setSize(new IntDimension(285, 440));
		setPreferredSize(new IntDimension(285, 440));
		var layout0:SoftBoxLayout = new SoftBoxLayout();
		layout0.setAxis(AsWingConstants.VERTICAL);
		layout0.setAlign(AsWingConstants.TOP);
		layout0.setGap(5);
		setLayout(layout0);
		
		spacer7 = new JSpacer();
		spacer7.setLocation(new IntPoint(0, 0));
		spacer7.setSize(new IntDimension(285, 10));
		spacer7.setPreferredSize(new IntDimension(285, 10));
		
		panel117 = new JPanel();
		panel117.setLocation(new IntPoint(5, 5));
		panel117.setSize(new IntDimension(265, 26));
		var layout1:SoftBoxLayout = new SoftBoxLayout();
		layout1.setAxis(AsWingConstants.HORIZONTAL);
		layout1.setAlign(AsWingConstants.CENTER);
		panel117.setLayout(layout1);
		
		btnOnline = new JToggleButton();
		btnOnline.setLocation(new IntPoint(104, 0));
		btnOnline.setSize(new IntDimension(58, 26));
		btnOnline.setText("在线图标");
		
		btnMyAssets = new JButton();
		btnMyAssets.setLocation(new IntPoint(133, 0));
		btnMyAssets.setSize(new IntDimension(58, 26));
		btnMyAssets.setText("我的素材");
		
		spLibrary = new JScrollPane();
		spLibrary.setLocation(new IntPoint(0, 51));
		spLibrary.setSize(new IntDimension(285, 394));
		spLibrary.setPreferredSize(new IntDimension(285, 394));
		var border2:LineBorder = new LineBorder();
		border2.setColor(new ASColor(0x0, 1));
		border2.setThickness(1);
		border2.setRound(5);
		spLibrary.setBorder(border2);
		
		//component layoution
		append(spacer7);
		append(panel117);
		append(spLibrary);
		
		panel117.append(btnOnline);
		panel117.append(btnMyAssets);
		
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
