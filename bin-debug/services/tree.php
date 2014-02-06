<?php ob_start(); ?>
<?php require_once('Connections/localhost.php'); ?>
<?php require_once('Connections/functions.php'); ?>
<?php




//print_r($row_top);
//$totalRows_user = mysql_num_rows($row_top);

//die("name=".$row_user['firstname']." ".$row_user['lastname']."&posts=".$row_user['posts']);


function recurse($id, $xPosParent)
{
    global $database_localhost, $localhost;
    mysql_select_db($database_localhost, $localhost);
	$query = sprintf("SELECT assets.id, assets.pid, assets.name, assets.source, assets.contentid, asset_types.name as typename FROM assets inner join asset_types ON assets.typeid=asset_types.id  where public=1 and assets.pid = %s  order by orderid", GetSQLValueString($id, "int"));      
	$result = mysql_query($query, $localhost) or die(mysql_error());
	
	$counter = 0;
	$ret = '';
	$total = mysql_num_rows($result);
    while ($row = mysql_fetch_assoc($result)) 
    {
    	$width = ( $row['typename']=="folder"  ? 265 : 340 );
    	/*$xPosParent + */
		$xPos = $width*(-($total/2)+$counter)-(($total % 1==0 ?  -.5*$width : 0));

		$ret .= '<component type="'.$row['typename'].'" x="'.$xPos.'" source="'.$row['source'].'"'.( empty( $row['contentid'] ) ? '' : ' data="services/assets.php?id=1"').'>';
		$ret .= recurse($row["id"], $xPos);
		$ret .= '</component>';
		$counter++;
    }
    return $ret;
}

function buildTree()
{
	global $database_localhost, $localhost;
	mysql_select_db($database_localhost, $localhost);
	$query = "SELECT assets.id, assets.pid, assets.name, assets.source, asset_types.name as typename FROM assets inner join asset_types ON assets.typeid=asset_types.id  where assets.pid is null and public=1 order by orderid";
	
	$result = mysql_query($query, $localhost) or die(mysql_error());
	$row = mysql_fetch_assoc($result);
	$ret = '<content root="resources/">';
	if ($row!=null)
	{
		$ret .= '<component type="'.$row['typename'].'">';
		$ret .= recurse($row["id"], 0);
		$ret .= '</component>';
	}
	$ret .= '</content>';
	return $ret;
	
}
?>


<?php

header('Content-Type: text/xml');

echo buildTree();

?>