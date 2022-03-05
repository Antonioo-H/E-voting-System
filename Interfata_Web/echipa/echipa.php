<html>
<title> Tabelul ECHIPA </title>
<h1> <FONT COLOR = "green" > Tabelul ECHIPA </FONT> </h1>

<form action="adaugare_echipa.php">

  <b>Adăugarea unei echipe:</b> <br><br>
 
  Nume echipă: <input type="text" name="nume_echipa"> <br><br>
  
<input type="submit" value="Adaugă">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<form action="stergere_echipa.php">

  <b>Ștergerea unei echipe:</b> <br><br>

  Id echipă: <input type="text" name="id_echipa"> <br><br>
  
<input type="submit" value="Șterge">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<form action="update_echipa.php">

  <b>Editarea unei echipe:</b> <br><br>

  Id echipă: <input type="text" name="id_echipa"> <br><br>
  Nume echipă: <input type="text" name="nume_echipa"> <br><br>
  
<input type="submit" value="Editează">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<h3><a href="listare_echipe.php">Listarea echipelor</a></h3>
<h2><a href="../Interfata.php">Întoarcere la structura bazei de date</a></h2>


</html>