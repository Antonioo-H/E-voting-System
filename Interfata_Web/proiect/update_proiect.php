<?php
include "../conexiune.php";

$id_proiect = $_GET["id_proiect"];
$id_firma = $_GET["id_firma"];
$nume_proiect = $_GET["nume_proiect"];
$buget = $_GET["buget"];

$query = "UPDATE proiect SET id_firma = :id_firma, nume_proiect = :nume_proiect, buget = :buget WHERE id_proiect = :id_proiect";
$r = oci_parse($conn, $query);

oci_bind_by_name($r, ':id_proiect', $id_proiect);
oci_bind_by_name($r, ':id_firma', $id_firma);
oci_bind_by_name($r, ':nume_proiect', $nume_proiect);
oci_bind_by_name($r, ':buget', $buget);

oci_execute($r);
?>