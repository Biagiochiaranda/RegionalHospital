<!DOCTYPE html>
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
    tr, th, td {
        border: 1px solid black;
        padding: 5px;
    }
    table {
        margin-top: 20px;
    }
    </style>
</head>
<body>
    <?php
    session_start();
    if (isset($_SESSION['user'])) {
        $conn = "host=localhost port=5432 dbname=ospedali_regionali user=postgres password=unimi";
        $resconn = pg_connect($conn);

        if ($resconn === false) {
            echo "Problemi di connessione, errore: " . pg_last_error();
            exit;
        }

        // Query per ottenere informazioni sui medici assunti che hanno svolto il tirocinio nello stesso reparto
        $stm = "select distinct f.ordine, f.nota, o.data_oper, o.codice, o.cf , m.codice_medico
        from medico_operazione m
        join operazionechirurgica o 
        on m.codice_operazione = codice
        join fase f
        on o.codice = f.codice
        ;";

        $quer = pg_query($resconn, $stm);

        if ($quer == false) {
            echo "Query fallita: " . pg_last_error($resconn);
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
        while ($row = pg_fetch_array($quer, null, PGSQL_BOTH)) {
            echo "<tr>";
            for ($i = 0; $i < $campi; $i++) {
                echo "<td>" . htmlspecialchars($row[$i]) . "</td>";
            }
            echo "</tr>";
        }
        echo "</table><br><br>";

        pg_close($resconn);
    } else {
        echo "Vai alla pagina di <a href='autenticazione.html'>registrazione</a>";
        session_destroy();
    }
    ?>
</body>
</html>

