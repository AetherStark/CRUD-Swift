<?php
/*
 * El siguiente código Inserta un producto
 * Stark Abril/2020
 */
$response = array();
$producto = array();
$Cn = mysqli_connect("localhost", "root", "", "inventario") or die("server no encontrado");
mysqli_set_charset($Cn, "utf8");
// Checa que le este llegando por el método POST el nomProd,existencia y precio
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $objArray = json_decode(file_get_contents("php://input"), true);
    if (empty($objArray)) {
        // required field is missing
        $producto["success"] = 400;
        $producto["message"] = "Faltan Datos entrada";
        array_push($response, $producto);
        echo json_encode($response);
    } else {
        $nomprod = $objArray['nomProd'];
        $existe = $objArray['existencia'];
        $precio = $objArray['precio'];
        $result = mysqli_query($Cn, "INSERT INTO productos(nomProd,existencia,precio) values ('$nomprod',$existe,$precio)");
        //$idprod = mysqli_insert_id($Cn);
        if ($result) {
            $producto["success"] = 200; // El success=200 es que encontro eñ producto
            $producto["message"] = "Producto Insertado";
            array_push($response, $producto);
            echo json_encode($response);
        } else {
            //
            $producto["success"] = 406;
            $producto["message"] = "Producto no Insertado";
            array_push($response, $producto);
            echo json_encode($response);
        }
    }
} else {
    // required field is missing
    $producto["success"] = 400;
    $producto["message"] = "Faltan Datos entrada";
    array_push($response, $producto);
    echo json_encode($response);
}
mysqli_close($Cn);
