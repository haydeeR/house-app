//
//  House.swift
//  houseApp
//
//  Created by Haydee Rodriguez on 4/25/18.
//  Copyright © 2018 Haydee Rodriguez. All rights reserved.
//

import Foundation
import ObjectMapper

class House: Mappable {
    var address: String = ""
    var state: String = ""
    var city: String = ""
    var description: String = ""
    var price: Int = 0
    var location: Location = Location(longitude: 0, latitude: 0)
    var image: UIImage?
    var id: String = ""
    var type: String = ""
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        address         <- map["address"]
        state           <- map["state"]
        city            <- map["city"]
        description     <- map["description"]
        price           <- map["price"]
        location        <- map["location"]
        id              <- map["id"]
        type            <- map["type"]
    }
    
    func toDictionary() -> [String: Any] {
        return ["address": address,
                "state": state,
                "city": city,
                "description": description,
                "price": price,
                "type": type,
                "location": ["latitude": location.latitude, "longitude": location.longitude]]
    }
}


