<?php
include "../conexiune.php";

$id_echipa_vechi = $_GET["id_echipa_vechi"];
$id_student_vechi = $_GET["id_student_vechi"];
$id_echipa_nou = $_GET["id_echipa_nou"];
$id_student_nou = $_GET["id_student_nou"];

$query = "UPDATE student_echipa SET id_echipa = :id_echipa_nou, id_student = :id_student_nou WHERE id_echipa = :id_echipa_vechi AND id_student = :id_student_vechi";
$r = oci_parse($conn, $query);

oci_bind_by_name($r, ':id_echipa_vechi', $id_echipa_vechi);
oci_bind_by_name($r, ':id_student_vechi', $id_student_vechi);
oci_bind_by_name($r, ':id_echipa_nou', $id_echipa_nou);
oci_bind_by_name($r, ':id_student_nou', $id_student_nou);

oci_execute($r);
?>