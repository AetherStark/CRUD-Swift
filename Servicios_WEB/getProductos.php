<?php
/*
 * El siguiente código localiza los productos
 * Stark Abril/2020
 */
$response = array();
$Cn = mysqli_connect("localhost", "root", "", "inventario") or die("server no encontrado");
mysqli_set_charset($Cn, "utf8");
if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $result = mysqli_query($Cn, "SELECT idprod,nomProd,existencia,precio FROM productos ORDER BY nomProd");
    if (!empty($result)) {
        if (mysqli_num_rows($result) > 0) {
            while ($res = mysqli_fetch_array($result)) {
                $producto = array();
                $producto["success"] = 200;
                $producto["message"] = "Producto encontrado";
                $producto["idprod"] = $res["idprod"];
                $producto["nomProd"] = $res["nomProd"];
                $producto["existencia"] = $res["existencia"];
                $producto["precio"] = $res["precio"];
                array_push($response, $producto);
            }
            echo json_encode($response);
        } else {
            $producto = array();
            $producto["success"] = 404; //No encontro información y el success = 0 indica no exitoso
            $producto["message"] = "Producto no encontrado";
            array_push($response, $producto);
            echo json_encode($response);
        }
    } else {
        $producto = array();
        $producto["success"] = 404; //No encontro información y el success = 0 indica no exitoso
        $producto["message"] = "Producto no encontrado";
        array_push($response, $producto);
        echo json_encode($response);
    }
} else {
    $producto = array();
    $producto["success"] = 400;
    $producto["message"] = "Faltan Datos entrada";
    array_push($response, $producto);
    echo json_encode($response);
}
mysqli_close($Cn);
