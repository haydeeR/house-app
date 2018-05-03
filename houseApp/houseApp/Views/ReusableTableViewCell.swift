//
//  ReusableTableViewCell.swift
//  houseApp
//
//  Created by Haydee Rodriguez on 4/25/18.
//  Copyright © 2018 Haydee Rodriguez. All rights reserved.
//

import UIKit

class ReusableTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var typeHouse: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var mainHouseImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with house: House) {
        title.text = house.description
        typeHouse.text = house.type
        state.text = house.state
        price.text  = String("$\(house.price)")
        mainHouseImage.image = house.image 
    }
}
