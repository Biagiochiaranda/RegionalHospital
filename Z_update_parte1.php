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
session_start();
	if (isset($_POST['tabella'])) {
		$nome_tabella = $_POST['tabella'];
				
				$conn = "host=localhost port=5432 dbname=ospedali_regionali user=postgres password = unimi";
				$resconn = pg_connect($conn);
		
				if ($resconn === false) {
					$resconn = pg_connection_reset($conn);
					if ($resconn === false) {
						echo "problemi di connessione, errore: ". pg_connection_status;
						exit;
					}
				}
				
				$stm = "select * from ". $nome_tabella;
				$res = pg_query($stm);
				
				if ($stm == false){
					echo "query fallita";
				}
				
				$num_colonne = pg_num_fields($res);
				
				echo "<table>";
				echo "<form action='Z_update_parte2.php' method='POST'>";
				echo "immetti prima i valori con cui selezionare i dati da modificare, poi quelli per la modifica!<br>";
				echo "attenzione: scrivere bene i valori dei campi<br>";
				echo "non è necessario compilarli tutti, basta riempire i piu' importanti<br><br>";
				for ($i=0; $i<$num_colonne; $i++) {
					$colonna = pg_field_name($res, $i);
					$nuova_colonna = "nuov*_". $colonna;
					echo "<tr>";
					echo "<th><label for='".$colonna ."'>".$colonna. "</label></th>";
					echo "<th><input type='text' name='". $colonna. "'><th/>";
					echo "</tr>";
					// nuova colonna (quella dell'update)
					echo "<tr>";
					echo "<th><label for='".$nuova_colonna ."'>".$nuova_colonna. "</label></th>";
					echo "<th><input type='text' name='". $nuova_colonna. "'><th/>";
					echo "</tr>";
				}
				echo "<input type='hidden' name='tabella_utente' value='".$_POST['tabella']."'>";
				echo "<input type='submit' value='spedisci'>";
				echo "<input type='reset' value='resetta'>";
				echo "</form>";
				echo "</table><br><br>";
				
				echo "<table>";
				while ($row = pg_fetch_array($res, null, PGSQL_BOTH)) {
					echo "<tr>";
					for ($i=0; $i<$num_colonne; $i++) {
						echo "<th>".$row[$i]. "</th>";
					}
					echo "</tr>";
				}
				echo "</table><br><br>";

				$close = pg_close($resconn);
				if ($close==false){
					echo "chiusura fallita";
					exit;
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