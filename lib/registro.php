<?php

require "conexion.php";
    
    $nombre = $_POST['nombre'];
    $contrasenia = $_POST['contrasenia'];
    
    $sql = "SELECT * FROM usuarios WHERE nombre='".$usuario."' AND contrasenia = '".$contrasenia."'";
   
    $result = mysqli_query($db, $sql);
    $count = mysqli_num_rows($result);

    if ($count == 1) {
        echo json_encode("Error");
    }else {
        $insert = "INSERT INTO login(nombre, contrasenia)VALUES('".$nombre."','".$contrasenia."')";
        $query = mysqli_query($db, $insert);
        if ($query) {
            echo json_encode("success");
        }
    }

?>