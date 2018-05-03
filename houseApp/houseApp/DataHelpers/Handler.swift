//
//  Handler.swift
//  houseApp
//
//  Created by Haydee Rodriguez on 4/25/18.
//  Copyright © 2018 Haydee Rodriguez. All rights reserved.
//

import Foundation
import PromiseKit

struct Handler {
    
    static func getLists() -> Promise <[House]> {
        return DBHandler.getLists().map { data -> [House] in
            return ParseHandler.parseHouseList(with: data)
        }
    }
    
    static func getHousesByLocation(by latitud: Double, longitud: Double) -> Promise <[House]> {
        return DBHandler.getHouses(by: latitud, longitud: longitud).map { data -> [House] in
            return ParseHandler.parseHouseList(with: data)
        }
    }
    
    static func getHouseImage(houseId: String, completionHandler: @escaping (UIImage?, Error?) -> ()) {
        DBHandler.getHouseImage(houseId: houseId) { data, error in
            if let data = data {
                completionHandler(UIImage.init(data: data), error)
            } else {
                completionHandler(nil, error)
            }
        }
    }
}
