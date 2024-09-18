<?php
	$connessione = "host=localhost port=5432 user=postgres password = unimi";
	
	$conn = pg_connect($connessione);
	
	if (!$conn) {
		echo "connessione fallita<br>";
		exit;
	}
	echo "connessione riuscita<br>";
	
	$querydb = 'CREATE DATABASE ospedali_regionali';
	
	$status = pg_query($querydb);
	
	if (!$status) {
		$err = pg_last_error($conn);
		echo "c'è stato qualche errore"."$err";
	}
	echo "database creato con successo<br>";
	
	$close = pg_close($conn);
	if (!$close){
		echo "connessione fallita<br>";
		exit;
	}
	echo "chiusa la connessione<br>";
?>