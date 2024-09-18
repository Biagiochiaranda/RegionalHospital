<!DOCTYPE html>
<html lang="it">

<head>
    <meta charset="UTF-8">
    <title>Visualizzazione Operazioni per Medico</title>
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 80%;
            max-width: 800px;
            text-align: center;
        }

        form {
            margin-bottom: 20px;
        }

        select {
            background-color: #ffffff;
            color: #333;
            font-size: 1.2em;
            padding: 10px;
            margin: 10px 0;
            width: calc(100% - 22px);
            border: 2px solid #ccc;
            border-radius: 4px;
        }

        button {
            font-size: 1.2em;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #45a049;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th,
        td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        h1 {
            font-size: 2.5em;
            margin-bottom: 20px;
        }
    </style>
</head>

<body>
	<?php
	$conn = "host=localhost port=5432 dbname=ospedali_regionali user=postgres password=unimi";

	if (isset($_POST['medico'])) {
		$resconn = pg_connect($conn);

		if ($resconn === false) {
			echo "Problemi di connessione, errore: " . pg_last_error();
			exit;
		}

		$medico = pg_escape_string($resconn, $_POST['medico']);

		// Query per ottenere le informazioni sulle fasi delle operazioni chirurgiche
		$stm = "
	select distinct f.ordine, f.nota, o.data_oper, o.codice, o.cf , m.codice_medico
	from medico_operazione m
	join operazionechirurgica o 
	on m.codice_operazione = codice
	join fase f
	on o.codice = f.codice
    WHERE m.codice_medico = '$medico'
    ";
		$quer = pg_query($resconn, $stm);

		if ($quer === false) {
			echo "Errore nell'esecuzione della query: " . pg_last_error();
			exit;
		}

		$campi = pg_num_fields($quer);

		echo "<table>";
		echo "<tr>";
		for ($i = 0; $i < $campi; $i++) {
			$fieldname = pg_field_name($quer, $i);
			echo "<th>" . htmlspecialchars($fieldname) . "</th>";
		}
		echo "</tr>";

		while ($row = pg_fetch_array($quer, null, PGSQL_ASSOC)) {
			echo "<tr>";
			foreach ($row as $cell) {
				echo "<td>" . htmlspecialchars($cell) . "</td>";
			}
			echo "</tr>";
		}
		echo "</table>";

		pg_close($resconn);
	} else {
		$resconn = pg_connect($conn);

		if ($resconn === false) {
			echo "Problemi di connessione, errore: " . pg_last_error();
			exit;
		}

		// Query per ottenere l'elenco dei medici
		$statement = "SELECT cod_ospedaliero FROM personalemedico";
		$query = pg_query($resconn, $statement);

		if ($query === false) {
			echo "Problemi con l'esecuzione di una richiesta da parte del database: " . pg_last_error();
			exit;
		}

		echo "<h1>Seleziona Medico</h1>";
		echo "<form method='POST' action=''>";
		echo "<select name='medico'>";
		while ($tupla = pg_fetch_array($query, null, PGSQL_ASSOC)) {
			//qui per prendere l'opzione che ti interessa, stai attento a come nominimi gli attributi 
			echo "<option value='" . htmlspecialchars($tupla['cod_ospedaliero']) . "'>" . htmlspecialchars($tupla['cod_ospedaliero']) . "</option>";
		}
		echo "</select>";
		echo "<button type='submit'>Invio</button>";
		echo "</form>";

		pg_close($resconn);
	}
	?>
</body>

</html>
