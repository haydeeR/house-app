//
//  UICollectionView+ReusableId.swift
//  houseApp
//
//  Created by Haydee Rodriguez on 4/24/18.
//  Copyright © 2018 Haydee Rodriguez. All rights reserved.
//

import UIKit

extension UIViewController {
    static var reusableId: String {
        return String(describing: self)
    }
}
