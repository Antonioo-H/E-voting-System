<?php
include "../conexiune.php";

$query = "SELECT * FROM departament";
$r = oci_parse($conn, $query);
oci_execute($r);

echo "<table border = '1' cellpadding='3'>";
echo' 
<tr>
	<td style="text-align:center">
		<b> ID_DEPARTAMENT </b>
		<a href="../sort.php?tabel=departament&coloana=id_departament&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=departament&coloana=id_departament&ordine=desc">&#8595</a>
	</td>
	<td style="text-align:center">
		<b> NUME_DEPARTAMENT </b>
		<a href="../sort.php?tabel=departament&coloana=nume_departament&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=departament&coloana=nume_departament&ordine=desc">&#8595</a>
	</td>
</tr>';

while ($row = oci_fetch_array($r, OCI_ASSOC+OCI_RETURN_NULLS))
{
	$id_departament = $row['ID_DEPARTAMENT'];
	$nume_departament = $row['NUME_DEPARTAMENT'];
	echo"
	<tr>
		<td style='text-align:center'>
			$id_departament
		</td>
		<td style='text-align:center'>
			$nume_departament
		</td>
	</tr>";
}
echo '</table>';

echo'<h3><a href="departament.php">Întoarcere la opțiunile pentru tabelul de bază</a></h3>';

oci_free_statement($r);
oci_close($conn);
?>