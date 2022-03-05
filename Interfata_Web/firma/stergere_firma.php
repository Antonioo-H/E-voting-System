<?php
include "../conexiune.php";

$query = "DELETE FROM firma WHERE id_firma = :id_firma"; 
$r = oci_parse($conn, $query);

$id_firma = $_GET["id_firma"];
oci_bind_by_name($r, ':id_firma', $id_firma);

oci_execute($r);
?>