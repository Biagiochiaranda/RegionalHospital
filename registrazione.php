<?php
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
	
	$statement = "insert into login values(".$usn.",".$passw.")";
	$res = pg_query($statement);
	
	if ($res == false) {
		echo "<br>ti sei già registrato con queste credenziali oppure ci sono problemi con la registrazione<br>";
		exit;
	}
	
	echo "registrazione completata, puoi andare al <a href='autenticazione.html'>login";
	
	$close = pg_close($resconn);
		if ($close==false){
			echo "chiusura fallita";
		exit;
	}
} else {
	echo "vai alla pagina di <a href='autenticazione.html'>registrazione";
}
	
?>