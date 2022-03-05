<?php
include "conexiune.php";

$tabel = $_GET['tabel'];
$coloana = $_GET['coloana'];
$ordine = $_GET['ordine'];

$query = "SELECT * FROM $tabel ORDER BY $coloana $ordine";
$r = oci_parse($conn, $query);
oci_execute($r);

$ncols = oci_num_fields($r);
echo "<table border = '1' cellpadding='3'>";
echo '<tr>';
for($i = 1; $i <= $ncols; $i++)
{
	echo' 
		<td style="text-align:center">
			<b>'.oci_field_name($r, $i).' </b>
			<a href="sort.php?tabel='."$tabel".'&coloana='.oci_field_name($r, $i).'&ordine=asc">&#8593</a>
			<a href="sort.php?tabel='."$tabel".'&coloana='.oci_field_name($r, $i).'&ordine=desc">&#8595</a>
		</td>
	';
}
echo '</tr>';

while($row = oci_fetch_array($r, OCI_ASSOC+OCI_RETURN_NULLS))
{
	echo "<tr>";
	foreach($row as $item)
	{
		echo"
			<td style='text-align:center'>
				$item
			</td>
		";
	}
	echo "</tr>";
}
echo "</table>";

echo'<h3><a href="'."$tabel/$tabel.php".'">Întoarcere la opțiunile pentru tabelul de bază</a></h3>';

oci_free_statement($r);
oci_close($conn);
?>