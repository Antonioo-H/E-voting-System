<?php
include "../conexiune.php";

$query = "DELETE FROM echipa WHERE id_echipa = :id_echipa"; 
$r = oci_parse($conn, $query);

$id_echipa = $_GET["id_echipa"];
oci_bind_by_name($r, ':id_echipa', $id_echipa);

oci_execute($r);
?>