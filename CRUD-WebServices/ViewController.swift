//
//  ViewController.swift
//  CRUD-WebServices
//
//  Created by Francisco on 27/04/20.
//  Copyright © 2020 Francisco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var Productos = [Producto]()
    let dataJsonUrlClass = JsonClass()
    
    
    @IBOutlet weak var idProd: UITextField!
    @IBOutlet weak var nomProd: UITextField!
    @IBOutlet weak var Exist: UITextField!
    @IBOutlet weak var Precio: UITextField!
    
    
    @IBOutlet weak var mensajeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnActualizar(_ sender: Any) {
        
        if idProd.text!.isEmpty || nomProd.text!.isEmpty || Exist.text!.isEmpty || Precio.text!.isEmpty{
                   showAlerta(Titulo: "Validacion de Entrada", Mensaje: "Error faltan de ingresar datos")
                   idProd.becomeFirstResponder()
                   return
               }
               else{
                       let idprod = idProd.text!
                       let nomprod = nomProd.text!
                       let existe = Exist.text!
                       let pre = Precio.text!
                   
                       //Creamos un array (diccionario) de datos para ser enviados en la petición hacia el servidor remoto, aqui pueden existir N cantidad de valores
                   let datos_a_enviar = ["idprod":idprod, "nomProd": nomprod,"existencia":existe,"precio":pre] as NSMutableDictionary
                       
                       //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
                       
                       dataJsonUrlClass.arrayFromJson(url:"WSSwift/updateProducto.php",datos_enviados:datos_a_enviar){ (array_respuesta) in
                           
                           DispatchQueue.main.async {//proceso principal
                               
                               /*
                                recibimos un array de tipo:
                                (
                                    [0] => Array
                                    (
                                        [success] => 200
                                        [message] => Producto Actualizado
                                    )
                                )
                                object(at: 0) as! NSDictionary -> indica que el elemento 0 de nuestro array lo vamos a convertir en un diccionario de datos.
                                */
                               let diccionario_datos = array_respuesta?.object(at: 0) as! NSDictionary
                               
                               //ahora ya podemos acceder a cada valor por medio de su key "forKey"
                               if let msg = diccionario_datos.object(forKey: "message") as! String?{
                                   self.showAlerta(Titulo: "Guardando", Mensaje: msg)
                               }
                               
                               self.idProd.text=""
                               self.nomProd.text = ""
                               self.Exist.text = "0"
                               self.Precio.text = "0"
                           }
                       }
               }// Fin del else

        
    }
    @IBAction func btnBorrar(_ sender: Any) {
        
        if idProd.text!.isEmpty {
                   showAlerta(Titulo: "Validacion de Entrada", Mensaje: "Error faltan de ingresar datos")
                   idProd.becomeFirstResponder()
                   return
               }
               else{
                       let idprod = idProd.text!
                   
                       //Creamos un array (diccionario) de datos para ser enviados en la petición hacia el servidor remoto, aqui pueden existir N cantidad de valores
                   let datos_a_enviar = ["idprod":idprod] as NSMutableDictionary
                       
                       //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
                       
                       dataJsonUrlClass.arrayFromJson(url:"WSSwift/deleteProducto.php",datos_enviados:datos_a_enviar){ (array_respuesta) in
                           
                           DispatchQueue.main.async {//proceso principal
                               
                               /*
                                recibimos un array de tipo:
                                (
                                    [0] => Array
                                    (
                                        [success] => 200
                                        [message] => Producto Actualizado
                                    )
                                )
                                object(at: 0) as! NSDictionary -> indica que el elemento 0 de nuestro array lo vamos a convertir en un diccionario de datos.
                                */
                               let diccionario_datos = array_respuesta?.object(at: 0) as! NSDictionary
                               
                               //ahora ya podemos acceder a cada valor por medio de su key "forKey"
                               if let msg = diccionario_datos.object(forKey: "message") as! String?{
                                   self.showAlerta(Titulo: "Eliminando", Mensaje: msg)
                               }
                               
                               self.idProd.text=""
                               self.nomProd.text = ""
                               self.Exist.text = "0"
                               self.Precio.text = "0"
                           }
                       }
               }// Fin del else

        
    }
    @IBAction func btnAgregar(_ sender: Any) {
        
        if nomProd.text!.isEmpty || Exist.text!.isEmpty || Precio.text!.isEmpty{
            showAlerta(Titulo: "Validacion de Entrada", Mensaje: "Error faltan de ingresar datos")
            nomProd.becomeFirstResponder()
            return
        }
        else{
                //extraemos el valor del campo de texto (ID usuario)
                let nomprod = nomProd.text
                let existe = Exist.text
                let pre = Precio.text
            
            //Creamos un array (diccionario) de datos para ser enviados en la petición hacia el servidor remoto, aqui pueden existir N cantidad de va!lores
            let datos_a_enviar = ["nomProd": nomprod!,"existencia":existe,"precio":pre] as NSMutableDictionary
                
                //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
                
                dataJsonUrlClass.arrayFromJson(url:"WSSwift/insertProducto.php",datos_enviados:datos_a_enviar){ (array_respuesta) in
                    
                    DispatchQueue.main.async {//proceso principal
                        
                        /*
                         recibimos un array de tipo:
                         (
                             [0] => Array
                             (
                                 [success] => 200
                                 [message] => Producto Insertado
                             )
                         )
                         object(at: 0) as! NSDictionary -> indica que el elemento 0 de nuestro array lo vamos a convertir en un diccionario de datos.
                         */
                        let diccionario_datos = array_respuesta?.object(at: 0) as! NSDictionary
                        
                        //ahora ya podemos acceder a cada valor por medio de su key "forKey"
                        if let msg = diccionario_datos.object(forKey: "message") as! String?{
                            self.showAlerta(Titulo: "Guardando", Mensaje: msg)
                        }
                        
                        self.idProd.text=""
                        self.nomProd.text = ""
                        self.Exist.text = "0"
                        self.Precio.text = "0"
                    }
                }
        }// Fin del else

    }
    @IBAction func btnConsultar(_ sender: Any) {
        
        //borramos el contenidod e todos los text
               nomProd.text = ""
               Exist.text = ""
               Precio.text = ""
               
               //extraemos el valor del campo de texto (ID usuario)
               let id_usuario = idProd.text
        
               //si idText.text no tienen ningun valor terminamos la ejecución
               if id_usuario == ""{
                   return
               }
               
               //Creamos un array (diccionario) de datos para ser enviados en la petición hacia el servidor remoto, aqui pueden existir N cantidad de valores
               let datos_a_enviar = ["idprod": id_usuario!] as NSMutableDictionary
               
               //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
               
               dataJsonUrlClass.arrayFromJson(url:"WSSwift/getProducto.php",datos_enviados:datos_a_enviar){ (array_respuesta) in
                   
                   DispatchQueue.main.async {//proceso principal
                       
                       /*
                        recibimos un array de tipo:
                        (
                            [0] => Array
                            (
                                [success] => 200
                                [message] => Producto encontrado
                                [idProd] => 1
                                [nomProd] => Desarmador plus
                                [existencia] => 10
                                [precio] => 80
                            )
                        )
                        object(at: 0) as! NSDictionary -> indica que el elemento 0 de nuestro array lo vamos a convertir en un diccionario de datos.
                        */
                       let diccionario_datos = array_respuesta?.object(at: 0) as! NSDictionary
                       
                       //ahora ya podemos acceder a cada valor por medio de su key "forKey"
                       if let msg = diccionario_datos.object(forKey: "message") as! String?{
                           self.mensajeLabel.text = msg
                    
                       }
                       
                       if let nom = diccionario_datos.object(forKey: "nomProd") as! String?{
                           self.nomProd.text = nom
                       }
                       
                       if let exi = diccionario_datos.object(forKey: "existencia") as! String?{
                           self.Exist.text = exi
                       }
                       
                       if let pre = diccionario_datos.object(forKey: "precio") as! String?{
                           self.Precio.text = pre
                       }
                   }
               }

        
    }
    @IBAction func btnCargarInfo(_ sender: Any) {
        
        Productos.removeAll()
                   let datos_a_enviar = ["id": ""] as NSMutableDictionary
                   
                   //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
                   
                   dataJsonUrlClass.arrayFromJson(url:"WSSwift/getProductos.php",datos_enviados:datos_a_enviar){ (array_respuesta) in
                       
                       DispatchQueue.main.async {//proceso principal
                           
                           /*
                            recibimos un array de tipo:
                            (
                                [0] => Array
                                (
                                    [success] => 200
                                    [message] => Producto encontrado
                                    [idProd] => 1
                                    [nomProd] => Desarmador plus
                                    [existencia] => 10
                                    [precio] => 80
                                )
                            )
                            object(at: 0) as! NSDictionary -> indica que el elemento 0 de nuestro array lo vamos a convertir en un diccionario de datos.
                            */
                           let cuenta = array_respuesta?.count
                           
                           for indice in stride(from: 0, to: cuenta!, by: 1){
                               let product = array_respuesta?.object(at: indice) as! NSDictionary
                               let idprod = product.object(forKey: "idProd") as! String?
                               let nomprod = product.object(forKey: "nomProd") as! String?
                               let existe = product.object(forKey: "existencia") as! String?
                               let pre = product.object(forKey: "precio") as! String?
                               self.Productos.append(Producto(idProd: idprod, nomProd: nomprod, Existencia: existe, Precio: pre) )
                           }
                        self.performSegue(withIdentifier: "segue", sender: self)
                    }
            }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue"{
            let seguex = segue.destination as! TableViewController
            seguex.productos = Productos
        }
    }

    
    func showAlerta(Titulo: String, Mensaje: String ){
           // Crea la alerta
          let alert = UIAlertController(title: Titulo, message: Mensaje, preferredStyle: UIAlertController.Style.alert)
          // Agrega un boton
          alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
         // Muestra la alerta
         self.present(alert, animated: true, completion: nil)
        }
}

