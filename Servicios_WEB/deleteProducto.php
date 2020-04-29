<?php
/*
 * El siguiente código Elimina un producto
 * AGZ Sept/2019
 */
$response = array();
$producto = array();
$Cn = mysqli_connect("localhost", "root", "", "inventario") or die("server no encontrado");
mysqli_set_charset($Cn, "utf8");
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $objArray = json_decode(file_get_contents("php://input"), true);
    if (empty($objArray)) {
        // required field is missing
        $producto["success"] = 400;
        $producto["message"] = "Faltan Datos entrada";
        array_push($response, $producto);
        echo json_encode($response);
    } else {
        $idProd = $objArray['idprod'];
        $result = mysqli_query($Cn, "DELETE FROM productos WHERE idprod=$idProd");
        if ($result) {
            $producto["success"] = 200; // El success=200 es que encontro eñ producto
            $producto["message"] = "Producto Eliminado";
            array_push($response, $producto);
            echo json_encode($response);
        } else {
            //
            $producto["success"] = 406;
            $producto["message"] = "El Producto no se Elimino";
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
