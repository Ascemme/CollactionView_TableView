//
//  CustomTableViewCell.swift
//  newApp_with_Api
//
//  Created by Temur on 07/01/2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var CellImage: UIImageView!
    
    @IBOutlet weak var CellNameLable: UILabel!
    
    @IBOutlet weak var CellAgeLable: UILabel!
    
    @IBOutlet weak var CellSexLabele: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
