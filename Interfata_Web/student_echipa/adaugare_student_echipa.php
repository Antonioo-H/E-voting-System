<?php
include "../conexiune.php";

$query = "INSERT INTO student_echipa (id_echipa, id_student) VALUES (:id_echipa, :id_student)";
$r = oci_parse($conn, $query);

$id_echipa = $_GET["id_echipa"];
$id_student = $_GET["id_student"];

oci_bind_by_name($r, ':id_echipa', $id_echipa);
oci_bind_by_name($r, ':id_student', $id_student);

oci_execute($r);
?>