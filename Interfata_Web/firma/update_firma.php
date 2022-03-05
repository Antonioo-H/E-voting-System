<?php
include "../conexiune.php";

$id_firma = $_GET["id_firma"];
$nume_firma = $_GET["nume_firma"];
$email = $_GET["email"];
$telefon = $_GET["telefon"];

$query = "UPDATE firma SET nume_firma = :nume_firma, email = :email, telefon = :telefon WHERE id_firma = :id_firma";
$r = oci_parse($conn, $query);

oci_bind_by_name($r, ':id_firma', $id_firma);
oci_bind_by_name($r, ':nume_firma', $nume_firma);
oci_bind_by_name($r, ':email', $email);
oci_bind_by_name($r, ':telefon', $telefon);

oci_execute($r);
?>