<?php
include "../conexiune.php";

$query = "SELECT * FROM echipa";
$r = oci_parse($conn, $query);
oci_execute($r);

echo "<table border = '1' cellpadding='3'>";
echo' 
<tr>
	<td style="text-align:center">
		<b> ID_ECHIPA </b>
		<a href="../sort.php?tabel=echipa&coloana=id_echipa&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=echipa&coloana=id_echipa&ordine=desc">&#8595</a>
	</td>
	<td style="text-align:center">
		<b> NUME_ECHIPA </b>
		<a href="../sort.php?tabel=echipa&coloana=nume_echipa&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=echipa&coloana=nume_echipa&ordine=desc">&#8595</a>
	</td>
</tr>';

while ($row = oci_fetch_array($r, OCI_ASSOC+OCI_RETURN_NULLS))
{
	$id_echipa = $row['ID_ECHIPA'];
	$nume_echipa = $row['NUME_ECHIPA'];
	echo"
	<tr>
		<td style='text-align:center'>
			$id_echipa
		</td>
		<td style='text-align:center'>
			$nume_echipa
		</td>
	</tr>";
}
echo '</table>';

echo'<h3><a href="echipa.php">Întoarcere la opțiunile pentru tabelul de bază</a></h3>';

oci_free_statement($r);
oci_close($conn);
?>