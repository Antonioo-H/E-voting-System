<html>
<title> Tabelul asociativ VOT </title>
<h1> <FONT COLOR = "green" > Tabelul asociativ VOT </FONT> </h1>

<form action="adaugare_vot.php">

  <b>Adăugarea unei înregistrări:</b> <br><br>

  Nr matricol: <input type="text" name="nr_matricol"> <br><br>
  Token scrutin: <input type="text" name="token_scrutin"> <br><br>
  Moment vot: <input type="text" name="moment_vot"> <br><br>
  Opțiune votată: <input type="text" name="optiune_votata"> <br><br>
  
<input type="submit" value="Adaugă">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<form action="stergere_vot.php">

  <b>Ștergerea unei înregistrări:</b> <br><br>

  Nr matricol: <input type="text" name="nr_matricol"> <br><br>
  Token scrutin: <input type="text" name="token_scrutin"> <br><br>

<input type="submit" value="Șterge">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<form action="update_vot.php">

  <b>Editarea unei înregistrări:</b> <br><br>

  Nr matricol actual: <input type="text" name="nr_matricol_vechi"> <br><br>
  Token scrutin actual: <input type="text" name="token_scrutin_vechi"> <br><br>
  Nr matricol nou: <input type="text" name="nr_matricol_nou"> <br><br>
  Token scrutin nou: <input type="text" name="token_scrutin_nou"> <br><br>
  Moment vot: <input type="text" name="moment_vot"> <br><br>
  Opțiune votată: <input type="text" name="optiune_votata"> <br><br>

<input type="submit" value="Editează">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<h3><a href="listare_voturi.php">Listarea voturilor</a></h3>
<h2><a href="../Interfata.php">Întoarcere la structura bazei de date</a></h2>

</html>