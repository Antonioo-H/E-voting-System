<?php
include "../conexiune.php";

$query1 = "INSERT INTO echipa (id_echipa, nume_echipa) VALUES (:id_echipa, :nume_echipa)";
$r1 = oci_parse($conn, $query1);
$nume_echipa = $_GET["nume_echipa"];

$query0 = 'SELECT ECHIPA_id_echipa_SEQ.NEXTVAL "sequence" FROM dual';
$r0 = oci_parse($conn, $query0);
oci_execute($r0);
$row = oci_fetch_array($r0);

$sequence = $row['sequence'];

oci_bind_by_name($r1, ':id_echipa', $sequence);
oci_bind_by_name($r1, ':nume_echipa', $nume_echipa);

oci_execute($r1);
?>