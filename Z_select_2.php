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
				
				$tabella = $_POST['tabella'];
					// query
					// $stm = "select * from ".$tabella;
					$pieces = explode("-", $tabella);					
					
					// tutte le stanze in quel reparto con relative informazioni
					// $stm = "select * from reparto join ospedale on codice = codice_ospedale join ambulatoriointerno a on nome_reparto=reparto.nome and cod_ospedale = codice where reparto.nome = '".$pieces[0]. "' and codice_ospedale = '".$pieces[1]."'";
					
					// tutte le persone ricoverate in in quel reparto
					$elenco_select = "codice_fiscale, cognome, p.nome, p.indirizzo, data_nascita, nome_reparto, codice_ospedale, ospedale.nome, ospedale.indirizzo, sala_ricovero, inizio_ricovero, fine_ricovero";
					$elenco_from = "ricovero ri join paziente p on paziente_ricoverato = codice_fiscale join ospedale on ri.codice_ospedale = codice";
					if (count($pieces) == 3) {
						$elenco_where = "nome_reparto ='".$pieces[1]." ". $pieces[2]."' and ri.codice_ospedale = '".$pieces[0] ."'";
					} else {
						$elenco_where = "nome_reparto ='".$pieces[1] ."' and ri.codice_ospedale = '".$pieces[0] ."'";						
					}
					$stm = "select ".$elenco_select. " from ".$elenco_from ." where ".$elenco_where;
					$quer = pg_query($stm);
					
					if ($quer==false) {
						exit();
					}
				$campi = pg_num_fields($quer);
				
			echo "<table>";
				echo "<tr>";
				for ($i =0; $i<$campi; $i++) {
					$fieldname = pg_field_name($quer, $i);
					echo "<th>".$fieldname ."</th>";
				}
				echo "</tr>";
				while ($row = pg_fetch_array($quer, null, PGSQL_BOTH)) {
					echo "<tr>";
					for ($i=0; $i<$campi; $i++) {
						echo "<th>".$row[$i]."</th>";
					}
					echo "</tr>";
				}
			echo "</table><br><br>";
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
				
				// query
				// $statement = "select table_name from information_schema.tables where table_schema = 'public' and table_name <> 'login' order by 1";
					$statement = "select r.nome, o.nome, indirizzo, codice from reparto r join ospedale o on codice_ospedale = codice";
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
							if (count(explode(" ", $tupla[0])) > 1) {
								$reparto = explode(" ", $tupla[0]);
								$nome_reparto = $reparto[0]."-".$reparto[1];
								echo "<option value=" .$tupla[3]."-".$nome_reparto. ">". $tupla[0]." (".$tupla[1] .": ".$tupla[2] .")</option>";
							} else {
								echo "<option value=" .$tupla[3]."-".$tupla[0]. ">". $tupla[0]." (".$tupla[1] .": ".$tupla[2] .")</option>";
							}
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