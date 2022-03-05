<?php
include "../conexiune.php";

$query = "DELETE FROM departament WHERE id_departament = :id_departament"; 
$r = oci_parse($conn, $query);

$id_departament = $_GET["id_departament"];
oci_bind_by_name($r, ':id_departament', $id_departament);

oci_execute($r);
?>