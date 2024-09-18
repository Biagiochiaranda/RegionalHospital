<?php
session_start();

	if (!empty($_POST)) {
		// $_SESSION['tabella_upd'] = $_POST['tabella_utente'];
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
		$update = "set ";
		
		$stmvincoli = <<<sql
			select distinct column_name 
			from information_schema.constraint_column_usage 
			where constraint_name in 
									(select constraint_name from information_schema.table_constraints 
									where constraint_type ilike 'primary key'
									or constraint_type ilike 'foreign key')
		sql;
		
		$revincoli = pg_query($stmvincoli);
		
		if ($revincoli==false) {
			echo "query fallita";
			exit;
		}
		
		$vincoli = array();
		
		while ($row = pg_fetch_array($revincoli, null, PGSQL_BOTH)) {
			array_push($vincoli, $row[0]);
		}
		
		//var_dump($vincoli);
		
		for ($i=0; $i<$colonne; $i++) {
			$colonna = pg_field_name($resupd, $i);
			$nuova_colonna = "nuov*_". $colonna;
			
			if ($_POST[$colonna]!="") {
				$condizione.= $colonna. " = '".$_POST[$colonna]. "' and ";
			}
			if ($_POST[$nuova_colonna]!="") {
				if (!in_array($colonna, $vincoli)) {
					$update.= $colonna. " = '".$_POST[$nuova_colonna]. "', ";
				}
			}
			
		}
		$condizione.= "1=1";
		$_update = substr($update, 0, -2);
		
		if ($_update != "se") {
			$stm_for_upd = "update ". $tabella_corrente. " ".$_update. " ". $condizione;
			$updquery = pg_query($stm_for_upd);
			
			if ($updquery==false) {
				echo "query fallita";
				exit;
			}
			
			echo "aggiornamento riuscito! Torna <a href='schermata_iniziale.php'>qui</a> per vedere il risultato";
			
		} else {
			echo "non è possibile aggiornare i valori<br>";
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
		session_destroy();
	}
?>


