<?php require_once('Connections/localhost.php'); ?>
<?php require_once('Connections/functions.php'); ?>
<?php
Class AssetTemplate
{
	var $id;
	var $name;
	var $source;

	function AssetTemplate( $row )
	{
		$this->id = $row["id"];
		$this->name = isset($row["name"]) ? $row["name"] : NULL;
		$this->source = isset($row["source"]) ? $row["source"] : NULL;
	}
}

Class AssetType
{
	var $id;
	var $name;

	function AssetType( $row )
	{
		$this->id = $row["id"];
		$this->name = isset($row["name"]) ? $row["name"] : NULL;
	}
}

Class Content
{
	var $id;
	var $header;
	var $title;
	var $body;
	var $image_1;
	var $image_2;
	var $buttonText;
	var $weburl;


	function Content( $row )
	{
		$this->id = $row["id"];
		$this->header = isset($row["header"]) ? $row["header"] : NULL;
		$this->title = isset($row["title"]) ? $row["title"] : NULL;
		$this->body = isset($row["body"]) ? $row["body"] : NULL;
		$this->image_1 = isset($row["image_1"]) ? $row["image_1"] : NULL;
		$this->image_2 = isset($row["image_2"]) ? $row["image_2"] : NULL;
		$this->buttonText = isset($row["buttonText"]) ? $row["buttonText"] : NULL;
		$this->weburl = isset($row["weburl"]) ? $row["weburl"] : NULL;
	}
}

Class Asset
{
	var $id;
	var $pid;
	var $typeid;
	var $contentid;
	var $templateid;
	var $name;
	var $public;
	var $types;
	var $source;

	function Asset( $row )
	{
		$this->id = $row["id"];
		$this->pid = isset($row["pid"]) ? $row["pid"] : NULL;
		$this->typeid = isset($row["typeid"]) ? $row["typeid"] : NULL;
		$this->contentid = isset($row["contentid"]) ? $row["contentid"] : NULL;
		$this->templateid = isset($row["templateid"]) ? $row["templateid"] : NULL;
		$this->source = isset($row["source"]) ? $row["source"] : NULL;
		$this->name = isset($row["name"]) ? $row["name"] : NULL;
		$this->public = isset($row["public"]) ? $row["public"] : NULL;
		$this->orderid = isset($row["orderid"]) ? $row["orderid"] : NULL;
		$this->types = getTypes();
		$this->templates = getTemplates();
		$this->content = isset($row["content"]) ? new Content($row["content"]) : ( isset($this->contentid) ? getContent( $this->contentid ) : NULL );
	}
}

function getContent($id)
{
	global $database_localhost, $localhost;
	$query = sprintf("SELECT * FROM content where id=%s", GetSQLValueString($id,"int") ) ;
	$result = mysql_query($query, $localhost) or die(mysql_error());
	$row = mysql_fetch_assoc($result);
	return new Content($row);
}

