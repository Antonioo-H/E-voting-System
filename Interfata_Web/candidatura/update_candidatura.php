<?php
include "../conexiune.php";

$id_echipa_vechi = $_GET["id_echipa_vechi"];
$id_sarcina_vechi = $_GET["id_sarcina_vechi"];
$id_echipa_nou = $_GET["id_echipa_nou"];
$id_sarcina_nou = $_GET["id_sarcina_nou"];
$data_inscriere = $_GET["data_inscriere"];

$query = "UPDATE candidatura SET id_echipa = :id_echipa_nou, id_sarcina = :id_sarcina_nou, data_inscriere = :data_inscriere WHERE id_echipa = :id_echipa_vechi AND id_sarcina = :id_sarcina_vechi";
$r = oci_parse($conn, $query);

oci_bind_by_name($r, ':id_echipa_vechi', $id_echipa_vechi);
oci_bind_by_name($r, ':id_sarcina_vechi', $id_sarcina_vechi);
oci_bind_by_name($r, ':id_echipa_nou', $id_echipa_nou);
oci_bind_by_name($r, ':id_sarcina_nou', $id_sarcina_nou);
oci_bind_by_name($r, ':data_inscriere', $data_inscriere);

oci_execute($r);
?>