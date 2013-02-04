package view.gui{

import org.aswing.*;
import org.aswing.border.*;
import org.aswing.geom.*;
import org.aswing.colorchooser.*;
import org.aswing.ext.*;

/**
 * PropertyBar
 */
public class PropertyBar extends JPanel{
	
	//members define
	private var toolbar5:JToolBar;
	protected var btnBase:JToggleButton;
	protected var btnText:JToggleButton;
	protected var btnImage:JToggleButton;
	private var spacer10:JSpacer;
	protected var btnFullscreen:JButton;
	
	/**
	 * PropertyBar Constructor
	 */
	public function PropertyBar(){
		//component creation
		setSize(new IntDimension(252, 36));
		setConstraints("East");
		var border0:EmptyBorder = new EmptyBorder();
		border0.setRight(10);
		setBorder(border0);
		
		toolbar5 = new JToolBar();
		toolbar5.setLocation(new IntPoint(5, 5));
		toolbar5.setSize(new IntDimension(178, 26));
		toolbar5.setOrientation(AsWingConstants.HORIZONTAL);
		toolbar5.setGap(5);
		
		btnBase = new JToggleButton();
		btnBase.setLocation(new IntPoint(36, 0));
		btnBase.setSize(new IntDimension(58, 26));
		btnBase.setText("基本属性");
		
		btnText = new JToggleButton();
		btnText.setLocation(new IntPoint(36, 0));
		btnText.setSize(new IntDimension(58, 26));
		btnText.setText("添加文字");
		
		btnImage = new JToggleButton();
		btnImage.setLocation(new IntPoint(108, 0));
		btnImage.setSize(new IntDimension(58, 26));
		btnImage.setText("添加图片");
		
		spacer10 = new JSpacer();
		spacer10.setLocation(new IntPoint(116, 13));
		spacer10.setSize(new IntDimension(10, 10));
		spacer10.setPreferredSize(new IntDimension(10, 10));
		
		btnFullscreen = new JButton();
		btnFullscreen.setLocation(new IntPoint(5, 36));
		btnFullscreen.setSize(new IntDimension(34, 26));
		btnFullscreen.setText("全屏");
		
		//component layoution
		append(toolbar5);
		append(spacer10);
		append(btnFullscreen);
		
		toolbar5.append(btnBase);
		toolbar5.append(btnText);
		toolbar5.append(btnImage);
		
	}
	
	//_________getters_________
	
	
	
	
	
	
	
	
}
}
