<html>
<title> Tabelul PROIECT </title>
<h1> <FONT COLOR = "green" > Tabelul PROIECT </FONT> </h1>

<form action="adaugare_proiect.php">

  <b>Adăugarea unui proiect:</b> <br><br>
 
  Id firmă: <input type="text" name="id_firma"> <br><br>
  Nume proiect: <input type="text" name="nume_proiect"> <br><br>
  Buget: <input type="text" name="buget"> <br><br>
  
<input type="submit" value="Adaugă">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<form action="stergere_proiect.php">

  <b>Ștergerea unui proiect:</b> <br><br>

  Id proiect: <input type="text" name="id_proiect"> <br><br>
  
<input type="submit" value="Șterge">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<form action="update_proiect.php">

  <b>Editarea unui proiect:</b> <br><br>

  Id proiect: <input type="text" name="id_proiect"> <br><br>
  Id firmă: <input type="text" name="id_firma"> <br><br>
  Nume proiect: <input type="text" name="nume_proiect"> <br><br>
  Buget: <input type="text" name="buget"> <br><br>
  
<input type="submit" value="Editează">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<h3><a href="listare_proiecte.php">Listarea proiectelor</a></h3>
<h2><a href="../Interfata.php">Întoarcere la structura bazei de date</a></h2>


</html>