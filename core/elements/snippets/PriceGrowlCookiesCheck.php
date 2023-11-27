<?

if (isset($_COOKIE['price_growl'])) {
	return false; 
}else{
    setcookie('price_growl', '1', array(
        'expires' => time() + 600, //10 минут
        'path' => '/',
    ));
    return true; 
}