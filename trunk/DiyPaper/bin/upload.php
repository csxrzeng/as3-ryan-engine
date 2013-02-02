<?php 
/***************************************** 
Title :文件上传详解 
Author:leehui1983(辉老大) 
Finish Date :2006-12-28 
*****************************************/ 
$uploaddir = "./images/";//设置文件保存目录 注意包含/ 
$type=array("jpg", "png");//设置允许上传文件的类型 

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
$a=strtolower(fileext($_FILES['Filedata']['name'])); 
//判断文件类型 
if(!in_array($a, $type)) 
{ 
	$text=implode(",", $type); 
	echo "result=0&desc=您只能上传以下类型文件: ", $text; 
} 
//生成目标文件的文件名 
else
{
	$filename = explode(".", $_FILES['Filedata']['name']);
	do
	{
		$filename[0] = random(15); //设置随机数长度
		$name = implode(".", $filename);
		$uploadfile = $uploaddir.$name; 
	}while(file_exists($uploadfile));

	if (move_uploaded_file($_FILES['Filedata']['tmp_name'], $uploadfile))
	{
		echo "result=1&file=", $name;
	}
	else
	{
		echo "result=0";
	}
}
?>