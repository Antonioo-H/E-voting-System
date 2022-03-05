<?php
include "../conexiune.php";

$id_echipa = $_GET["id_echipa"];
$nume_echipa = $_GET["nume_echipa"];

$query = "UPDATE echipa SET nume_echipa = :nume_echipa WHERE id_echipa = :id_echipa";
$r = oci_parse($conn, $query);

oci_bind_by_name($r, ':nume_echipa', $nume_echipa);
oci_bind_by_name($r, ':id_echipa', $id_echipa);

oci_execute($r);
?>