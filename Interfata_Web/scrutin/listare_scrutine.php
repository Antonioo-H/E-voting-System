<?php
include "../conexiune.php";

$query = "SELECT * FROM scrutin";
$r = oci_parse($conn, $query);
oci_execute($r);

echo "<table border = '1' cellpadding='3'>";
echo' 
<tr>
	<td style="text-align:center">
		<b> ID_SCRUTIN </b>
		<a href="../sort.php?tabel=scrutin&coloana=id_scrutin&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=scrutin&coloana=id_scrutin&ordine=desc">&#8595</a>
	</td>
	<td style="text-align:center">
		<b> ID_SARCINA </b>
		<a href="../sort.php?tabel=scrutin&coloana=id_sarcina&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=scrutin&coloana=id_sarcina&ordine=desc">&#8595</a>
	</td>
	<td style="text-align:center">
		<b> DATA_INCEPUT_INSCRIERE </b>
		<a href="../sort.php?tabel=scrutin&coloana=data_inceput_inscriere&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=scrutin&coloana=data_inceput_inscriere&ordine=desc">&#8595</a>
	</td>
	<td style="text-align:center">
		<b> DATA_FINALIZARE_INSCRIERE </b>
		<a href="../sort.php?tabel=scrutin&coloana=data_finalizare_inscriere&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=scrutin&coloana=data_finalizare_inscriere&ordine=desc">&#8595</a>
	</td>
	<td style="text-align:center">
		<b> DATA_SCRUTIN </b>
		<a href="../sort.php?tabel=scrutin&coloana=data_scrutin&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=scrutin&coloana=data_scrutin&ordine=desc">&#8595</a>
	</td>
	<td style="text-align:center">
		<b> TOKEN_SCRUTIN </b>
		<a href="../sort.php?tabel=scrutin&coloana=token_scrutin&ordine=asc">&#8593</a>
		<a href="../sort.php?tabel=scrutin&coloana=token_scrutin&ordine=desc">&#8595</a>
	</td>
</tr>';

while ($row = oci_fetch_array($r, OCI_ASSOC+OCI_RETURN_NULLS))
{
	$id_scrutin = $row['ID_SCRUTIN'];
	$id_sarcina = $row['ID_SARCINA'];
	$data_inceput_inscriere = $row['DATA_INCEPUT_INSCRIERE'];
	$data_finalizare_inscriere = $row['DATA_FINALIZARE_INSCRIERE'];
	$data_scrutin = $row['DATA_SCRUTIN'];
	$token_scrutin = $row['TOKEN_SCRUTIN'];
	
	echo"
	<tr>
		<td style='text-align:center'>
			$id_scrutin
		</td>
		<td style='text-align:center'>
			$id_sarcina
		</td>
		<td style='text-align:center'>
			$data_inceput_inscriere
		</td>
		<td style='text-align:center'>
			$data_finalizare_inscriere
		</td>
		<td style='text-align:center'>
			$data_scrutin
		</td>
		<td style='text-align:center'>
			$token_scrutin
		</td>
	</tr>";
}
echo '</table>';

echo'<h3><a href="scrutin.php">Întoarcere la opțiunile pentru tabelul de bază</a></h3>';

oci_free_statement($r);
oci_close($conn);
?>