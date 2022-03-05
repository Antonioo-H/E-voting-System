<?php
include "../conexiune.php";

$query = "DELETE FROM student WHERE nr_matricol = :nr_matricol"; 
$r = oci_parse($conn, $query);

$nr_matricol = $_GET["nr_matricol"];
oci_bind_by_name($r, ':nr_matricol', $nr_matricol);

oci_execute($r);
?>