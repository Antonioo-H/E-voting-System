<?php
include "../conexiune.php";

$query1 = "INSERT INTO proiect (id_proiect, id_firma, nume_proiect, buget) VALUES (:id_proiect, :id_firma, :nume_proiect, :buget)";
$r1 = oci_parse($conn, $query1);

$id_firma = $_GET["id_firma"];
$nume_proiect = $_GET["nume_proiect"];
$buget = $_GET["buget"];

$query0 = 'SELECT PROIECT_id_proiect_SEQ.NEXTVAL "sequence" FROM dual';
$r0 = oci_parse($conn, $query0);
oci_execute($r0);
$row = oci_fetch_array($r0);

$sequence = $row['sequence'];

oci_bind_by_name($r1, ':id_proiect', $sequence);
oci_bind_by_name($r1, ':id_firma', $id_firma);
oci_bind_by_name($r1, ':nume_proiect', $nume_proiect);
oci_bind_by_name($r1, ':buget', $buget);

oci_execute($r1);
?>