package view.gui{

import org.aswing.*;
import org.aswing.border.*;
import org.aswing.geom.*;
import org.aswing.colorchooser.*;
import org.aswing.ext.*;

/**
 * PreviewUI
 */
public class PreviewUI extends JPanel{
	
	//members define
	protected var scrollpane:JScrollPane;
	protected var paneButtons:JPanel;
	protected var btnBack:JButton;
	protected var btnSave:JButton;
	
	/**
	 * PreviewUI Constructor
	 */
	public function PreviewUI(){
		//component creation
		setSize(new IntDimension(612, 473));
		var layout0:CenterLayout = new CenterLayout();
		setLayout(layout0);
		
		scrollpane = new JScrollPane();
		scrollpane.setLocation(new IntPoint(5, 5));
		scrollpane.setSize(new IntDimension(0, 0));
		scrollpane.setConstraints("Center");
		
		paneButtons = new JPanel();
		paneButtons.setLocation(new IntPoint(250, 400));
		paneButtons.setSize(new IntDimension(150, 26));
		paneButtons.setPreferredSize(new IntDimension(150, 26));
		paneButtons.setConstraints("South");
		var layout1:FlowLayout = new FlowLayout();
		layout1.setAlignment(AsWingConstants.CENTER);
		layout1.setHgap(10);
		layout1.setVgap(0);
		paneButtons.setLayout(layout1);
		
		btnBack = new JButton();
		btnBack.setLocation(new IntPoint(75, 0));
		btnBack.setSize(new IntDimension(60, 26));
		btnBack.setPreferredSize(new IntDimension(60, 26));
		btnBack.setText("返 回");
		
		btnSave = new JButton();
		btnSave.setLocation(new IntPoint(155, 0));
		btnSave.setSize(new IntDimension(60, 26));
		btnSave.setPreferredSize(new IntDimension(60, 26));
		btnSave.setText("保 存");
		
		//component layoution
		append(scrollpane);
		append(paneButtons);
		
		paneButtons.append(btnBack);
		paneButtons.append(btnSave);
		
	}
	
	//_________getters_________
	
	
	
	public function getBtnBack():JButton{
		return btnBack;
	}
	
	public function getBtnSave():JButton{
		return btnSave;
	}
	
	
}
}
