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
	if (isset($_POST['tabella'])) {
		$conn = "host=localhost port=5432 dbname=ospedali_regionali user=postgres password = unimi";
				$resconn = pg_connect($conn);
		
				if ($resconn === false) {
					$resconn = pg_connection_reset($conn);
					if ($resconn === false) {
						echo "problemi di connessione, errore: ". pg_connection_status;
						exit;
					}
				}
				$stm = "select distinct unique_constraint_name from information_schema.referential_constraints where delete_rule ilike 'no action'";
				$res = pg_query($stm);
			
				if ($res == false) {
					echo "problemi con l'esecuzione della query";
				}
				
				$odna = array();
				$cont = 0;
				
				while ($tupla = pg_fetch_array($res, null, PGSQL_BOTH)) {
					$split = explode("_", $tupla[0]);
					$attributo = $split[0];
					$odna[$cont] = $attributo;
					$cont++;
				}
				
				if (in_array($_POST['tabella'], $odna)) {
					echo "<p class='warning'>"."non puoi eliminare dati in questa tabella"."</p>";
				} else {
					$tabella = $_POST['tabella'];
					$stm = "select * from ".$tabella;
					$quer = pg_query($stm);
					
					if ($quer==false) {
						exit();
					}
					
					$campi = pg_num_fields($quer);
					
				echo "<table>";
				echo "<form action='Z_delete_parte2.php' method='POST'>";
				echo "immetti i valori con cui selezionare i dati che vuoi eliminare!<br><br>";
				for ($i=0; $i<$campi; $i++) {
					$colonna = pg_field_name($quer, $i);
					echo "<tr>";
					echo "<th><label for='".$colonna ."'>".$colonna. "</label></th>";
					echo "<th><input type='text' name='". $colonna. "'><th/>";
					echo "</tr>";
				}
				echo "<input type='hidden' name='tabella_utente' value='".$_POST['tabella']."'>";
				echo "<input type='submit' value='spedisci'>";
				echo "<input type='reset' value='resetta'>";
				echo "</form>";
				echo "</table><br><br>";
				
				echo "<table>";
				while ($row = pg_fetch_array($quer, null, PGSQL_BOTH)) {
					echo "<tr>";
					for ($i=0; $i<$campi; $i++) {
						echo "<th>".$row[$i]. "</th>";
					}
					echo "</tr>";
				}
				echo "</table><br><br>";
				
				}
				
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