package view.gui{

import org.aswing.*;
import org.aswing.border.*;
import org.aswing.geom.*;
import org.aswing.colorchooser.*;
import org.aswing.ext.*;

/**
 * SpecialTextProperty
 */
public class SpecialTextProperty extends JPanel{
	
	//members define
	private var panel84:JPanel;
	private var panel85:JPanel;
	protected var btnSpecial:JToggleButton;
	protected var btnStatic:JToggleButton;
	protected var txtInput:JTextArea;
	private var panel91:JPanel;
	protected var btnAdd:JButton;
	protected var combobox:JComboBox;
	protected var colormixer:JColorMixer;
	
	/**
	 * SpecialTextProperty Constructor
	 */
	public function SpecialTextProperty(){
		//component creation
		setSize(new IntDimension(285, 440));
		var layout0:EmptyLayout = new EmptyLayout();
		setLayout(layout0);
		
		panel84 = new JPanel();
		panel84.setLocation(new IntPoint(10, 15));
		panel84.setSize(new IntDimension(265, 410));
		panel84.setPreferredSize(new IntDimension(265, 410));
		var layout1:SoftBoxLayout = new SoftBoxLayout();
		layout1.setAxis(AsWingConstants.VERTICAL);
		layout1.setAlign(AsWingConstants.TOP);
		layout1.setGap(5);
		panel84.setLayout(layout1);
		
		panel85 = new JPanel();
		panel85.setSize(new IntDimension(265, 26));
		var layout2:SoftBoxLayout = new SoftBoxLayout();
		layout2.setAxis(AsWingConstants.HORIZONTAL);
		layout2.setAlign(AsWingConstants.CENTER);
		panel85.setLayout(layout2);
		
		btnSpecial = new JToggleButton();
		btnSpecial.setLocation(new IntPoint(5, 5));
		btnSpecial.setSize(new IntDimension(58, 26));
		btnSpecial.setText("特效文字");
		
		btnStatic = new JToggleButton();
		btnStatic.setLocation(new IntPoint(47, 5));
		btnStatic.setSize(new IntDimension(58, 26));
		btnStatic.setText("静态文字");
		
		txtInput = new JTextArea();
		txtInput.setLocation(new IntPoint(0, 31));
		txtInput.setSize(new IntDimension(265, 60));
		txtInput.setPreferredSize(new IntDimension(265, 60));
		txtInput.setEditable(true);
		txtInput.setMaxChars(200);
		txtInput.setWordWrap(true);
		
		panel91 = new JPanel();
		panel91.setLocation(new IntPoint(0, 96));
		panel91.setSize(new IntDimension(265, 0));
		var layout3:BorderLayout = new BorderLayout();
		panel91.setLayout(layout3);
		
		btnAdd = new JButton();
		btnAdd.setLocation(new IntPoint(104, 0));
		btnAdd.setSize(new IntDimension(265, 26));
		btnAdd.setConstraints("East");
		btnAdd.setText("添加文字");
		
		combobox = new JComboBox();
		combobox.setSize(new IntDimension(90, 26));
		combobox.setPreferredSize(new IntDimension(90, 26));
		combobox.setConstraints("West");
		combobox.setMaximumRowCount(7);
		
		colormixer = new JColorMixer();
		colormixer.setLocation(new IntPoint(0, 127));
		colormixer.setSize(new IntDimension(265, 192));
		
		//component layoution
		append(panel84);
		
		panel84.append(panel85);
		panel84.append(txtInput);
		panel84.append(panel91);
		panel84.append(colormixer);
		
		panel85.append(btnSpecial);
		panel85.append(btnStatic);
		
		panel91.append(btnAdd);
		panel91.append(combobox);
		
	}
	
	//_________getters_________
	
	
	
	public function getBtnSpecial():JToggleButton{
		return btnSpecial;
	}
	
	public function getBtnStatic():JToggleButton{
		return btnStatic;
	}
	
	public function getTxtInput():JTextArea{
		return txtInput;
	}
	
	
	public function getBtnAdd():JButton{
		return btnAdd;
	}
	
	public function getCombobox():JComboBox{
		return combobox;
	}
	
	public function getColormixer():JColorMixer{
		return colormixer;
	}
	
	
}
}
