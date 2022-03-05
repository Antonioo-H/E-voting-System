<?php
include "../conexiune.php";

$id_sarcina = $_GET["id_sarcina"];
$id_proiect = $_GET["id_proiect"];
$nume_sarcina = $_GET["nume_sarcina"];

$query = "UPDATE sarcina SET id_proiect = :id_proiect, nume_sarcina = :nume_sarcina WHERE id_sarcina = :id_sarcina";
$r = oci_parse($conn, $query);

oci_bind_by_name($r, ':id_sarcina', $id_sarcina);
oci_bind_by_name($r, ':id_proiect', $id_proiect);
oci_bind_by_name($r, ':nume_sarcina', $nume_sarcina);

oci_execute($r);
?>