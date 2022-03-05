<?php
include "../conexiune.php";

$query1 = "INSERT INTO firma (id_firma, nume_firma, email, telefon) VALUES (:id_firma, :nume_firma, :email, :telefon)";
$r1 = oci_parse($conn, $query1);

$nume_firma = $_GET["nume_firma"];
$email = $_GET["email"];
$telefon = $_GET["telefon"];

$query0 = 'SELECT FIRMA_id_firma_SEQ.NEXTVAL "sequence" FROM dual';
$r0 = oci_parse($conn, $query0);
oci_execute($r0);
$row = oci_fetch_array($r0);

$sequence = $row['sequence'];

oci_bind_by_name($r1, ':id_firma', $sequence);
oci_bind_by_name($r1, ':nume_firma', $nume_firma);
oci_bind_by_name($r1, ':email', $email);
oci_bind_by_name($r1, ':telefon', $telefon);

oci_execute($r1);
?>