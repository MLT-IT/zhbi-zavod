<?php

namespace RequestLimiter;

//error_reporting(E_ALL);
//ini_set('display_errors', 1);

use DateTime;
use stdClass;
use Throwable;

$maxLogSize = 1048576; //Максимальный размер лога в байтах (1Гб)
//$maxLogSize = 10;
$retryDelay = 5; //Сколько секунд отправить в заголовок Retry-After
$limitWindow = 5; //время в секундах, в течении которого считаются запросы. Счетчик сбрасывается при превышении
$requestLimit = 20; //Сколько запросов разрешено в $limitWindow до начала ограничений
$gcTimeout = 86400; //С какой периодичностью в секундах собирать мусор в сессиях (сутки)
$whiteList = ['mozilla/', 'gecko/', 'Chrome/', 'AppleWebKit/', 'Safari/', 'OPR/', 'firefox/']; //Регистр не важен


function cleanAccessData(&$data) {
  global $limitWindow;
  $now = time();
  foreach($data as $ip => $access) {
    $d = (new DateTime($access->date))->getTimestamp();
    if(($now - $d) > $limitWindow) {
      unset($data->$ip);
    }
  }
}

//Если время после последнего запроса > лимита, то удаляем запись из сессии, считаем кол-во запросов заново
function validateRecord(&$record) {
  global $limitWindow;
  if(!$record)return;
  $now = time();
  $d = (new DateTime($record->date))->getTimestamp();
  if(($now - $d) > $limitWindow) {
    $record = false;
  }
}

function gc() {
  global $gcTimeout;
  $path = __DIR__."/gc_start.txt";
  if(!file_exists($path))$flags = 'w';
  else $flags = 'r+';
  $h = fopen($path, $flags);
  try {
    if(!flock($h, LOCK_EX))return;
    $stamp = intval(fread($h, 10000));
    //echo $stamp."\n";
    //echo time()."\n";
    //echo time() - $stamp;
    if(time() - $stamp > $gcTimeout) {
      ftruncate($h, 0);
      rewind($h);
      $s = strval(time());
      fwrite($h, $s);
      fflush($h);
      //print_r('Garbage collection!');
      session_gc();
    }
  }catch(Throwable $t) {
  }finally {
    flock($h, LOCK_UN);
    fclose($h);
  }
}

function show429() {
  global $retryDelay;
  http_response_code(429);
  header("Retry-After: $retryDelay");
  header('Content-Type: application/json');
  echo json_encode([
      'error' => 'Rate Limit Exceeded',
      'message' => 'Слишком много запросов. Попробуйте позже.',
      'retry_after' => $retryDelay
  ], JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
  exit;
}

function inWhiteList() {
  global $whiteList;
  $ua = $_SERVER['HTTP_USER_AGENT'];
  $inWhiteList = false;
  foreach($whiteList as $s) {
    if(stripos($ua, $s) !== false){
      $inWhiteList = true;
      break;
    }
  }
  return $inWhiteList;
}

function log($msg) {
  global $maxLogSize;
  $path = __DIR__."/log.txt";
  $oldPath = __DIR__."/log.old.txt";
  if(filesize($path) > $maxLogSize) {
    rename($path, $oldPath);
  }
  $h = fopen($path, 'a');
  try {
    if(!flock($h, LOCK_EX))return;
    fputs($h, $msg."\n");
    fflush($h);
  }catch(Throwable $t) {
    //echo $t->getMessage().". ".$t->getTraceAsString();
  }finally {
    flock($h, LOCK_UN);
    fclose($h);
  }
}

function doJob() {
  global $requestLimit;
  $old_gc = ini_get('session.gc_probability');
  try {
    if(inWhiteList())return; // $inWhiteList должно быть  
    ini_set('session.gc_probability', 0);
    session_start();
    if($_SESSION['requestLimiter'] && $_SESSION['requestLimiter']->record)$record = $_SESSION['requestLimiter']->record;
    else $record = false;
    validateRecord($record);
    //echo $record; 
    //$lifetime = $_SESSION['requestLimiter']['lifetime'];
    if($record) {
      if($record->requests > $requestLimit) {
        $record->date = date("Y-m-d H:i:s", time());
        ++$record->requests;
        $_SESSION['requestLimiter']->record = $record;
        //print_r($record);
        //echo "<pre>";
        //print_r($_SERVER);
        //echo "</pre>";
        $s = sprintf("[%s]: Превышено кол-во запросов. ip: %s, Запросов: %d/%d, UserAgent: %s, Путь: %s", date("Y-m-d H:i:s", time()), $_SERVER['REMOTE_ADDR'], $record->requests, $requestLimit, $_SERVER['HTTP_USER_AGENT'], $_SERVER['REQUEST_URI']);
        log($s);
        show429();
      }
    }else {
      $record = new stdClass;
      $record->date = date("Y-m-d H:i:s", time());
      $record->requests = 0;
      if(!$_SESSION['requestLimiter'])$_SESSION['requestLimiter'] = new stdClass;
    }
    @++$record->requests;
    $_SESSION['requestLimiter']->record = $record;
    //Раскомментировать на боевом:
    //$pid = pcntl_fork();
    //if($pid){
//      pcntl_wait($status);
    //}else {
      gc();
//    }
  }catch(Throwable $t) {
    //echo $t->getMessage()."\n".$t->getLine()."\n".$t->getTraceAsString();
  }finally {
    session_write_close();
    ini_set('session.gc_probability', $old_gc);
  }
  
  /*
  http_response_code(200);
  echo '<pre>';
  echo '<h1>200 OK</h1>';
  print_r($_SESSION);
  echo '</pre>';
  */
  //log(ini_get('session.save_path'));
  //exit();
}


doJob();