function getTypes()
{
	global $database_localhost, $localhost;
	$query = sprintf("SELECT * FROM asset_types") ;
	$result = mysql_query($query, $localhost) or die(mysql_error());
	$items = array();
	while ($row = mysql_fetch_assoc($result)) 
	{
		array_push($items, new AssetType($row));
	}
	return $items;
}
function getTemplates()
{
	global $database_localhost, $localhost;
	$query = sprintf("SELECT * FROM asset_templates") ;
	$result = mysql_query($query, $localhost) or die(mysql_error());
	$items = array();
	while ($row = mysql_fetch_assoc($result)) 
	{
		array_push($items, new AssetTemplate($row));
	}
	return $items;
}
function delete($data)
{
	global $database_localhost, $localhost;
	mysql_select_db($database_localhost, $localhost);
	$query = sprintf("DELETE FROM assets WHERE id=%s", GetSQLValueString($data->id,"int")) ;
	$message = mysql_query($query, $localhost) or die(mysql_error());
	$result = mysql_insert_id();
	return new Result( $result, $message, $query);
}
function updateContent($data)
{
	echo "taken";
	global $database_localhost, $localhost;
	echo $localhost;
	mysql_select_db($database_localhost, $localhost);
	
	$query = sprintf("UPDATE content SET header=%s, title=%s, body=%s, image_1=%s, image_2=%s, weburl=%s, buttonText=%s WHERE id=%s", GetSQLValueString($data->header,"text"),
																									GetSQLValueString($data->title,"text"),
																									GetSQLValueString($data->body,"text"),
																									GetSQLValueString($data->image_1,"text"),
																									GetSQLValueString($data->image_2,"text"),
																									GetSQLValueString($data->weburl,"text"),
																									GetSQLValueString($data->buttonText,"text"),
																									GetSQLValueString($data->id,"int")) ;
	
	$message = mysql_query($query, $localhost) or die(mysql_error());
	$result = mysql_insert_id();
	return new Result( $result, $message, $query);
}
function update($data)
{

	
	if (isset($data->content))
	{
		//$resultContent = updateContent( $data->content );	
	}
	return new Result(1, "a", "b");
	/*
	global $database_localhost, $localhost;
	mysql_select_db($database_localhost, $localhost);
	$query = sprintf("UPDATE assets SET name=%s, typeid=%s, contentid=%s, templateid=%s,source=%s,public=%s, orderid=%s WHERE id=%s", 
																									GetSQLValueString($data->name,"text"),
																									GetSQLValueString($data->typeid,"int"),
																									GetSQLValueString($data->contentid,"int"),
																									GetSQLValueString($data->templateid,"int"),
																									GetSQLValueString($data->source,"text"),
																									GetSQLValueString($data->public,"int"),
																									GetSQLValueString($data->orderid,"int"),
																									GetSQLValueString($data->id,"int")) ;
	$message = mysql_query($query, $localhost) or die(mysql_error());
	$result = mysql_insert_id();
	return new Result( $result, $message, $query);*/
}
function insert($data)
{
	global $database_localhost, $localhost;
	
	mysql_select_db($database_localhost, $localhost);
	$query = sprintf("INSERT INTO assets ( header, title, body, url, public, orderid ) VALUES (%s, %s, %s, %s, %s, %s)", 	GetSQLValueString($data->header,"text"),
																											GetSQLValueString($data->title,"text"),
																											GetSQLValueString($data->body,"text"),
																											GetSQLValueString($data->url,"text"),
																											GetSQLValueString($data->public,"int"),
																											GetSQLValueString($data->orderid,"int")) ;
	
	$message = mysql_query($query, $localhost) or die(mysql_error());
	$result = mysql_insert_id();
	return new Result( $result, $message, $query);
}
function select($id)
{
	global $database_localhost, $localhost;
	mysql_select_db($database_localhost, $localhost);
	$query = sprintf("SELECT * FROM assets where id=%s", GetSQLValueString($id, "int")) ;
	$result = mysql_query($query, $localhost) or die(mysql_error());
	return mysql_fetch_assoc($result);
}
function selectAll()
{
	global $database_localhost, $localhost;
	mysql_select_db($database_localhost, $localhost);
	$query = "SELECT * FROM assets ORDER BY orderid,id";
	$result = mysql_query($query, $localhost) or die(mysql_error());
	$assets = array();
	while ($row = mysql_fetch_assoc($result)) 
	{
		array_push($assets, new Asset($row));
	}
	
	return $assets;
}

function selectAllPublic()
{
	global $database_localhost, $localhost;
	mysql_select_db($database_localhost, $localhost);
	$query = "SELECT * FROM assets where public=1  ORDER BY orderid,id";
	$result = mysql_query($query, $localhost) or die(mysql_error());
	$assets = array();
	while ($row = mysql_fetch_assoc($result)) 
	{
		array_push($assets, new Asset($row));
	}
	
	return $assets;
	
}
function init()
{

	if (isset($_SERVER['HTTP_X_HTTP_METHOD_OVERRIDE']))
		$method = $_SERVER['HTTP_X_HTTP_METHOD_OVERRIDE'];
	$values = json_decode(file_get_contents('php://input'), true);
	if ( isset($method))
	{
		if (isset($values))
		{
			$values = new Asset( $values );	

		} else {
			$values = new Asset( $_GET );
		}
		
		
		
		switch ($method) {
			case "PUT":
			
				if ($values->id>0) //id exists - run update
				{

					//return update($values);

				} else //id does not exist - insert
				{
					return insert($values);
				}
				break;
			case "DELETE":
				if ($values->id>0) //id exists - run update
				{
					return delete($values);
				}
				echo "DELETE";
			break;
			default:
				//default output all public assets
				return ( selectAll() );
				break;
		}
	} else
	{
		return ( selectAll() );
	}

}
// access_key - header
//echo access();
// post/ put etc.

echo json_encode( init()  )
?>

