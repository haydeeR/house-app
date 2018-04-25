//
//  ParseHandler.swift
//  houseApp
//
//  Created by Haydee Rodriguez on 4/25/18.
//  Copyright © 2018 Haydee Rodriguez. All rights reserved.
//

import Foundation
import PromiseKit
import ObjectMapper

struct ParseHandler {
    
    static func parseHouseList(with data: [[String: Any]]) -> [House] {
        var lists = [House]()
        lists = Mapper<House>().mapArray(JSONArray: data)
        return lists
    }
}
