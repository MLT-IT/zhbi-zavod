<?php
$count = (int)$modx->getOption('count', $scriptProperties, 0);
$startIndex = (int)$modx->getOption('startIndex', $scriptProperties, 0);
$output = '';

for ($i = 1; $i <= $count; $i++) {
    $output .= '<article class="other-products similar-samples__products-slider" 
                     id="other-products" 
                     data-opened-element="similar-' . ($startIndex + $i) . '">
                </article>';
}

return $output;
