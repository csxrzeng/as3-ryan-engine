<?php
$fontname = rawurldecode($_GET["font"]);
$ss = "中文abc";
$ss = iconv("gb2312", "utf-8", $ss);
$text = $ss; #rawurldecode($_GET["text"]);
$size = 50;
$f = new swffont( "./fonts/$fontname.fdb" );
$t = new swftext();
$t->setfont( $f );
$t->setcolor( 0, 0, 0 );
$t->setheight( $size );
$t->addutf8string( $text );

$m = new swfmovie();
$m->setdimension( 500, $size );
$i = $m->add( $t );
#$i->setwidth($t->getwidth($text) + 6);
#$i->setheight($size);
$i->moveto(5, $size - 6);

#$m->save("hello.swf");
header('Content-type: application/x-shockwave-flash');
$m->output();
?>
