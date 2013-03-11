package view.gui{

import org.aswing.*;
import org.aswing.border.*;
import org.aswing.geom.*;
import org.aswing.colorchooser.*;
import org.aswing.ext.*;

/**
 * LoadingPane
 */
public class LoadingPane extends JPanel{
	
	//members define
	private var panel3:JPanel;
	public var progressBar:JProgressBar;
	public var label:JLabel;
	
	/**
	 * LoadingPane Constructor
	 */
	public function LoadingPane(){
		//component creation
		setSize(new IntDimension(285, 440));
		setPreferredSize(new IntDimension(285, 440));
		var layout0:CenterLayout = new CenterLayout();
		setLayout(layout0);
		
		panel3 = new JPanel();
		panel3.setLocation(new IntPoint(150, 182));
		panel3.setSize(new IntDimension(100, 35));
		panel3.setConstraints("Center");
		var layout1:SoftBoxLayout = new SoftBoxLayout();
		layout1.setAxis(AsWingConstants.VERTICAL);
		layout1.setAlign(AsWingConstants.CENTER);
		layout1.setGap(5);
		panel3.setLayout(layout1);
		
		progressBar = new JProgressBar();
		progressBar.setLocation(new IntPoint(139, 161));
		progressBar.setSize(new IntDimension(200, 11));
		progressBar.setPreferredSize(new IntDimension(200, 11));
		progressBar.setConstraints("Center");
		progressBar.setValue(0);
		progressBar.setMinimum(0);
		progressBar.setMaximum(100);
		
		label = new JLabel();
		label.setText("正在加载字体：1%");
		
		//component layoution
		append(panel3);
		
		panel3.append(progressBar);
		panel3.append(label);
		
	}
	
	//_________getters_________
	
	
	public function getProgressBar():JProgressBar{
		return progressBar;
	}
	
	
	
}
}
