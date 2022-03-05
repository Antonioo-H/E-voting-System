<?php
include "../conexiune.php";

$query1 = "INSERT INTO sarcina (id_sarcina, id_proiect, nume_sarcina) VALUES (:id_sarcina, :id_proiect, :nume_sarcina)";
$r1 = oci_parse($conn, $query1);

$id_proiect = $_GET["id_proiect"];
$nume_sarcina = $_GET["nume_sarcina"];

$query0 = 'SELECT SACINA_id_sarcina_SEQ.NEXTVAL "sequence" FROM dual';
$r0 = oci_parse($conn, $query0);
oci_execute($r0);
$row = oci_fetch_array($r0);

$sequence = $row['sequence'];

oci_bind_by_name($r1, ':id_sarcina', $sequence);
oci_bind_by_name($r1, ':id_proiect', $id_proiect);
oci_bind_by_name($r1, ':nume_sarcina', $nume_sarcina);

oci_execute($r1);
?>