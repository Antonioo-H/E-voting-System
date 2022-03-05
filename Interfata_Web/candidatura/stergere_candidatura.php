<?php
include "../conexiune.php";

$query = "DELETE FROM candidatura WHERE id_echipa = :id_echipa AND id_sarcina = :id_sarcina"; 
$r = oci_parse($conn, $query);

$id_echipa = $_GET["id_echipa"];
$id_sarcina = $_GET["id_sarcina"];

oci_bind_by_name($r, ':id_echipa', $id_echipa);
oci_bind_by_name($r, ':id_sarcina', $id_sarcina);

oci_execute($r);
?>