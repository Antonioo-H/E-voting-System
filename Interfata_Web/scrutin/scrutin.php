<html>
<title> Tabelul SCRUTIN </title>
<h1> <FONT COLOR = "green" > Tabelul SCRUTIN </FONT> </h1>

<form action="adaugare_scrutin.php">

  <b>Adăugarea unui scrutin:</b> <br><br>

  Id sarcină: <input type="text" name="id_sarcina"> <br><br>
  Dată început înscriere: <input type="text" name="data_inceput_inscriere"> <br><br>
  Dată finalizare înscriere: <input type="text" name="data_finalizare_inscriere"> <br><br>
  Dată scrutin: <input type="text" name="data_scrutin"> <br><br>
  
<input type="submit" value="Adaugă">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<form action="stergere_scrutin.php">

  <b>Ștergerea unui scrutin:</b> <br><br>

  Id scrutin: <input type="text" name="id_scrutin"> <br><br>
  
<input type="submit" value="Șterge">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<form action="update_scrutin.php">

  <b>Editarea unui scrutin:</b> <br><br>

  Id scrutin: <input type="text" name="id_scrutin"> <br><br>
  Id sarcină: <input type="text" name="id_sarcina"> <br><br>
  Dată început înscriere: <input type="text" name="data_inceput_inscriere"> <br><br>
  Dată finalizare înscriere: <input type="text" name="data_finalizare_inscriere"> <br><br>
  Dată scrutin: <input type="text" name="data_scrutin"> <br><br>
  
<input type="submit" value="Editează">
<INPUT TYPE="reset" VALUE="Resetează">
<br><br>
</form>

<h3><a href="listare_scrutine.php">Listarea scrutinelor</a></h3>
<h2><a href="../Interfata.php">Întoarcere la structura bazei de date</a></h2>

</html>