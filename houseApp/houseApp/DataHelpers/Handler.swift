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
    
    static func getHouseImage(house: House, completionHandler: @escaping (UIImage?, Error?) -> ()) {
        DBHandler.getHouseImage(house: house) { data, error in
            if let data = data {
                completionHandler(UIImage.init(data: data), error)
            } else {
                completionHandler(nil, error)
            }
        }
    }
}
