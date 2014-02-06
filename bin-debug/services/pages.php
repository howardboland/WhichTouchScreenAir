<?php require_once('Connections/localhost.php'); ?>
<?php require_once('Connections/functions.php'); ?>
<?php

$counter = 0;
Class Page
{
	var $id;
	var $name;
	var $title;
	var $body;

	function Page( $name, $title, $body )
	{
		global $counter;
		$this->id = $counter;
		$this->name = $name;
		$this->title = $title;
		$this->body = $body;
		$counter++;

	}


}

$publicAccess 	= array( new Page("home", "Home", ""),
					new Page("login", "Login", "") );

$fullAccess 	= array( new Page("home", "Home", ""),
					new Page("news", "News", ""),
					new Page("assets", "Assets", ""),
					new Page("logout", "Login", "") );

function hasAccess()
{
	return true;
}
function getPages()
{
	global $publicAccess, $fullAccess;
	if (hasAccess())
	{
		return $fullAccess;
	} else 
	{
		return $publicAccess;
	}
	
}
?>


<?php

//header('Content-Type: text/xml');

echo json_encode( getPages() );

?>