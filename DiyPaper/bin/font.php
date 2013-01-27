<?php
$f = new swffont( "_sans" );

$t = new swftextfield();
$t->setfont( $f );
$t->setcolor( 0, 0, 0 );
$t->setheight( 200 );
$t->addstring( "hello world" );

$m = new swfmovie();
$m->setdimension( 2500, 800 );
$m->add( $t );

$m->save( "hello.swf" );
?>
