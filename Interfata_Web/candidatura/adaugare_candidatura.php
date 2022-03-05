<?php
include "../conexiune.php";

$query = "INSERT INTO candidatura (id_echipa, id_sarcina, data_inscriere) VALUES (:id_echipa, :id_sarcina, :data_inscriere)";
$r = oci_parse($conn, $query);

$id_echipa = $_GET["id_echipa"];
$id_sarcina = $_GET["id_sarcina"];
$data_inscriere = $_GET["data_inscriere"];

oci_bind_by_name($r, ':id_echipa', $id_echipa);
oci_bind_by_name($r, ':id_sarcina', $id_sarcina);
oci_bind_by_name($r, ':data_inscriere', $data_inscriere);

oci_execute($r);
?>