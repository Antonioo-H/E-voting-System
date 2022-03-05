<?php
include "../conexiune.php";

$query = "SELECT * FROM proiect";
$r = oci_parse($conn, $query);
oci_execute($r);

echo "<table border = '1' cellpadding='3'>";
echo' 
<tr>
	<td style="text-align:center">
		<b> ID_PROIECT </b>
		<a href="../sort.php?tabel=proiect&coloana=id_proiect&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=proiect&coloana=id_proiect&ordine=desc">&#8595</a>
	</td>
	<td style="text-align:center">
		<b> ID_FIRMA </b>
		<a href="../sort.php?tabel=proiect&coloana=id_firma&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=proiect&coloana=id_firma&ordine=desc">&#8595</a>
	</td>
	<td style="text-align:center">
		<b> NUME_PROIECT </b>
		<a href="../sort.php?tabel=proiect&coloana=nume_proiect&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=proiect&coloana=nume_proiect&ordine=desc">&#8595</a>
	</td>
	<td style="text-align:center">
		<b> BUGET </b>
		<a href="../sort.php?tabel=proiect&coloana=buget&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=proiect&coloana=buget&ordine=desc">&#8595</a>
	</td>
</tr>';

while ($row = oci_fetch_array($r, OCI_ASSOC+OCI_RETURN_NULLS))
{
	$id_proiect = $row['ID_PROIECT'];
	$id_firma = $row['ID_FIRMA'];
	$nume_proiect = $row['NUME_PROIECT'];
	$buget = $row['BUGET'];
	echo"
	<tr>
		<td style='text-align:center'>
			$id_proiect
		</td>
		<td style='text-align:center'>
			$id_firma
		</td>
		<td style='text-align:center'>
			$nume_proiect
		</td>
		<td style='text-align:center'>
			$buget
		</td>
	</tr>";
}
echo '</table>';

echo'<h3><a href="proiect.php">Întoarcere la opțiunile pentru tabelul de bază</a></h3>';

oci_free_statement($r);
oci_close($conn);
?>