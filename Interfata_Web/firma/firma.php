<html>
<title> Tabelul FIRMA </title>
<h1> <FONT COLOR = "green" > Tabelul FIRMA </FONT> </h1>

<form action="adaugare_firma.php">

  <b>Adăugarea unei firme:</b> <br><br>
 
  Nume firmă: <input type="text" name="nume_firma"> <br><br>
  E-mail: <input type="text" name="email"> <br><br>
  Telefon: <input type="text" name="telefon"> <br><br>
  
<input type="submit" value="Adaugă">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<form action="stergere_firma.php">

  <b>Ștergerea unei firme:</b> <br><br>

  Id firmă: <input type="text" name="id_firma"> <br><br>
  
<input type="submit" value="Șterge">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<form action="update_firma.php">

  <b>Editarea unei firme:</b> <br><br>

  Id firmă: <input type="text" name="id_firma"> <br><br>
  Nume firmă: <input type="text" name="nume_firma"> <br><br>
  E-mail: <input type="text" name="email"> <br><br>
  Telefon: <input type="text" name="telefon"> <br><br>
  
<input type="submit" value="Editează">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<h3><a href="listare_firme.php">Listarea firmelor</a></h3>
<h2><a href="../Interfata.php">Întoarcere la structura bazei de date</a></h2>

</html>