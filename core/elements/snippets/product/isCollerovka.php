<?php
foreach ($modx->getIterator('msProductOption', array('product_id' => $id)) as $opt) {
    if($opt->get('key') == 'vozmozhnost-kolerovki' && $opt->get('value') == 'да')
    {
        return true;
    }
}
return  false;