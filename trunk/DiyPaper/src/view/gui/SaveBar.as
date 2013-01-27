package view.gui{

import org.aswing.*;
import org.aswing.border.*;
import org.aswing.geom.*;
import org.aswing.colorchooser.*;
import org.aswing.ext.*;

/**
 * SaveBar
 */
public class SaveBar extends JToolBar{
	
	//members define
	private var btnPreview:JButton;
	private var btnLink:JButton;
	
	/**
	 * SaveBar Constructor
	 */
	public function SaveBar(){
		//component creation
		setOpaque(true);
		setSize(new IntDimension(127, 26));
		
		btnPreview = new JButton();
		btnPreview.setSize(new IntDimension(67, 26));
		btnPreview.setText("保存 \ 预览");
		
		btnLink = new JButton();
		btnLink.setLocation(new IntPoint(69, 0));
		btnLink.setSize(new IntDimension(58, 26));
		btnLink.setText("添加链接");
		
		//component layoution
		append(btnPreview);
		append(btnLink);
		
	}
	
	//_________getters_________
	
	public function getBtnPreview():JButton{
		return btnPreview;
	}
	
	public function getBtnLink():JButton{
		return btnLink;
	}
	
	
}
}
