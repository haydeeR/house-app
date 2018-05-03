//
//  HouseMarket.swift
//  houseApp
//
//  Created by Haydee Rodriguez on 4/26/18.
//  Copyright © 2018 Haydee Rodriguez. All rights reserved.
//

import UIKit
import MapKit

class HouseMarket: MKPointAnnotation {

    var marketColor: UIColor
    
    init(house: House) {
        marketColor = .purple
        super.init()
        self.title = house.description
        self.subtitle = house.address
    }
}
