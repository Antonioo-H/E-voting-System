<html>
<title> Tabelul asociativ CANDIDATURA </title>
<h1> <FONT COLOR = "green" > Tabelul asociativ CANDIDATURA </FONT> </h1>

<form action="adaugare_candidatura.php">

  <b>Adăugarea unei înregistrări:</b> <br><br>

  Id echipă: <input type="text" name="id_echipa"> <br><br>
  Id sarcină: <input type="text" name="id_sarcina"> <br><br>
  Data_înscriere: <input type="text" name="data_inscriere"> <br><br>
  
<input type="submit" value="Adaugă">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<form action="stergere_candidatura.php">

  <b>Ștergerea unei înregistrări:</b> <br><br>
  
  Id echipă: <input type="text" name="id_echipa"> <br><br>
  Id sarcină: <input type="text" name="id_sarcina"> <br><br>

<input type="submit" value="Șterge">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<form action="update_candidatura.php">

  <b>Editarea unei înregistrări:</b> <br><br>
  
  Id echipă actual: <input type="text" name="id_echipa_vechi"> <br><br>
  Id sarcină actual: <input type="text" name="id_sarcina_vechi"> <br><br>
  Id echipă nou: <input type="text" name="id_echipa_nou"> <br><br>
  Id sarcină nou: <input type="text" name="id_sarcina_nou"> <br><br>
  Data_înscriere: <input type="text" name="data_inscriere"> <br><br>

<input type="submit" value="Editează">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<h3><a href="listare_candidaturi.php">Listarea înregistrărilor</a></h3>
<h2><a href="../Interfata.php">Întoarcere la structura bazei de date</a></h2>

</html>