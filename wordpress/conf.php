<?php

$pathNginxConf = '/etc/nginx/nginx.conf';

$nginxConf =  file_get_contents( $pathNginxConf );
$newNginxConf = str_replace('user www-data;', 'user wpuser;', $nginxConf);
$fd = fopen( $pathNginxConf, 'w') or die("не удалось создать файл");
fwrite($fd, $newNginxConf);
fclose($fd);

$pathPhpConf = '/etc/php/7.2/fpm/pool.d/www.conf';

$phpConf =  file_get_contents( $pathPhpConf );
$newPhpConf = str_replace('user = www-data', 'user = wpuser', $phpConf);
$fd = fopen( $pathPhpConf, 'w') or die("не удалось создать файл");
fwrite($fd, $newPhpConf);
fclose($fd);
