<?php

$db = new mysqli("localhost","root","3123", "usuariosvisor");
    
    if($mysqli->connect_errno) {
        die("Fallo la conexion");
    } else {
        echo "Conexion exitosa";
    }

?>