<?php
/*
 * El siguiente código localiza un producto
 * Stark Abril/2020
 */
$response = array();
$producto = array();
$Cn = mysqli_connect("localhost", "root", "", "inventario") or die("server no encontrado");
mysqli_set_charset($Cn, "utf8");
// Checa que le este llegando por el método POST el idProd
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $objArray = json_decode(file_get_contents("php://input"), true);

    $idprod = $objArray['idprod'];
    $result = mysqli_query($Cn, "SELECT idprod,nomProd,existencia,precio from productos WHERE idprod = $idprod");
    if (!empty($result)) {
        if (mysqli_num_rows($result) > 0) {
            $result = mysqli_fetch_array($result);
            $producto["success"] = 200; // El success=200 es que encontro el producto
            $producto["message"] = "Producto encontrado";
            $producto["idprod"] = $result["idprod"];
            $producto["nomProd"] = $result["nomProd"];
            $producto["existencia"] = $result["existencia"];
            $producto["precio"] = $result["precio"];
            array_push($response, $producto);
            // codifica la información en formato de JSON response
            echo json_encode($response);
        } else {
            // No Encontro el producto
            $producto["success"] = 404; //No encontro información y el success = 0 indica no exitoso
            $producto["message"] = "Producto no encontrado";
            array_push($response, $producto);
            echo json_encode($response);
        }
    } else {
        $producto["success"] = 404; //No encontro información y el success = 0 indica no exitoso
        $producto["message"] = "Producto no encontrado";
        array_push($response, $producto);
        echo json_encode($response);
    }
} else {
    // required field is missing
    $producto["success"] = 400;
    $producto["message"] = "Faltan Datos entrada";
    array_push($response, $producto);
    echo json_encode($response);
}
mysqli_close($Cn);
