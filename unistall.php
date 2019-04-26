<?php

unlink( __DIR__ . '/shell.sh');
unlink( __DIR__ . '/conf.php');
unlink( __DIR__ . '/../master.zip' );
Delete( __DIR__ . '/../Linux-master' );

function Delete($path)
{
    if (is_dir($path) === true)
    {
        $files = array_diff(scandir($path), array('.', '..'));

        foreach ($files as $file)
        {
            Delete(realpath($path) . '/' . $file);
        }

        return rmdir($path);
    }

    else if (is_file($path) === true)
    {
        return unlink($path);
    }

    return false;
}
