package view.gui{

import org.aswing.*;
import org.aswing.border.*;
import org.aswing.geom.*;
import org.aswing.colorchooser.*;
import org.aswing.ext.*;

/**
 * StaticTextProperty
 */
public class StaticTextProperty extends JPanel{
	
	//members define
	protected var panel28:JPanel;
	private var panel25:JPanel;
	private var togglebutton23:JToggleButton;
	private var togglebutton26:JToggleButton;
	private var textarea27:JTextArea;
	private var panel29:JPanel;
	private var combobox30:JComboBox;
	private var button31:JButton;
	private var panel32:JPanel;
	private var panel46:JPanel;
	private var togglebutton37:JToggleButton;
	private var togglebutton38:JToggleButton;
	private var togglebutton39:JToggleButton;
	private var togglebutton40:JToggleButton;
	private var togglebutton41:JToggleButton;
	private var togglebutton42:JToggleButton;
	private var panel47:JPanel;
	private var togglebutton43:JToggleButton;
	private var togglebutton44:JToggleButton;
	private var spacer68:JSpacer;
	private var panel82:JPanel;
	private var panel48:JPanel;
	private var label49:JLabel;
	private var slider50:JSlider;
	private var panel52:JPanel;
	private var label53:JLabel;
	private var button54:JButton;
	private var separator56:JSeparator;
	private var panel57:JPanel;
	private var label58:JLabel;
	private var slider59:JSlider;
	private var panel60:JPanel;
	private var label61:JLabel;
	private var slider62:JSlider;
	private var panel63:JPanel;
	private var label64:JLabel;
	private var button65:JButton;
	private var separator66:JSeparator;
	private var panel70:JPanel;
	private var label71:JLabel;
	private var slider72:JSlider;
	private var panel73:JPanel;
	private var label74:JLabel;
	private var slider75:JSlider;
	private var panel76:JPanel;
	private var label77:JLabel;
	private var slider78:JSlider;
	private var panel79:JPanel;
	private var label80:JLabel;
	private var slider81:JSlider;
	
	/**
	 * StaticTextProperty Constructor
	 */
	public function StaticTextProperty(){
		//component creation
		setSize(new IntDimension(285, 440));
		var layout0:CenterLayout = new CenterLayout();
		setLayout(layout0);
		
		panel28 = new JPanel();
		panel28.setLocation(new IntPoint(10, 15));
		panel28.setSize(new IntDimension(265, 410));
		panel28.setPreferredSize(new IntDimension(265, 410));
		var layout1:SoftBoxLayout = new SoftBoxLayout();
		layout1.setAxis(AsWingConstants.VERTICAL);
		layout1.setAlign(AsWingConstants.TOP);
		layout1.setGap(5);
		panel28.setLayout(layout1);
		
		panel25 = new JPanel();
		panel25.setLocation(new IntPoint(0, 183));
		panel25.setSize(new IntDimension(275, 60));
		var layout2:SoftBoxLayout = new SoftBoxLayout();
		layout2.setAxis(AsWingConstants.HORIZONTAL);
		layout2.setAlign(AsWingConstants.CENTER);
		panel25.setLayout(layout2);
		
		togglebutton23 = new JToggleButton();
		togglebutton23.setLocation(new IntPoint(0, 202));
		togglebutton23.setSize(new IntDimension(58, 26));
		togglebutton23.setText("特效文字");
		
		togglebutton26 = new JToggleButton();
		togglebutton26.setLocation(new IntPoint(143, 0));
		togglebutton26.setSize(new IntDimension(58, 26));
		togglebutton26.setText("静态文字");
		
		textarea27 = new JTextArea();
		textarea27.setLocation(new IntPoint(0, 206));
		textarea27.setSize(new IntDimension(265, 60));
		textarea27.setPreferredSize(new IntDimension(265, 60));
		textarea27.setEditable(true);
		textarea27.setMaxChars(200);
		textarea27.setWordWrap(true);
		
		panel29 = new JPanel();
		panel29.setLocation(new IntPoint(0, 96));
		panel29.setSize(new IntDimension(265, 26));
		var layout3:BorderLayout = new BorderLayout();
		layout3.setHgap(0);
		layout3.setVgap(0);
		panel29.setLayout(layout3);
		
		combobox30 = new JComboBox();
		combobox30.setLocation(new IntPoint(0, 0));
		combobox30.setSize(new IntDimension(60, 22));
		combobox30.setPreferredSize(new IntDimension(60, 22));
		combobox30.setConstraints("West");
		combobox30.setMaximumRowCount(7);
		
		button31 = new JButton();
		button31.setLocation(new IntPoint(207, 0));
		button31.setSize(new IntDimension(58, 26));
		button31.setConstraints("East");
		button31.setText("添加文字");
		
		panel32 = new JPanel();
		panel32.setLocation(new IntPoint(0, 127));
		panel32.setSize(new IntDimension(265, 26));
		var layout4:BorderLayout = new BorderLayout();
		layout4.setHgap(0);
		layout4.setVgap(0);
		panel32.setLayout(layout4);
		
		panel46 = new JPanel();
		panel46.setLocation(new IntPoint(0, 0));
		panel46.setSize(new IntDimension(231, 36));
		var layout5:FlowLayout = new FlowLayout();
		layout5.setHgap(0);
		layout5.setVgap(0);
		panel46.setLayout(layout5);
		
		togglebutton37 = new JToggleButton();
		togglebutton37.setLocation(new IntPoint(5, 5));
		togglebutton37.setSize(new IntDimension(22, 26));
		togglebutton37.setConstraints("West");
		togglebutton37.setText("左");
		
		togglebutton38 = new JToggleButton();
		togglebutton38.setLocation(new IntPoint(0, 0));
		togglebutton38.setSize(new IntDimension(22, 26));
		togglebutton38.setConstraints("West");
		togglebutton38.setText("中");
		
		togglebutton39 = new JToggleButton();
		togglebutton39.setLocation(new IntPoint(0, 0));
		togglebutton39.setSize(new IntDimension(22, 26));
		togglebutton39.setConstraints("West");
		togglebutton39.setText("右");
		
		togglebutton40 = new JToggleButton();
		togglebutton40.setLocation(new IntPoint(0, 0));
		togglebutton40.setSize(new IntDimension(22, 26));
		togglebutton40.setConstraints("West");
		togglebutton40.setText("粗");
		
		togglebutton41 = new JToggleButton();
		togglebutton41.setLocation(new IntPoint(0, 0));
		togglebutton41.setSize(new IntDimension(22, 26));
		togglebutton41.setConstraints("West");
		togglebutton41.setText("斜");
		
		togglebutton42 = new JToggleButton();
		togglebutton42.setLocation(new IntPoint(0, 0));
		togglebutton42.setSize(new IntDimension(22, 26));
		togglebutton42.setConstraints("West");
		togglebutton42.setText("线");
		
		panel47 = new JPanel();
		panel47.setLocation(new IntPoint(197, 0));
		panel47.setSize(new IntDimension(68, 26));
		panel47.setConstraints("East");
		var layout6:FlowLayout = new FlowLayout();
		layout6.setHgap(0);
		layout6.setVgap(0);
		panel47.setLayout(layout6);
		
		togglebutton43 = new JToggleButton();
		togglebutton43.setLocation(new IntPoint(167, 5));
		togglebutton43.setSize(new IntDimension(34, 26));
		togglebutton43.setConstraints("East");
		togglebutton43.setText("横排");
		
		togglebutton44 = new JToggleButton();
		togglebutton44.setLocation(new IntPoint(231, 0));
		togglebutton44.setSize(new IntDimension(34, 26));
		togglebutton44.setConstraints("East");
		togglebutton44.setText("竖排");
		
		spacer68 = new JSpacer();
		spacer68.setLocation(new IntPoint(0, 186));
		spacer68.setSize(new IntDimension(265, 0));
		
		panel82 = new JPanel();
		panel82.setLocation(new IntPoint(0, 304));
		panel82.setSize(new IntDimension(265, 236));
		var border7:EmptyBorder = new EmptyBorder();
		border7.setRight(10);
		panel82.setBorder(border7);
		var layout8:SoftBoxLayout = new SoftBoxLayout();
		layout8.setAxis(AsWingConstants.VERTICAL);
		layout8.setAlign(AsWingConstants.TOP);
		layout8.setGap(5);
		panel82.setLayout(layout8);
		
		panel48 = new JPanel();
		panel48.setLocation(new IntPoint(0, 0));
		panel48.setSize(new IntDimension(265, 23));
		var layout9:EmptyLayout = new EmptyLayout();
		panel48.setLayout(layout9);
		
		label49 = new JLabel();
		label49.setLocation(new IntPoint(5, 5));
		label49.setSize(new IntDimension(50, 23));
		label49.setPreferredSize(new IntDimension(50, 23));
		label49.setConstraints("West");
		label49.setText("字号(12)");
		
		slider50 = new JSlider();
		slider50.setLocation(new IntPoint(60, 4));
		slider50.setSize(new IntDimension(200, 14));
		slider50.setConstraints("East");
		slider50.setValue(0);
		slider50.setExtent(0);
		slider50.setMinimum(0);
		slider50.setMaximum(100);
		
		panel52 = new JPanel();
		panel52.setLocation(new IntPoint(0, 27));
		panel52.setSize(new IntDimension(265, 27));
		var layout10:BorderLayout = new BorderLayout();
		layout10.setHgap(0);
		layout10.setVgap(0);
		panel52.setLayout(layout10);
		
		label53 = new JLabel();
		label53.setLocation(new IntPoint(5, 5));
		label53.setSize(new IntDimension(40, 26));
		label53.setConstraints("West");
		label53.setText("描边：");
		
		button54 = new JButton();
		button54.setLocation(new IntPoint(239, 0));
		button54.setSize(new IntDimension(26, 26));
		button54.setConstraints("East");
		button54.setText("　　");
		
		separator56 = new JSeparator();
		separator56.setLocation(new IntPoint(0, 26));
		separator56.setSize(new IntDimension(265, 1));
		separator56.setConstraints("South");
		
		panel57 = new JPanel();
		panel57.setLocation(new IntPoint(0, 54));
		panel57.setSize(new IntDimension(255, 19));
		var layout11:EmptyLayout = new EmptyLayout();
		panel57.setLayout(layout11);
		
		label58 = new JLabel();
		label58.setLocation(new IntPoint(5, 5));
		label58.setSize(new IntDimension(43, 19));
		label58.setConstraints("West");
		label58.setText("粗细(5)");
		
		slider59 = new JSlider();
		slider59.setLocation(new IntPoint(60, 4));
		slider59.setSize(new IntDimension(200, 19));
		slider59.setConstraints("East");
		slider59.setValue(0);
		slider59.setExtent(0);
		slider59.setMinimum(0);
		slider59.setMaximum(100);
		
		panel60 = new JPanel();
		panel60.setLocation(new IntPoint(0, 81));
		panel60.setSize(new IntDimension(255, 19));
		var layout12:EmptyLayout = new EmptyLayout();
		panel60.setLayout(layout12);
		
		label61 = new JLabel();
		label61.setLocation(new IntPoint(5, 5));
		label61.setSize(new IntDimension(43, 19));
		label61.setConstraints("West");
		label61.setText("透明(0)");
		
		slider62 = new JSlider();
		slider62.setLocation(new IntPoint(60, 4));
		slider62.setSize(new IntDimension(200, 14));
		slider62.setConstraints("East");
		slider62.setValue(0);
		slider62.setExtent(0);
		slider62.setMinimum(0);
		slider62.setMaximum(100);
		
		panel63 = new JPanel();
		panel63.setLocation(new IntPoint(0, 108));
		panel63.setSize(new IntDimension(265, 26));
		var layout13:BorderLayout = new BorderLayout();
		panel63.setLayout(layout13);
		
		label64 = new JLabel();
		label64.setLocation(new IntPoint(5, 5));
		label64.setSize(new IntDimension(34, 19));
		label64.setConstraints("West");
		label64.setText("投影：");
		
		button65 = new JButton();
		button65.setLocation(new IntPoint(239, 0));
		button65.setSize(new IntDimension(26, 26));
		button65.setConstraints("East");
		button65.setText("　　");
		
		separator66 = new JSeparator();
		separator66.setLocation(new IntPoint(0, 26));
		separator66.setSize(new IntDimension(265, 1));
		separator66.setConstraints("South");
		
		panel70 = new JPanel();
		panel70.setLocation(new IntPoint(0, 135));
		panel70.setSize(new IntDimension(255, 14));
		var layout14:EmptyLayout = new EmptyLayout();
		panel70.setLayout(layout14);
		
		label71 = new JLabel();
		label71.setSize(new IntDimension(43, 19));
		label71.setConstraints("West");
		label71.setText("效果(1)");
		
		slider72 = new JSlider();
		slider72.setLocation(new IntPoint(60, 4));
		slider72.setSize(new IntDimension(200, 19));
		slider72.setConstraints("East");
		slider72.setValue(0);
		slider72.setExtent(0);
		slider72.setMinimum(0);
		slider72.setMaximum(100);
		
		panel73 = new JPanel();
		panel73.setLocation(new IntPoint(0, 332));
		panel73.setSize(new IntDimension(255, 14));
		var layout15:EmptyLayout = new EmptyLayout();
		panel73.setLayout(layout15);
		
		label74 = new JLabel();
		label74.setLocation(new IntPoint(0, 0));
		label74.setSize(new IntDimension(43, 19));
		label74.setConstraints("West");
		label74.setText("透明(0)");
		
		slider75 = new JSlider();
		slider75.setLocation(new IntPoint(60, 4));
		slider75.setSize(new IntDimension(200, 19));
		slider75.setConstraints("East");
		slider75.setValue(0);
		slider75.setExtent(0);
		slider75.setMinimum(0);
		slider75.setMaximum(100);
		
		panel76 = new JPanel();
		panel76.setLocation(new IntPoint(0, 189));
		panel76.setSize(new IntDimension(255, 14));
		var layout16:EmptyLayout = new EmptyLayout();
		panel76.setLayout(layout16);
		
		label77 = new JLabel();
		label77.setLocation(new IntPoint(0, 0));
		label77.setSize(new IntDimension(50, 19));
		label77.setConstraints("West");
		label77.setText("角度(45)");
		
		slider78 = new JSlider();
		slider78.setLocation(new IntPoint(60, 4));
		slider78.setSize(new IntDimension(200, 19));
		slider78.setConstraints("East");
		slider78.setValue(0);
		slider78.setExtent(0);
		slider78.setMinimum(0);
		slider78.setMaximum(100);
		
		panel79 = new JPanel();
		panel79.setLocation(new IntPoint(0, 216));
		panel79.setSize(new IntDimension(265, 19));
		var layout17:EmptyLayout = new EmptyLayout();
		panel79.setLayout(layout17);
		
		label80 = new JLabel();
		label80.setLocation(new IntPoint(5, 5));
		label80.setSize(new IntDimension(43, 19));
		label80.setConstraints("West");
		label80.setText("距离(1)");
		
		slider81 = new JSlider();
		slider81.setLocation(new IntPoint(60, 4));
		slider81.setSize(new IntDimension(200, 14));
		slider81.setConstraints("East");
		slider81.setValue(0);
		slider81.setExtent(0);
		slider81.setMinimum(0);
		slider81.setMaximum(100);
		
		//component layoution
		append(panel28);
		
		panel28.append(panel25);
		panel28.append(textarea27);
		panel28.append(panel29);
		panel28.append(panel32);
		panel28.append(spacer68);
		panel28.append(panel82);
		
		panel25.append(togglebutton23);
		panel25.append(togglebutton26);
		
		panel29.append(combobox30);
		panel29.append(button31);
		
		panel32.append(panel46);
		panel32.append(panel47);
		
		panel46.append(togglebutton37);
		panel46.append(togglebutton38);
		panel46.append(togglebutton39);
		panel46.append(togglebutton40);
		panel46.append(togglebutton41);
		panel46.append(togglebutton42);
		
		panel47.append(togglebutton43);
		panel47.append(togglebutton44);
		
		panel82.append(panel48);
		panel82.append(panel52);
		panel82.append(panel57);
		panel82.append(panel60);
		panel82.append(panel63);
		panel82.append(panel70);
		panel82.append(panel73);
		panel82.append(panel76);
		panel82.append(panel79);
		
		panel48.append(label49);
		panel48.append(slider50);
		
		panel52.append(label53);
		panel52.append(button54);
		panel52.append(separator56);
		
		panel57.append(label58);
		panel57.append(slider59);
		
		panel60.append(label61);
		panel60.append(slider62);
		
		panel63.append(label64);
		panel63.append(button65);
		panel63.append(separator66);
		
		panel70.append(label71);
		panel70.append(slider72);
		
		panel73.append(label74);
		panel73.append(slider75);
		
		panel76.append(label77);
		panel76.append(slider78);
		
		panel79.append(label80);
		panel79.append(slider81);
		
	}
	
	//_________getters_________
	
	
	
	public function getTogglebutton23():JToggleButton{
		return togglebutton23;
	}
	
	public function getTogglebutton26():JToggleButton{
		return togglebutton26;
	}
	
	public function getTextarea27():JTextArea{
		return textarea27;
	}
	
	
	public function getCombobox30():JComboBox{
		return combobox30;
	}
	
	public function getButton31():JButton{
		return button31;
	}
	
	
	
	public function getTogglebutton37():JToggleButton{
		return togglebutton37;
	}
	
	public function getTogglebutton38():JToggleButton{
		return togglebutton38;
	}
	
	public function getTogglebutton39():JToggleButton{
		return togglebutton39;
	}
	
	public function getTogglebutton40():JToggleButton{
		return togglebutton40;
	}
	
	public function getTogglebutton41():JToggleButton{
		return togglebutton41;
	}
	
	public function getTogglebutton42():JToggleButton{
		return togglebutton42;
	}
	
	
	public function getTogglebutton43():JToggleButton{
		return togglebutton43;
	}
	
	public function getTogglebutton44():JToggleButton{
		return togglebutton44;
	}
	
	
	
	
	
	public function getSlider50():JSlider{
		return slider50;
	}
	
	
	
	public function getButton54():JButton{
		return button54;
	}
	
	
	
	
	public function getSlider59():JSlider{
		return slider59;
	}
	
	
	
	public function getSlider62():JSlider{
		return slider62;
	}
	
	
	
	public function getButton65():JButton{
		return button65;
	}
	
	
	
	
	public function getSlider72():JSlider{
		return slider72;
	}
	
	
	
	public function getSlider75():JSlider{
		return slider75;
	}
	
	
	
	public function getSlider78():JSlider{
		return slider78;
	}
	
	
	
	public function getSlider81():JSlider{
		return slider81;
	}
	
	
}
}
