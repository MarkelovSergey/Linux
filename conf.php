<?php

$path = '/etc/php/7.2/fpm/php.ini';
$ini =  file_get_contents( $path );
$newIni = str_replace(';cgi.fix_pathinfo=1', 'cgi.fix_pathinfo=0', $ini);

$fd = fopen( $path, 'w') or die("не удалось создать файл");
$str = $newIni;
fwrite($fd, $str);
fclose($fd);
