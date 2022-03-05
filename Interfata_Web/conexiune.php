<?php
	//session_start();
		$conn = oci_connect('C##admin', 'admin', 'localhost/orcl', 'AL32UTF8');
		if(!$conn) {
			$e = oci_error();
			trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
		}
		//else echo "connection successful";
	?>