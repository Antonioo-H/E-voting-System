<html>
<title> Tabelul SARCINA </title>
<h1> <FONT COLOR = "green" > Tabelul SARCINA </FONT> </h1>

<form action="adaugare_sarcina.php">

  <b>Adăugarea unei sarcini:</b> <br><br>

  Id proiect: <input type="text" name="id_proiect"> <br><br>
  Nume sarcină: <input type="text" name="nume_sarcina"> <br><br>
  
<input type="submit" value="Adaugă">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<form action="stergere_sarcina.php">

  <b>Ștergerea unei sarcini:</b> <br><br>

  Id sarcină: <input type="text" name="id_sarcina"> <br><br>
  
<input type="submit" value="Șterge">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<form action="update_sarcina.php">

  <b>Editarea unei sarcini:</b> <br><br>

  Id sarcină: <input type="text" name="id_sarcina"> <br><br>
  Id proiect: <input type="text" name="id_proiect"> <br><br>
  Nume sarcină: <input type="text" name="nume_sarcina"> <br><br>
  
<input type="submit" value="Editează">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<h3><a href="listare_sarcini.php">Listarea sarcinilor</a></h3>
<h2><a href="../Interfata.php">Întoarcere la structura bazei de date</a></h2>

</html>