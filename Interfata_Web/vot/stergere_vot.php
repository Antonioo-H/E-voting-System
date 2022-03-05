<?php
include "../conexiune.php";

$query = "DELETE FROM vot WHERE nr_matricol = :nr_matricol AND token_scrutin = :token_scrutin"; 
$r = oci_parse($conn, $query);

$nr_matricol = $_GET["nr_matricol"];
$token_scrutin = $_GET["token_scrutin"];

oci_bind_by_name($r, ':nr_matricol', $nr_matricol);
oci_bind_by_name($r, ':token_scrutin', $token_scrutin);

oci_execute($r);
?>