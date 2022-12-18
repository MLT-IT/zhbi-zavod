<?php

if (empty($path)) {
    return false;
}

return file_exists($_SERVER['DOCUMENT_ROOT'] . $path);
