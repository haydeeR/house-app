//
//  UITableViewCell.swift
//  houseApp
//
//  Created by Haydee Rodriguez on 4/25/18.
//  Copyright © 2018 Haydee Rodriguez. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var reusableId: String {
        return String(describing: self)
    }
}
