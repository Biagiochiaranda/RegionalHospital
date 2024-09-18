<?php
session_start();
if (!empty($_POST['username'])) {
	$conn = "host=localhost port=5432 dbname=ospedali_regionali user=postgres password = unimi";
	$resconn = pg_connect($conn);
	
	if ($resconn === false) {
		$resconn = pg_connection_reset($conn);
		if ($resconn === false) {
			echo "problemi di connessione, errore: ". pg_connection_status;
			exit;
		}
	}
	
	$usn = "'".$_POST['username']."'";
	$passw = "'".$_POST['pwd']."'";
	
	$statement = "select * from login where username = ".$usn." and pwd = ".$passw;
	$res = pg_query($statement);
	
	if ($res == false) {
		echo "problemi con l'esecuzione della query";
	}
	
	if (pg_num_rows($res) == 0) {
		echo "le tue credenziali non sono corrette oppure ci sono problemi con il login";
		session_destroy();
		exit;
	}
	
	$_SESSION['user'] = $_POST['username'];
	$_SESSION['password'] = $_POST['pwd'];
	
	echo "autenticazione completata! puoi <a href='schermata_iniziale.php'>procedere";
	
	$close = pg_close($resconn);
		if ($close==false){
			echo "chiusura fallita";
		exit;
	}
	
} else {
	echo "vai alla pagina di <a href='autenticazione.html'>registrazione";
	session_destroy();
}
?>