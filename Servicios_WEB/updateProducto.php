<?php
/*
 * El siguiente código Actualiza un producto
 * AGZ Abril/2020
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
        $idprod = $objArray['idprod'];
        $nomprod = $objArray['nomProd'];
        $existe = $objArray['existencia'];
        $precio = $objArray['precio'];
        $result = mysqli_query($Cn, "UPDATE productos SET nomProd='$nomprod',existencia=$existe,precio=$precio WHERE idprod=$idprod");
        if ($result) {
            $producto["success"] = 200; // El success=200 es que encontro eñ producto
            $producto["message"] = "Producto Actualizado";
            array_push($response, $producto);
            echo json_encode($response);
        } else {
            $producto["success"] = 406;
            $producto["message"] = "El Producto no se actualizo";
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
