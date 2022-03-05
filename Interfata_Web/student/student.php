<html>
<title> Tabelul STUDENT </title>
<h1> <FONT COLOR = "green" > Tabelul STUDENT </FONT> </h1>

<form action="adaugare_student.php">

  <b>Adăugarea unui student:</b> <br><br>

  Id departament: <input type="text" name="id_departament"> <br><br>
  Nume student: <input type="text" name="nume"> <br><br>
  Prenume student: <input type="text" name="prenume"> <br><br>
  
<input type="submit" value="Adaugă">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<form action="stergere_student.php">

  <b>Ștergerea unui student:</b> <br><br>
  
  Număr matricol: <input type="text" name="nr_matricol"> <br><br>
  
<input type="submit" value="Șterge">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<form action="update_student.php">

  <b>Editarea informațiilor unui student:</b> <br><br>

  Număr matricol: <input type="text" name="nr_matricol"> <br><br>
  Id departament: <input type="text" name="id_departament"> <br><br>
  Nume student: <input type="text" name="nume"> <br><br>
  Prenume student: <input type="text" name="prenume"> <br><br>
  
<input type="submit" value="Editează">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<h3><a href="listare_studenti.php">Listarea studenților</a></h3>
<h2><a href="../Interfata.php">Întoarcere la structura bazei de date</a></h2>

</html>