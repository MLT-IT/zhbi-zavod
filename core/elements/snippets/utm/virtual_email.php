<?php

if ($modx->context->key === 'gazoclone') {
    echo "mail@gazosilikatstroy.ru";
} else {
    $email = $modx->getOption('email');
    // пробую UTM, если есть перезаписываю
    $utmEmail = $modx->runSnippet('utm', ['val' => 'email']);

    if ($utmEmail) {
        $email = $utmEmail;
    }
    //

    $host = $_SERVER['HTTP_HOST'];
    $domain_seq = explode('.', $host);
    $subdomain = $domain_seq[0];
    $rev = array_reverse($domain_seq);
    if ($subdomain == 'msk') {
        if (count($domain_seq) > 3) {
            $email = 'msk@' . $rev[2] . "." . $rev[1] . "." . $rev[0];
        } else {
            $email = 'msk@' . $rev[1] . "." . $rev[0];
        }
    }

    echo $email;
}
