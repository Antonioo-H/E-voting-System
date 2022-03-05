<?php
include "conexiune.php";

echo "<h3>CERERE:
		<br>&emsp;
		Afisați numărul matricol, numele si prenumele studenților care își depun candidatura pentru sarcina 'sondaj preferinte utilizatori' în utlima zi de înscrieri (se specifică că utltima zi de înscrieri este între 8 August 2021 ora 00:00:00 și 8 August 2021 ora 23:59:59).
	  </h3>";

$query = "select s.nr_matricol, s.nume, s.prenume
		  from student s join student_echipa se on (s.nr_matricol = se.id_student)
			   join candidatura c on (c.id_echipa = se.id_echipa)
			   join sarcina ss on (c.id_sarcina = ss.id_sarcina)
		  where lower(nume_sarcina) = 'sondaj preferinte utilizatori' and
				c.data_inscriere between to_date('08-08-2021', 'DD-MM-YYYY') and to_date('09-08-2021', 'DD-MM-YYYY')";

$r = oci_parse($conn, $query);
oci_execute($r);

echo "<br><h3>REZULTAT:</h3>";
echo "<table border = '1' cellpadding='3'>";
echo '<tr>
		<td style="text-align:center"><b> NR_MATRICOL </b></td>
		<td style="text-align:center"><b> NUME <b></td>
		<td style="text-align:center"><b> PRENUME <b></td>
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