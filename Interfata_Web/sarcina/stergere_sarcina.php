<?php
include "../conexiune.php";

$query = "DELETE FROM sarcina WHERE id_sarcina = :id_sarcina"; 
$r = oci_parse($conn, $query);

$id_sarcina = $_GET["id_sarcina"];
oci_bind_by_name($r, ':id_sarcina', $id_sarcina);

oci_execute($r);
?>