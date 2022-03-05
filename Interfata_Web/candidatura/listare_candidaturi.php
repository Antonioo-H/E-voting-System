<?php
include "../conexiune.php";

$query = "SELECT * FROM candidatura";
$r = oci_parse($conn, $query);
oci_execute($r);

echo "<table border = '1' cellpadding='3'>";
echo' 
<tr>
	<td style="text-align:center">
		<b> ID_ECHIPA </b>
		<a href="../sort.php?tabel=candidatura&coloana=id_echipa&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=candidatura&coloana=id_echipa&ordine=desc">&#8595</a>
	</td>
	<td style="text-align:center">
		<b> ID_SARCINA </b>
		<a href="../sort.php?tabel=candidatura&coloana=id_sarcina&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=candidatura&coloana=id_sarcina&ordine=desc">&#8595</a>
	</td>
	<td style="text-align:center">
		<b> DATA_INSCRIERE </b>
		<a href="../sort.php?tabel=candidatura&coloana=data_inscriere&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=candidatura&coloana=data_inscriere&ordine=desc">&#8595</a>
	</td>
</tr>';

while ($row = oci_fetch_array($r, OCI_ASSOC+OCI_RETURN_NULLS))
{
	$id_echipa = $row['ID_ECHIPA'];
	$id_sarcina = $row['ID_SARCINA'];
	$data_inscriere = $row['DATA_INSCRIERE'];
	
	echo"
	<tr>
		<td style='text-align:center'>
			$id_echipa
		</td>
		<td style='text-align:center'>
			$id_sarcina
		</td>
		<td style='text-align:center'>
			$data_inscriere
		</td>
	</tr>";
}
echo '</table>';

echo'<h3><a href="candidatura.php">Întoarcere la opțiunile pentru tabelul de bază</a></h3>';

oci_free_statement($r);
oci_close($conn);
?>