package view.gui{

import org.aswing.*;
import org.aswing.border.*;
import org.aswing.geom.*;
import org.aswing.colorchooser.*;
import org.aswing.ext.*;

/**
 * BaseProperty
 */
public class BaseProperty extends JPanel{
	
	//members define
	private var label12:JLabel;
	private var label13:JLabel;
	private var label14:JLabel;
	private var label15:JLabel;
	private var stepper17:JStepper;
	private var stepper18:JStepper;
	private var stepper19:JStepper;
	private var button21:JButton;
	
	/**
	 * BaseProperty Constructor
	 */
	public function BaseProperty(){
		//component creation
		setBackground(new ASColor(0x33ff00, 1));
		setSize(new IntDimension(285, 95));
		var layout0:EmptyLayout = new EmptyLayout();
		setLayout(layout0);
		
		label12 = new JLabel();
		label12.setLocation(new IntPoint(15, 18));
		label12.setSize(new IntDimension(31, 19));
		label12.setText("宽度");
		
		label13 = new JLabel();
		label13.setLocation(new IntPoint(15, 46));
		label13.setSize(new IntDimension(31, 19));
		label13.setText("高度");
		
		label14 = new JLabel();
		label14.setLocation(new IntPoint(185, 20));
		label14.setSize(new IntDimension(40, 19));
		label14.setText("背景色");
		
		label15 = new JLabel();
		label15.setLocation(new IntPoint(146, 46));
		label15.setSize(new IntDimension(31, 19));
		label15.setText("边框");
		
		stepper17 = new JStepper();
		stepper17.setLocation(new IntPoint(50, 17));
		stepper17.setSize(new IntDimension(75, 22));
		stepper17.setColumns(3);
		
		stepper18 = new JStepper();
		stepper18.setLocation(new IntPoint(50, 46));
		stepper18.setSize(new IntDimension(75, 22));
		stepper18.setColumns(3);
		
		stepper19 = new JStepper();
		stepper19.setLocation(new IntPoint(180, 46));
		stepper19.setSize(new IntDimension(75, 22));
		stepper19.setColumns(3);
		
		button21 = new JButton();
		button21.setLocation(new IntPoint(230, 17));
		button21.setSize(new IntDimension(26, 26));
		button21.setText("　　");
		
		//component layoution
		append(label12);
		append(label13);
		append(label14);
		append(label15);
		append(stepper17);
		append(stepper18);
		append(stepper19);
		append(button21);
		
	}
	
	//_________getters_________
	
	
	
	
	
	public function getStepper17():JStepper{
		return stepper17;
	}
	
	public function getStepper18():JStepper{
		return stepper18;
	}
	
	public function getStepper19():JStepper{
		return stepper19;
	}
	
	public function getButton21():JButton{
		return button21;
	}
	
	
}
}
