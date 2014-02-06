<?php require_once('Connections/functions.php'); ?>
<?php
Class Upload
{
	var $result;
	var $message;
	var $name;
	var $time;
	var $path;
	var $size;
	
	function Upload( $target_path )
	{


		if(!$_FILES['photo']['name'])
		{
			$this->name = -1;
			$this->time = time();
			$this->message = "No file";
			return;	
		}
		
		if($_FILES['photo']['error'])
		{
			$this->result = -1;
			$this->name = $_FILES['photo']['name'];
			$this->size = $_FILES['photo']['size'];
			$this->time = time();
			$this->message = "An error occured: "+$_FILES['photo']['error'];
			return;
		}
		if($_FILES['photo']['size'] > (1024000)) //can't be larger than 1 MB
		{
			$this->result = -1;
			$this->name = $_FILES['photo']['name'];
			$this->size = $_FILES['photo']['size'];
			$this->time = time();
			$this->message = "File size too large (max. size is 1 mb)";
			return;
		}
			
		$filename = explode(".", $_FILES['photo']['name'])[0];
		$ext = explode(".", $_FILES['photo']['name'])[1];
		$filename = $filename.uniqid().".".$ext;

		$target_path = $target_path . basename( $filename  ); 
		move_uploaded_file($_FILES['photo']['tmp_name'], $target_path);

		$this->result = 1;
		$this->message = "Success";
		$this->name = $_FILES['photo']['name'];
		$this->time = time();
		$this->path = $target_path;
		$this->size = $_FILES['photo']['size'];
		
	}

}
$upload = new Upload( "../resources/uploads/" );
echo json_encode( $upload );
?>