<?php
$file = MODX_ASSETS_PATH . 'template/json/collerovka.json';
$jsonColor = file_get_contents($file);

$colorGroups = json_decode($jsonColor, true);

foreach ($colorGroups as $colorGroup)
{
    if(array_key_exists('items', $colorGroup))
    {
        foreach ($colorGroup['items'] as $color)
        {
            if($color['title'] == $colorName)
            {
                return $color;
            }
        }
    }
}

return null;