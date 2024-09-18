<html>
<head>
	<style type="text/css">
	form {
		position: absolute;
		top: 40%;
		left: 20%;
	}
	select {
		background-color: grey;
		font-size: 200%;
		padding: 8px;
		margin: 1px;
	}
	button {
		font-size: 200%;
		padding: 8px;
		margin: 1px;
	}
	.warning {
		position: absolute;
		top: 30%;
		left: 15%;
		font-size: 400%;
	}
	.hold {
		width: 250px;
		height:30px;
	}
	tr, th {
		border: 1px solid black;
	}
	</style>
</head>
<body>
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
		
		$stmins = "select * from ". $tabella_corrente;
		$resins = pg_query($stmins);
		
		if ($resins==false) {
			echo "query fallita";
			exit;
		}
		
		$colonne = pg_num_fields($resins);
		$inserimento = "insert into ".$tabella_corrente." values(";
		$novalue= "";
		
		for ($i=0; $i<$colonne; $i++) {
			$colonna = pg_field_name($resins, $i);
			
			if ($_POST[$colonna]!="") {
				$inserimento.= "'". $_POST[$colonna]."', ";
				$novalue.= $colonna."_";
			}	
		}
		
		$_inserimento = substr($inserimento, 0, -2);
		$_inserimento.= ")";
		
		if ($novalue == "") {
			echo "non hai inserito nessun valore <a href='Z_insert_parte1.php'>torna_qui</a>";
		} else {
		$querstm = pg_query($_inserimento);
		
		if ($querstm==false) {
			echo "query fallita";
			exit;
		}
		echo "inserimento riuscito! Torna <a href='Z_select.php'>qui</a> alla voce <b>".$tabella_corrente ."</b> per vedere il risultato";
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
				
				$statement = "select table_name from information_schema.tables where table_schema = 'public' and table_name <> 'login' order by 1";
					$query = pg_query($statement);
						
				if ($query == false) {
					echo "problemi con l'esecuzione di una richiesta da parte del database";
					exit;
				}
				
				echo "<table>";
				echo "<th>";	
				echo "<form method='POST' action='$_SERVER[PHP_SELF]'>";
						
					/*$select = <<<form
						<select name="operazioni">
							<option value="select">visualizza dati da</option>
							<option value="update">modifica informazioni</option>
							<option value="insert">inserisci in</option>
							<option value="delete">elimina da</option>
						</select>
					form;
					
					echo $select;
					*/
					
					echo "<select name='tabella'>";
						$cont = 0;
							while($tupla = pg_fetch_array($query, null, PGSQL_BOTH)) {
							echo "<option value=" .$tupla[0]. ">". $tupla[0]. "</option>";
							$cont++;
						}
					echo "</select>";
					
					echo "<button type='submit'> invio </input>";
						
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
</body>