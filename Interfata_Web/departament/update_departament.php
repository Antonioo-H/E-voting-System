<?php
include "../conexiune.php";

$nume_nou_dep = $_GET["nume_departament"];
$id_dep = $_GET["id_departament"];

$query = "UPDATE departament SET nume_departament = :nume_nou_dep WHERE id_departament = :id_dep";
$r = oci_parse($conn, $query);

oci_bind_by_name($r, ':nume_nou_dep', $nume_nou_dep);
oci_bind_by_name($r, ':id_dep', $id_dep);

oci_execute($r);
?>