<?php
if (!function_exists("generateRandomNumber")) {
    function generateRandomNumber($id, $start, $end, $unique = 1): int
    {
        // Get the current date
        $currentDate = date('Ymd');

        // Concatenate the date and ID to generate a unique seed
        $seed = hexdec(substr(md5($currentDate . $id . $unique), 0, 8));

        // Seed the random number generator
        mt_srand($seed);

        // Generate a random number between 300 and 600
        return mt_rand($start, $end);
    }
}

$begin  = $begin  ?: 100;
$end    = $end  ?: 1000;
$id     = $id ?: $modx->resource->id ?: 0;
$unique = $unique ?: 1;

return generateRandomNumber($id, $begin, $end, $unique);
