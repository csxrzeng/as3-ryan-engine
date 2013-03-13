/**
 * ...
 * @author xr.zeng
 */

function listJpgs()
{
	//var url = fl.browseForFolderURL();
	var url = fl.scriptURI;
	var idx = url.lastIndexOf("/");
	url = url.slice(0, idx);
	if (!url)
	{
		return;
	}
	fl.outputPanel.clear();
	fl.trace(url);
	var xml = <assets></assets>;
	var files = FLfile.listFolder(url + "/assets/*.jpg", "files");
	for (var i = 0; i < files.length; ++i)
	{
		var file = files[i];
		var index = file.indexOf(".");
		var str = file.slice(0, index);
		if (FLfile.exists(url + "/assets/" + str + ".swf"))
		{
			xml.appendChild(<file>{str}</file>);
		}
	}
	fl.trace(xml);
	if (FLfile.write(url + "/assetstemp.xml", xml))
	{
		fl.trace("success");
	}
}
listJpgs();