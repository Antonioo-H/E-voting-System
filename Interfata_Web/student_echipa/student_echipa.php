<html>
<title> Tabelul asociativ STUDENT_ECHIPA </title>
<h1> <FONT COLOR = "green" > Tabelul asociativ STUDENT_ECHIPA </FONT> </h1>

<form action="adaugare_student_echipa.php">

  <b>Adăugarea unei înregistrări:</b> <br><br>

  Id echipă: <input type="text" name="id_echipa"> <br><br>
  Id student: <input type="text" name="id_student"> <br><br>
  
<input type="submit" value="Adaugă">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<form action="stergere_student_echipa.php">

  <b>Ștergerea unei înregistrări:</b> <br><br>

  Id echipă: <input type="text" name="id_echipa"> <br><br>
  Id student: <input type="text" name="id_student"> <br><br>

<input type="submit" value="Șterge">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<form action="update_student_echipa.php">

  <b>Editarea unei înregistrări:</b> <br><br>

  Id echipă actual: <input type="text" name="id_echipa_vechi"> <br><br>
  Id student actual: <input type="text" name="id_student_vechi"> <br><br>
  Id echipă nou: <input type="text" name="id_echipa_nou"> <br><br>
  Id student nou: <input type="text" name="id_student_nou"> <br><br>

<input type="submit" value="Editează">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<h3><a href="listare_student_echipa.php">Listarea înregistrărilor</a></h3>
<h2><a href="../Interfata.php">Întoarcere la structura bazei de date</a></h2>

</html>