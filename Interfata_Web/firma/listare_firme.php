<?php
include "../conexiune.php";

$query = "SELECT * FROM firma";
$r = oci_parse($conn, $query);
oci_execute($r);

echo "<table border = '1' cellpadding='3'>";
echo' 
<tr>
	<td style="text-align:center">
		<b> ID_FIRMA </b>
		<a href="../sort.php?tabel=firma&coloana=id_firma&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=firma&coloana=id_firma&ordine=desc">&#8595</a>
	</td>
	<td style="text-align:center">
		<b> NUME_FIRMA </b>
		<a href="../sort.php?tabel=firma&coloana=nume_firma&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=firma&coloana=nume_firma&ordine=desc">&#8595</a>
	</td>
	<td style="text-align:center">
		<b> EMAIL </b>
		<a href="../sort.php?tabel=firma&coloana=email&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=firma&coloana=email&ordine=desc">&#8595</a>
	</td>
	<td style="text-align:center">
		<b> TELEFON </b>
		<a href="../sort.php?tabel=firma&coloana=telefon&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=firma&coloana=telefon&ordine=desc">&#8595</a>
	</td>
</tr>';

while ($row = oci_fetch_array($r, OCI_ASSOC+OCI_RETURN_NULLS))
{
	$id_firma = $row['ID_FIRMA'];
	$nume_firma = $row['NUME_FIRMA'];
	$email = $row['EMAIL'];
	$telefon = $row['TELEFON'];
	echo"
	<tr>
		<td style='text-align:center'>
			$id_firma
		</td>
		<td style='text-align:center'>
			$nume_firma
		</td>
		<td style='text-align:center'>
			$email
		</td>
		<td style='text-align:center'>
			$telefon
		</td>
	</tr>";
}
echo '</table>';

echo'<h3><a href="firma.php">Întoarcere la opțiunile pentru tabelul de bază</a></h3>';

oci_free_statement($r);
oci_close($conn);
?>