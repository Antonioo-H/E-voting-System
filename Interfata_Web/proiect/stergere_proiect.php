<?php
include "../conexiune.php";

$query = "DELETE FROM proiect WHERE id_proiect = :id_proiect"; 
$r = oci_parse($conn, $query);

$id_proiect = $_GET["id_proiect"];
oci_bind_by_name($r, ':id_proiect', $id_proiect);

oci_execute($r);
?>