<?php
include "../conexiune.php";

$query1 = "INSERT INTO DEPARTAMENT (id_departament, nume_departament) VALUES (:dep, :nume_dep)";
$r1 = oci_parse($conn, $query1);
$nume_departament = $_GET["nume_departament"];

$query0 = 'SELECT DEPARTAMENT_id_departament_SEQ.NEXTVAL "sequence" FROM dual';
$r0 = oci_parse($conn, $query0);
oci_execute($r0);
$row = oci_fetch_array($r0);

$sequence = $row['sequence'];

oci_bind_by_name($r1, ':dep', $sequence);
oci_bind_by_name($r1, ':nume_dep', $nume_departament);

oci_execute($r1);
?>