<?php
include "conexiune.php";

echo "<h3>CERERE:
		<br>&emsp;
		Să se afișeze codul, numele echipei și numărul de studenți care fac parte dintr-o echipă care are cel puțin 7 studenți.
	  </h3>";

$query = "select e.id_echipa, e.nume_echipa, count(se.id_student)
		  from student_echipa se join echipa e on (e.id_echipa = se.id_echipa)
		  group by e.id_echipa, e.nume_echipa
		  having count(se.id_student) >= 7";

$r = oci_parse($conn, $query);
oci_execute($r);

echo "<br><h3>REZULTAT:</h3>";
echo "<table border = '1' cellpadding='3'>";
echo '<tr>
		<td style="text-align:center"><b> COD ECHIPA </b></td>
		<td style="text-align:center"><b> NUME ECHIPA <b></td>
		<td style="text-align:center"><b> NUMAR STUDENTI <b></td>
	  </tr>';

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

echo '<br>';
echo '<h2><a href="Interfata.php">Întoarcere la pagina principală</a></h2>';
?>