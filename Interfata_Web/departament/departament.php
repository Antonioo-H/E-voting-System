<html>
<title> Tabelul DEPARTAMENT </title>
<h1> <FONT COLOR = "green" > Tabelul DEPARTAMENT </FONT> </h1>

<form action="adaugare_departament.php">

  <h3>Adăugarea unui departament:</h3>

  Nume departament: <input type="text" name="nume_departament"> <br><br>
  
<input type="submit" value="Adaugă">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<form action="stergere_departament.php">

  <h3>Ștergerea unui departament:</h3>

  Id departament: <input type="text" name="id_departament"> <br><br>
  
<input type="submit" value="Șterge">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<form action="update_departament.php">

  <h3>Editarea unui departament:</h3>

  Id departament: <input type="text" name="id_departament"> <br><br>
  Nume departament: <input type="text" name="nume_departament"> <br><br>
  
<input type="submit" value="Editează">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<h3><a href="listare_departament.php">Listarea departamentelor</a></h3>
<h2><a href="../Interfata.php">Întoarcere la structura bazei de date</a></h2>

</html>