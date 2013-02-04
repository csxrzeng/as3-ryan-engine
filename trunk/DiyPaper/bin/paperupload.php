<?php 
/***************************************** 
Title :文件上传详解 
Author:leehui1983(辉老大) 
Finish Date :2006-12-28 
*****************************************/ 
$uploaddir = "./papers/";//设置文件保存目录 注意包含/
$xmldir = "./xmls/";
$type = array("jpg", "png");//设置允许上传文件的类型 

//获取文件后缀名函数 
function fileext($filename) 
{ 
	return substr(strrchr($filename, '.'), 1); 
} 
//生成随机文件名函数 
function random($length) 
{ 
	$hash = '';// 'CR-'; 
	$chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz'; 
	$max = strlen($chars) - 1; 
	mt_srand((double)microtime() * 1000000); 
	for($i = 0; $i < $length; $i++) 
	{ 
		$hash .= $chars[mt_rand(0, $max)]; 
	} 
	return $hash; 
} 
$xmlstr =  $GLOBALS[HTTP_RAW_POST_DATA];
if(empty($xmlstr)) $xmlstr = file_get_contents('php://input');
if (empty($xmlstr))
{
	echo "result=0&desc=没有图片数据";
}
else
{
	$filename = "";
	do
	{
		$filename = random(15); //设置随机数长度
		$name = $filename.".jpg";
		$uploadfile = $uploaddir.$name; 
	}while(file_exists($uploadfile));

	$jpg = $xmlstr;//得到post过来的二进制原始数据
	$file = fopen($uploadfile, "w");//打开文件准备写入
	fwrite($file, $jpg);//写入
	fclose($file);//关闭

	echo "result=1&file=", $name;
}
?>