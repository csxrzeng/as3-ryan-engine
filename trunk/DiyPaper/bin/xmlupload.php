<?php 
/***************************************** 
Title :文件上传详解 
Author:leehui1983(辉老大) 
Finish Date :2006-12-28 
*****************************************/ 
$uploaddir = "./papers/";//设置文件保存目录 注意包含/
$xmldir = "./xmls/";
$type = array("jpg", "png");//设置允许上传文件的类型 

$filename = urldecode($_POST["file"]);
$xmlstr =  urldecode($_POST["xml"]);
if (empty($xmlstr))
{
	echo "result=0&desc=数据错误";
}
else if (empty($filename))
{
	echo "result=0&desc=文件名错误";
}
else
{
	$uploadfile = $xmldir.$filename;
	$jpg = $xmlstr;//得到post过来的二进制原始数据
	$file = fopen($uploadfile, "w");//打开文件准备写入
	fwrite($file, $jpg);//写入
	fclose($file);//关闭

	echo "result=1&file=", $filename;
}
?>