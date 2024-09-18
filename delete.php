<?php
	if (!empty($_POST)) {
		$tabella_corrente = $_POST["tabella_utente"];
		
		$conn = "host=localhost port=5432 dbname=ospedali_regionali user=postgres password = unimi";
			$resconn = pg_connect($conn);
		
			if ($resconn === false) {
				$resconn = pg_connection_reset($conn);
				if ($resconn === false) {
					echo "problemi di connessione, errore: ". pg_connection_status;
					exit;
				}
			}
		
		$stmupd = "select * from ". $tabella_corrente;
		$resupd = pg_query($stmupd);
		
		if ($resupd==false) {
			echo "query fallita";
			exit;
		}
		
		$colonne = pg_num_fields($resupd);
		$condizione = "where ";
		$novalue ="";
		
		for ($i=0; $i<$colonne; $i++) {
			$colonna = pg_field_name($resupd, $i);
			
			if ($_POST[$colonna]!="") {
				$condizione.= $colonna. " = '".$_POST[$colonna]. "' and ";
				$novalue.= $colonna."_";
			}	
		}
		$condizione.= "1=1";
		
		if ($novalue == "") {
			echo "non risultano dati passati";
		} else {
		
		$statement = "delete from ". $tabella_corrente." ".$condizione;
		$querstm = pg_query($statement);
		
		if ($querstm==false) {
			echo "query fallita";
			exit;
		}
		
		echo "eliminazione riuscita! Torna <a href='schermata_iniziale.php'>qui</a> per vedere il risultato";
		}
		
	} else {
		$conn = "host=localhost port=5432 dbname=ospedali_regionali user=postgres password = unimi";
			$resconn = pg_connect($conn);
		
			if ($resconn === false) {
				$resconn = pg_connection_reset($conn);
				if ($resconn === false) {
					echo "problemi di connessione, errore: ". pg_connection_status;
					exit;
				}
			}
			
			$statement = "select table_name from information_schema.tables where table_schema = 'public' order by 1";
				$query = pg_query($statement);
					
			if ($query == false) {
				echo "problemi con l'esecuzione di una richiesta da parte del database";
				exit;
			}
			
			echo "<table>";
			echo "<th>";	
			echo "<form method='POST' action='$_SERVER[PHP_SELF]'>";
					
				$select = <<<form
					<select name="operazioni">
						<option value="select">visualizza dati da</option>
						<option value="update">modifica informazioni</option>
						<option value="insert">inserisci in</option>
						<option value="delete">elimina da</option>
					</select>
				form;
				
				echo $select;
				
				echo "<select name='tabella'>";
					$cont = 0;
						while($tupla = pg_fetch_array($query, null, PGSQL_BOTH)) {
						echo "<option value=" .$tupla[0]. ">". $tupla[0]. "</option>";
						$cont++;
					}
				echo "</select>";
				
				echo "<button type='submit'> invia i dati</input>";
					
			echo "</form>";
			echo "</th>";
			echo "</table>";
			
			$close = pg_close($resconn);
				if ($close==false){
					echo "chiusura fallita";
				exit;
			}
	}
?>