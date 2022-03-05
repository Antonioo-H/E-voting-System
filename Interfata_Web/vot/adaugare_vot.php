<?php
include "../conexiune.php";

$query = "INSERT INTO vot (nr_matricol, token_scrutin, moment_vot, optiune_votata) VALUES (:nr_matricol, :token_scrutin, :moment_vot, :optiune_votata)";
$r = oci_parse($conn, $query);

$nr_matricol = $_GET["nr_matricol"];
$token_scrutin = $_GET["token_scrutin"];
$moment_vot = $_GET["moment_vot"];
$optiune_votata = $_GET["optiune_votata"];

oci_bind_by_name($r, ':nr_matricol', $nr_matricol);
oci_bind_by_name($r, ':token_scrutin', $token_scrutin);
oci_bind_by_name($r, ':moment_vot', $moment_vot);
oci_bind_by_name($r, ':optiune_votata', $optiune_votata);

oci_execute($r);
?>