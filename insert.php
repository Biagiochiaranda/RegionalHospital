<?php
	if (!empty($_POST)) {
		$tabella_corrente = $_POST["tabella_utente"];
		
		$conn = "host=localhost port=5432 dbname=ospedali_regionali user=postgres password=unimi";
		$resconn = pg_connect($conn);
		
		if ($resconn === false) {
			$resconn = pg_connection_reset($conn);
			if ($resconn === false) {
				echo "problemi di connessione, errore: " . pg_last_error();
				exit;
			}
		}
		
		$stmins = "select * from ". $tabella_corrente;
		$resins = pg_query($stmins);
		
		if ($resins == false) {
			echo "query fallita: " . pg_last_error($resconn);
			exit;
		}
		
		$colonne = pg_num_fields($resins);
		$inserimento = "insert into ".$tabella_corrente." values(";
		$novalue= "";
		
		for ($i = 0; $i < $colonne; $i++) {
			$colonna = pg_field_name($resins, $i);
			
			if ($_POST[$colonna]!= "") {
				$inserimento.= "'". $_POST[$colonna]."', ";
				$novalue.= $colonna."_";
			} else {
				$inserimento .= "NULL, "; // Se il campo è vuoto, inserisce NULL senza apici
			}
				
		}
		
		$_inserimento = substr($inserimento, 0, -2);
		$_inserimento .= ")";
		
		if ($novalue == "") {
			echo "non hai inserito nessun valore <a href='schermata_iniziale.php'>torna qui</a>";
		} else {
			$querstm = pg_query($resconn, $_inserimento);
		
			if ($querstm == false) {
				echo "Query fallita: " . pg_last_error($resconn) . "<br>Query: " . $inserimento;				
				exit;
			}
			echo "inserimento riuscito! Torna <a href='schermata_iniziale.php'>qui</a> per vedere il risultato";
		}
		
	} else {
		$conn = "host=localhost port=5432 dbname=ospedali_regionali user=postgres password=unimi";
		$resconn = pg_connect($conn);
		
		if ($resconn === false) {
			$resconn = pg_connection_reset($conn);
			if ($resconn === false) {
				echo "problemi di connessione, errore: " . pg_last_error();
				exit;
			}
		}
		
		$statement = "select table_name from information_schema.tables where table_schema = 'public' order by 1";
		$query = pg_query($resconn, $statement);
					
		if ($query == false) {
			echo "problemi con l'esecuzione di una richiesta da parte del database: " . pg_last_error($resconn);
			exit;
		}
		
		echo "<table>";
		echo "<th>";	
		echo "<form method='POST' action='schermata_iniziale.php'>";
					
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
		while ($tupla = pg_fetch_array($query, null, PGSQL_BOTH)) {
			echo "<option value=" . $tupla[0] . ">" . $tupla[0] . "</option>";
			$cont++;
		}
		echo "</select>";
				
		echo "<button type='submit'> invia i dati</button>";
					
		echo "</form>";
		echo "</th>";
		echo "</table>";
			
		$close = pg_close($resconn);
		if ($close == false) {
			echo "chiusura fallita: " . pg_last_error($resconn);
			exit;
		}
	}
?>
