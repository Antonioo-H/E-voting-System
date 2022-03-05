<?php
include "../conexiune.php";

$query1 = "INSERT INTO scrutin (id_scrutin, id_sarcina, data_inceput_inscriere, data_finalizare_inscriere, data_scrutin, token_scrutin) VALUES (:id_scrutin, :id_sarcina, :data_inceput_inscriere, :data_finalizare_inscriere, :data_scrutin, :token_scrutin)";
$r1 = oci_parse($conn, $query1);

$id_sarcina = $_GET["id_sarcina"];
$data_inceput_inscriere = $_GET["data_inceput_inscriere"];
$data_finalizare_inscriere = $_GET["data_finalizare_inscriere"];
$data_scrutin = $_GET["data_scrutin"];

$query0 = 'SELECT SCRUTIN_id_scrutin_SEQ.NEXTVAL "sequence" FROM dual';
$r0 = oci_parse($conn, $query0);
oci_execute($r0);
$row0 = oci_fetch_array($r0);
$sequence0 = $row0['sequence'];


$query00 = 'SELECT SCRUTIN_id_token_SEQ.NEXTVAL "sequence" FROM dual';
$r00 = oci_parse($conn, $query00);
oci_execute($r00);
$row00 = oci_fetch_array($r00);
$sequence00 = $row00['sequence'];


oci_bind_by_name($r1, ':id_scrutin', $sequence0);
oci_bind_by_name($r1, ':id_sarcina', $id_sarcina);
oci_bind_by_name($r1, ':data_inceput_inscriere', $data_inceput_inscriere);
oci_bind_by_name($r1, ':data_finalizare_inscriere', $data_finalizare_inscriere);
oci_bind_by_name($r1, ':data_scrutin', $data_scrutin);
oci_bind_by_name($r1, ':token_scrutin', $sequence00);

oci_execute($r1);
?>