//
//  TableViewCell.swift
//  CRUD-WebServices
//
//  Created by Francisco on 29/04/20.
//  Copyright © 2020 Francisco. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var Titulo: UILabel!
    @IBOutlet weak var subTitulo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
