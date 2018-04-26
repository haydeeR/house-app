//
//  HomeImageTableViewCell.swift
//  houseApp
//
//  Created by Haydee Rodriguez on 4/26/18.
//  Copyright © 2018 Haydee Rodriguez. All rights reserved.
//

import UIKit

class HomeImageTableViewCell: UITableViewCell {

    @IBOutlet weak var housePreview: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWith(_ image: UIImage?) {
        housePreview.image = image ?? #imageLiteral(resourceName: "homedefault")
    }
    
}
