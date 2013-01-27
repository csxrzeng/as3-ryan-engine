package view.gui{

import org.aswing.*;
import org.aswing.border.*;
import org.aswing.geom.*;
import org.aswing.colorchooser.*;
import org.aswing.ext.*;

/**
 * SaveBar
 */
public class SaveBar extends JPanel{
	
	//members define
	private var toolbar14:JToolBar;
	protected var btnPreview:JButton;
	protected var btnLink:JButton;
	
	/**
	 * SaveBar Constructor
	 */
	public function SaveBar(){
		//component creation
		setSize(new IntDimension(150, 36));
		var border0:EmptyBorder = new EmptyBorder();
		border0.setLeft(10);
		setBorder(border0);
		
		toolbar14 = new JToolBar();
		toolbar14.setLocation(new IntPoint(15, 5));
		toolbar14.setSize(new IntDimension(130, 26));
		toolbar14.setOrientation(AsWingConstants.HORIZONTAL);
		toolbar14.setGap(5);
		
		btnPreview = new JButton();
		btnPreview.setSize(new IntDimension(70, 26));
		btnPreview.setText(" 保存 / 预览");
		
		btnLink = new JButton();
		btnLink.setLocation(new IntPoint(72, 0));
		btnLink.setSize(new IntDimension(58, 26));
		btnLink.setText("添加链接");
		
		//component layoution
		append(toolbar14);
		
		toolbar14.append(btnPreview);
		toolbar14.append(btnLink);
		
	}
	
	//_________getters_________
	
	
	
	
	
}
}
