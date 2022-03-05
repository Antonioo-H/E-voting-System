<?php
include "../conexiune.php";

$id_scrutin = $_GET["id_scrutin"];
$id_sarcina = $_GET["id_sarcina"];
$data_inceput_inscriere = $_GET["data_inceput_inscriere"];
$data_finalizare_inscriere = $_GET["data_finalizare_inscriere"];
$data_scrutin = $_GET["data_scrutin"];

$query = "UPDATE scrutin SET id_sarcina = :id_sarcina, data_inceput_inscriere = :data_inceput_inscriere, data_finalizare_inscriere = :data_finalizare_inscriere, data_scrutin = :data_scrutin WHERE id_scrutin = :id_scrutin";
$r = oci_parse($conn, $query);

oci_bind_by_name($r, ':id_scrutin', $id_scrutin);
oci_bind_by_name($r, ':id_sarcina', $id_sarcina);
oci_bind_by_name($r, ':data_inceput_inscriere', $data_inceput_inscriere);
oci_bind_by_name($r, ':data_finalizare_inscriere', $data_finalizare_inscriere);
oci_bind_by_name($r, ':data_scrutin', $data_scrutin);

oci_execute($r);
?>