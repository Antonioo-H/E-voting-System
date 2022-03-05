<?php
include "../conexiune.php";

$query = "SELECT * FROM student";
$r = oci_parse($conn, $query);
oci_execute($r);

echo "<table border = '1' cellpadding='3'>";
echo' 
<tr>
	<td style="text-align:center">
		<b> NR_MATRICOL </b>
		<a href="../sort.php?tabel=student&coloana=nr_matricol&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=student&coloana=nr_matricol&ordine=desc">&#8595</a>
	</td>
	<td style="text-align:center">
		<b> ID_DEPARTAMENT </b>
		<a href="../sort.php?tabel=student&coloana=id_departament&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=student&coloana=id_departament&ordine=desc">&#8595</a>
	</td>
	<td style="text-align:center">
		<b> NUME </b>
		<a href="../sort.php?tabel=student&coloana=nume&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=student&coloana=nume&ordine=desc">&#8595</a>
	</td>
	<td style="text-align:center">
		<b> PRENUME </b>
		<a href="../sort.php?tabel=student&coloana=prenume&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=student&coloana=prenume&ordine=desc">&#8595</a>
	</td>
</tr>';

while ($row = oci_fetch_array($r, OCI_ASSOC+OCI_RETURN_NULLS))
{
	$nr_matricol = $row['NR_MATRICOL'];
	$id_departament = $row['ID_DEPARTAMENT'];
	$nume = $row['NUME'];
	$prenume = $row['PRENUME'];
	echo"
	<tr>
		<td style='text-align:center'>
			$nr_matricol
		</td>
		<td style='text-align:center'>
			$id_departament
		</td>
		<td style='text-align:center'>
			$nume
		</td>
		<td style='text-align:center'>
			$prenume
		</td>
	</tr>";
}
echo '</table>';

echo'<h3><a href="student.php">Întoarcere la opțiunile pentru tabelul de bază</a></h3>';

oci_free_statement($r);
oci_close($conn);
?>