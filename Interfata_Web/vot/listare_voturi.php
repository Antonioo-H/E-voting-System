<?php
include "../conexiune.php";

$query = "SELECT * FROM vot";
$r = oci_parse($conn, $query);
oci_execute($r);

echo "<table border = '1' cellpadding='3'>";
echo' 
<tr>
	<td style="text-align:center">
		<b> NR_MATRICOL </b>
		<a href="../sort.php?tabel=vot&coloana=nr_matricol&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=vot&coloana=nr_matricol&ordine=desc">&#8595</a>
	</td>
	<td style="text-align:center">
		<b> TOKEN_SCRUTIN </b>
		<a href="../sort.php?tabel=vot&coloana=token_scrutin&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=vot&coloana=token_scrutin&ordine=desc">&#8595</a>
	</td>
	<td style="text-align:center">
		<b> MOMENT_VOT </b>
		<a href="../sort.php?tabel=vot&coloana=moment_vot&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=vot&coloana=moment_vot&ordine=desc">&#8595</a>
	</td>
	<td style="text-align:center">
		<b> OPTIUNE_VOTATA </b>
		<a href="../sort.php?tabel=vot&coloana=optiune_votata&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=vot&coloana=optiune_votata&ordine=desc">&#8595</a>
	</td>
</tr>';

while ($row = oci_fetch_array($r, OCI_ASSOC+OCI_RETURN_NULLS))
{
	$nr_matricol = $row['NR_MATRICOL'];
	$token_scrutin = $row['TOKEN_SCRUTIN'];
	$moment_vot = $row['MOMENT_VOT'];
	$optiune_votata = $row['OPTIUNE_VOTATA'];
	echo"
	<tr>
		<td style='text-align:center'>
			$nr_matricol
		</td>
		<td style='text-align:center'>
			$token_scrutin
		</td>
		<td style='text-align:center'>
			$moment_vot
		</td>
		<td style='text-align:center'>
			$optiune_votata
		</td>
	</tr>";
}
echo '</table>';

echo'<h3><a href="vot.php">Întoarcere la opțiunile pentru tabelul de bază</a></h3>';

oci_free_statement($r);
oci_close($conn);
?>