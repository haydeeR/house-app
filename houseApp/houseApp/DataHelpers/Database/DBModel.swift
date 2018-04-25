//
//  DBModel.swift
//  houseApp
//
//  Created by Haydee Rodriguez on 4/24/18.
//  Copyright © 2018 Haydee Rodriguez. All rights reserved.
//

import Foundation
protocol DBModel {
    var id: String { get set }
    func toDictionary() -> [String: Any]
}
