<?php
include "../conexiune.php";

$query1 = "INSERT INTO student (nr_matricol, id_departament, nume, prenume) VALUES (:nr_matricol, :id_departament, :nume, :prenume)"; 
$r1 = oci_parse($conn, $query1);

$id_departament = $_GET["id_departament"];
$nume = $_GET["nume"];
$prenume = $_GET["prenume"];

$query0 = 'SELECT STUDENT_nr_matricol_SEQ.NEXTVAL "sequence" FROM dual';
$r0 = oci_parse($conn, $query0);
oci_execute($r0);
$row = oci_fetch_array($r0);

$sequence = $row['sequence'];

oci_bind_by_name($r1, ':nr_matricol', $sequence);
oci_bind_by_name($r1, ':id_departament', $id_departament);
oci_bind_by_name($r1, ':nume', $nume);
oci_bind_by_name($r1, ':prenume', $prenume);

oci_execute($r1);
?>