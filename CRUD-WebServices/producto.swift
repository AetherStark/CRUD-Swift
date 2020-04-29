//
//  producto.swift
//  CRUD-WebServices
//
//  Created by Francisco on 29/04/20.
//  Copyright © 2020 Francisco. All rights reserved.
//

import Foundation
class Producto {
    
    var idprod: String?
    var nomprod: String?
    var existe: String?
    var pre: String?
    
    init(idProd: String?, nomProd: String?, Existencia: String?, Precio: String?) {
        self.idprod  = idProd
        self.nomprod = nomProd
        self.existe = Existencia
        self.pre = Precio
    }
}
