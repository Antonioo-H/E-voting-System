<?php
include "../conexiune.php";

$query = "SELECT * FROM sarcina";
$r = oci_parse($conn, $query);
oci_execute($r);

echo "<table border = '1' cellpadding='3'>";
echo' 
<tr>
	<td style="text-align:center">
		<b> ID_SARCINA </b>
		<a href="../sort.php?tabel=sarcina&coloana=id_sarcina&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=sarcina&coloana=id_sarcina&ordine=desc">&#8595</a>
	</td>
	<td style="text-align:center">
		<b> ID_PROIECT </b>
		<a href="../sort.php?tabel=sarcina&coloana=id_proiect&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=sarcina&coloana=id_proiect&ordine=desc">&#8595</a>
	</td>
	<td style="text-align:center">
		<b> NUME_SARCINA </b>
		<a href="../sort.php?tabel=sarcina&coloana=nume_sarcina&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=sarcina&coloana=nume_sarcina&ordine=desc">&#8595</a>
	</td>
</tr>';

while ($row = oci_fetch_array($r, OCI_ASSOC+OCI_RETURN_NULLS))
{
	$id_sarcina = $row['ID_SARCINA'];
	$id_proiect = $row['ID_PROIECT'];
	$nume_sarcina = $row['NUME_SARCINA'];
	echo"
	<tr>
		<td style='text-align:center'>
			$id_sarcina
		</td>
		<td style='text-align:center'>
			$id_proiect
		</td>
		<td style='text-align:center'>
			$nume_sarcina
		</td>
	</tr>";
}
echo '</table>';

echo'<h3><a href="sarcina.php">Întoarcere la opțiunile pentru tabelul de bază</a></h3>';

oci_free_statement($r);
oci_close($conn);
?>