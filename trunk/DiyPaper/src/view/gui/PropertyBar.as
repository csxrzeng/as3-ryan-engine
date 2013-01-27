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
	private var togglebutton8:JToggleButton;
	private var togglebutton9:JToggleButton;
	private var togglebutton10:JToggleButton;
	private var button6:JButton;
	
	/**
	 * PropertyBar Constructor
	 */
	public function PropertyBar(){
		//component creation
		setOpaque(true);
		setBackground(new ASColor(0xa5ce1c, 1));
		setSize(new IntDimension(155, 36));
		setConstraints("East");
		
		toolbar5 = new JToolBar();
		toolbar5.setLocation(new IntPoint(5, 5));
		toolbar5.setSize(new IntDimension(106, 26));
		
		togglebutton8 = new JToggleButton();
		togglebutton8.setLocation(new IntPoint(36, 0));
		togglebutton8.setSize(new IntDimension(37, 26));
		togglebutton8.setText("属性");
		
		togglebutton9 = new JToggleButton();
		togglebutton9.setLocation(new IntPoint(36, 0));
		togglebutton9.setSize(new IntDimension(37, 26));
		togglebutton9.setText("文字");
		
		togglebutton10 = new JToggleButton();
		togglebutton10.setLocation(new IntPoint(108, 0));
		togglebutton10.setSize(new IntDimension(34, 26));
		togglebutton10.setText("图片");
		
		button6 = new JButton();
		button6.setLocation(new IntPoint(5, 36));
		button6.setSize(new IntDimension(34, 26));
		button6.setText("全屏");
		
		//component layoution
		append(toolbar5);
		append(button6);
		
		toolbar5.append(togglebutton8);
		toolbar5.append(togglebutton9);
		toolbar5.append(togglebutton10);
		
	}
	
	//_________getters_________
	
	
	public function getTogglebutton8():JToggleButton{
		return togglebutton8;
	}
	
	public function getTogglebutton9():JToggleButton{
		return togglebutton9;
	}
	
	public function getTogglebutton10():JToggleButton{
		return togglebutton10;
	}
	
	public function getButton6():JButton{
		return button6;
	}
	
	
}
}
