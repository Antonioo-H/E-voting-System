<?php
include "../conexiune.php";

$nr_matricol_vechi = $_GET["nr_matricol_vechi"];
$token_scrutin_vechi = $_GET["token_scrutin_vechi"];
$nr_matricol_nou = $_GET["nr_matricol_nou"];
$token_scrutin_nou = $_GET["token_scrutin_nou"];
$moment_vot = $_GET["moment_vot"];
$optiune_votata = $_GET["optiune_votata"];

$query = "UPDATE vot SET nr_matricol = :nr_matricol_nou, token_scrutin = :token_scrutin_nou, moment_vot = :moment_vot, optiune_votata = :optiune_votata WHERE nr_matricol = :nr_matricol_vechi AND token_scrutin = :token_scrutin_vechi";
$r = oci_parse($conn, $query);

oci_bind_by_name($r, ':nr_matricol_vechi', $nr_matricol_vechi);
oci_bind_by_name($r, ':token_scrutin_vechi', $token_scrutin_vechi);
oci_bind_by_name($r, ':nr_matricol_nou', $nr_matricol_nou);
oci_bind_by_name($r, ':token_scrutin_nou', $token_scrutin_nou);
oci_bind_by_name($r, ':moment_vot', $moment_vot);
oci_bind_by_name($r, ':optiune_votata', $optiune_votata);

oci_execute($r);
?>