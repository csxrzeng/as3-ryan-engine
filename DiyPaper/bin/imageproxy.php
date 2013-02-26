<?php
$imgurl = $_GET["imgurl"];
if ($imgurl)
{
	if (function_exists('file_get_contents'))
	{
		echo $contents = file_get_contents($imgurl);
	}
	else if (function_exists('curl_init'))
	{
		$ch=curl_init(); 
		curl_setopt($ch, CURLOPT_URL, $imgurl); 
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 
		echo $contents = curl_exec($ch); 
		curl_close($ch); 
	}
}
?>