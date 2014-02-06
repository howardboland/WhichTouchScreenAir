<?php

Class Result
{
    var $result;
    var $message;
    var $sql;

    function Result( $r, $m, $s )
    {
        $this->result   = $r;
        $this->message  = $m;
        $this->sql      = $s;

    }

}

class Cipher
{

    private $securekey;
    private $iv_size;

    function __construct($textkey)
    {
        $this->iv_size = mcrypt_get_iv_size(MCRYPT_RIJNDAEL_128, MCRYPT_MODE_CBC);
        $this->securekey = hash('sha256', $textkey, TRUE);
    }

    function encrypt($input)
    {
        $iv = mcrypt_create_iv($this->iv_size);
        return base64_encode($iv . mcrypt_encrypt(MCRYPT_RIJNDAEL_128, $this->securekey, $input, MCRYPT_MODE_CBC, $iv));
    }

    function decrypt($input)
    {
        $input = base64_decode($input);
        $iv = substr($input, 0, $this->iv_size);
        $cipher = substr($input, $this->iv_size);
        return trim(mcrypt_decrypt(MCRYPT_RIJNDAEL_128, $this->securekey, $cipher, MCRYPT_MODE_CBC, $iv));
    }


}

function raw_accesskey()
{
  return "KDLSO-533K4-23KDK-2KSLK-MMDK33-KD0D92";
}
function encryptionString()
{
  return "dhkuvdegnhju";
}
function encoded_accesskey()
{
  $c = new Cipher( encryptionString());
  return $c->encrypt(raw_accesskey());
}
function check_access( $str )
{
  $c = new Cipher( encryptionString());

  return $c->decrypt( $str ) == raw_accesskey();
}
function access()
{
  $headers = apache_request_headers();
  foreach ($headers as $header => $value) {
    if ($header=="accesskey")
    {
      if (check_access($value))
      {
        return 1;
      }
    }
    //  echo "$header: $value <br />\n";
  }
  return 0;
}






if (!function_exists("GetSQLValueString")) {
function GetSQLValueString($theValue, $theType, $theDefinedValue = "", $theNotDefinedValue = "") 
{
  if (PHP_VERSION < 6) {
    $theValue = get_magic_quotes_gpc() ? stripslashes($theValue) : $theValue;
  }

  $theValue = function_exists("mysql_real_escape_string") ? mysql_real_escape_string($theValue) : mysql_escape_string($theValue);

  switch ($theType) {
    case "text":
      $theValue = ($theValue != "") ? "'" . $theValue . "'" : "NULL";
      break;    
    case "long":
    case "int":
      $theValue = ($theValue != "") ? intval($theValue) : "NULL";
      break;
    case "double":
      $theValue = ($theValue != "") ? doubleval($theValue) : "NULL";
      break;
    case "date":
      $theValue = ($theValue != "") ? "'" . $theValue . "'" : "NULL";
      break;
    case "defined":
      $theValue = ($theValue != "") ? $theDefinedValue : $theNotDefinedValue;
      break;
  }
  return $theValue;
}
}


?>