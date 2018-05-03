//
//  Location.swift
//  houseApp
//
//  Created by Haydee Rodriguez on 4/25/18.
//  Copyright © 2018 Haydee Rodriguez. All rights reserved.
//

import Foundation
import ObjectMapper

class Location: Mappable {
    
    var longitude: Double?
    var latitude: Double?
    
    init(longitude: Double, latitude: Double) {
        self.longitude = longitude
        self.latitude = latitude
    }
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        longitude   <- map["longitud"]
        latitude    <- map["latitud"]
    }
}
