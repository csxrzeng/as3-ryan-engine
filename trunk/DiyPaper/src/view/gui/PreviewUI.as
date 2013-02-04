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
	private var panel3:JPanel;
	private var panel4:JPanel;
	protected var btnBack:JButton;
	protected var btnSave:JButton;
	
	/**
	 * PreviewUI Constructor
	 */
	public function PreviewUI(){
		//component creation
		setSize(new IntDimension(500, 400));
		var layout0:BorderLayout = new BorderLayout();
		setLayout(layout0);
		
		scrollpane = new JScrollPane();
		scrollpane.setLocation(new IntPoint(5, 5));
		scrollpane.setConstraints("Center");
		
		panel3 = new JPanel();
		panel3.setSize(new IntDimension(10, 10));
		panel3.setConstraints("Center");
		var border1:EmptyBorder = new EmptyBorder();
		border1.setTop(100);
		border1.setLeft(100);
		border1.setBottom(100);
		border1.setRight(100);
		panel3.setBorder(border1);
		var layout2:BorderLayout = new BorderLayout();
		panel3.setLayout(layout2);
		
		panel4 = new JPanel();
		panel4.setLocation(new IntPoint(100, 274));
		panel4.setSize(new IntDimension(300, 26));
		panel4.setConstraints("South");
		var layout3:FlowLayout = new FlowLayout();
		layout3.setAlignment(AsWingConstants.CENTER);
		layout3.setHgap(10);
		layout3.setVgap(0);
		panel4.setLayout(layout3);
		
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
		append(panel3);
		
		panel3.append(panel4);
		
		panel4.append(btnBack);
		panel4.append(btnSave);
		
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
