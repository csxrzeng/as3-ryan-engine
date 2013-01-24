package view{

import org.aswing.*;
import org.aswing.border.*;
import org.aswing.geom.*;
import org.aswing.colorchooser.*;
import org.aswing.ext.*;

/**
 * AddImagePane
 */
public class AddImagePane extends JPanel{
	
	//members define
	private var panel14:JPanel;
	private var btnRemote:JLabelButton;
	private var label9:JLabel;
	private var btnLocal:JLabelButton;
	private var paneRemote:JPanel;
	private var txtRemote:JTextArea;
	private var btnDownload:JButton;
	private var paneLocal:JPanel;
	private var txtLocal:JTextArea;
	private var btnUpload:JButton;
	private var spacer18:JSpacer;
	private var spacer19:JSpacer;
	
	/**
	 * AddImagePane Constructor
	 */
	public function AddImagePane(){
		//component creation
		setSize(new IntDimension(400, 122));
		var border0:EmptyBorder = new EmptyBorder();
		border0.setTop(5);
		border0.setLeft(5);
		border0.setBottom(5);
		border0.setRight(5);
		setBorder(border0);
		var layout1:BorderLayout = new BorderLayout();
		setLayout(layout1);
		
		panel14 = new JPanel();
		panel14.setLocation(new IntPoint(5, 5));
		panel14.setSize(new IntDimension(400, 29));
		panel14.setConstraints("North");
		
		btnRemote = new JLabelButton();
		btnRemote.setLocation(new IntPoint(5, 5));
		btnRemote.setSize(new IntDimension(76, 19));
		btnRemote.setText("粘贴图片网址");
		
		label9 = new JLabel();
		label9.setLocation(new IntPoint(86, 5));
		label9.setSize(new IntDimension(31, 19));
		label9.setText(" | ");
		
		btnLocal = new JLabelButton();
		btnLocal.setLocation(new IntPoint(119, 5));
		btnLocal.setSize(new IntDimension(31, 19));
		btnLocal.setText("上传图片");
		
		paneRemote = new JPanel();
		paneRemote.setLocation(new IntPoint(20, 34));
		paneRemote.setSize(new IntDimension(360, 83));
		paneRemote.setConstraints("Center");
		var layout2:EmptyLayout = new EmptyLayout();
		paneRemote.setLayout(layout2);
		
		txtRemote = new JTextArea();
		txtRemote.setLocation(new IntPoint(5, 10));
		txtRemote.setSize(new IntDimension(350, 22));
		txtRemote.setConstraints("North");
		txtRemote.setEditable(true);
		
		btnDownload = new JButton();
		btnDownload.setLocation(new IntPoint(140, 45));
		btnDownload.setSize(new IntDimension(80, 24));
		btnDownload.setText("加载图片");
		
		paneLocal = new JPanel();
		paneLocal.setLocation(new IntPoint(20, 34));
		paneLocal.setSize(new IntDimension(360, 83));
		paneLocal.setConstraints("Center");
		var layout3:EmptyLayout = new EmptyLayout();
		paneLocal.setLayout(layout3);
		
		txtLocal = new JTextArea();
		txtLocal.setEnabled(false);
		txtLocal.setLocation(new IntPoint(5, 10));
		txtLocal.setSize(new IntDimension(350, 22));
		
		btnUpload = new JButton();
		btnUpload.setLocation(new IntPoint(140, 45));
		btnUpload.setSize(new IntDimension(80, 24));
		btnUpload.setText("选择图片");
		
		spacer18 = new JSpacer();
		spacer18.setLocation(new IntPoint(0, 29));
		spacer18.setSize(new IntDimension(15, 93));
		spacer18.setConstraints("West");
		var border4:EmptyBorder = new EmptyBorder();
		border4.setRight(15);
		spacer18.setBorder(border4);
		
		spacer19 = new JSpacer();
		spacer19.setLocation(new IntPoint(380, 34));
		spacer19.setSize(new IntDimension(15, 83));
		spacer19.setConstraints("East");
		var border5:EmptyBorder = new EmptyBorder();
		border5.setLeft(15);
		spacer19.setBorder(border5);
		
		//component layoution
		append(panel14);
		append(paneRemote);
		append(paneLocal);
		append(spacer18);
		append(spacer19);
		
		panel14.append(btnRemote);
		panel14.append(label9);
		panel14.append(btnLocal);
		
		paneRemote.append(txtRemote);
		paneRemote.append(btnDownload);
		
		paneLocal.append(txtLocal);
		paneLocal.append(btnUpload);
		
	}
	
	//_________getters_________
	
	
	public function getBtnRemote():JLabelButton{
		return btnRemote;
	}
	
	
	public function getBtnLocal():JLabelButton{
		return btnLocal;
	}
	
	public function getPaneRemote():JPanel{
		return paneRemote;
	}
	
	public function getTxtRemote():JTextArea{
		return txtRemote;
	}
	
	public function getBtnDownload():JButton{
		return btnDownload;
	}
	
	public function getPaneLocal():JPanel{
		return paneLocal;
	}
	
	public function getTxtLocal():JTextArea{
		return txtLocal;
	}
	
	public function getBtnUpload():JButton{
		return btnUpload;
	}
	
	
	
	
}
}
