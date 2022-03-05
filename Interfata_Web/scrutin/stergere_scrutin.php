<?php
include "../conexiune.php";

$query = "DELETE FROM scrutin WHERE id_scrutin = :id_scrutin"; 
$r = oci_parse($conn, $query);

$id_scrutin = $_GET["id_scrutin"];
oci_bind_by_name($r, ':id_scrutin', $id_scrutin);

oci_execute($r);
?>