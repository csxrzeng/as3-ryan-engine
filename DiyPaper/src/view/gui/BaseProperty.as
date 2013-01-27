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
	protected var sW:JStepper;
	protected var sH:JStepper;
	protected var sB:JStepper;
	protected var btnBg:JButton;
	
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
		
		sW = new JStepper();
		sW.setLocation(new IntPoint(50, 17));
		sW.setSize(new IntDimension(75, 22));
		sW.setColumns(3);
		
		sH = new JStepper();
		sH.setLocation(new IntPoint(50, 46));
		sH.setSize(new IntDimension(75, 22));
		sH.setColumns(3);
		
		sB = new JStepper();
		sB.setLocation(new IntPoint(180, 46));
		sB.setSize(new IntDimension(75, 22));
		sB.setColumns(3);
		
		btnBg = new JButton();
		btnBg.setLocation(new IntPoint(230, 17));
		btnBg.setSize(new IntDimension(26, 26));
		btnBg.setText("　");
		
		//component layoution
		append(label12);
		append(label13);
		append(label14);
		append(label15);
		append(sW);
		append(sH);
		append(sB);
		append(btnBg);
		
	}
	
	//_________getters_________
	
	
	
	
	
	public function getSW():JStepper{
		return sW;
	}
	
	public function getSH():JStepper{
		return sH;
	}
	
	public function getSB():JStepper{
		return sB;
	}
	
	public function getBtnBg():JButton{
		return btnBg;
	}
	
	
}
}
