<?php
include "../conexiune.php";

$nr_matricol = $_GET["nr_matricol"];
$id_nou_dep = $_GET["id_departament"];
$nume_nou = $_GET["nume"];
$prenume_nou = $_GET["prenume"];

$query = "UPDATE student SET id_departament = :id_nou_dep, nume = :nume_nou, prenume = :prenume_nou WHERE nr_matricol = :nr_matricol";
$r = oci_parse($conn, $query);

oci_bind_by_name($r, ':nr_matricol', $nr_matricol);
oci_bind_by_name($r, ':id_nou_dep', $id_nou_dep);
oci_bind_by_name($r, ':nume_nou', $nume_nou);
oci_bind_by_name($r, ':prenume_nou', $prenume_nou);

oci_execute($r);
?>