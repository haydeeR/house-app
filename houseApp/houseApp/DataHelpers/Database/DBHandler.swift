//
//  DBHandler.swift
//  houseApp
//
//  Created by Haydee Rodriguez on 4/24/18.
//  Copyright © 2018 Haydee Rodriguez. All rights reserved.
//

import Foundation
import FirebaseDatabase
import PromiseKit

struct DBHandler {
    static let houses = Database.database().reference(withPath: FirebasePath.houses.rawValue)
    static let users = Database.database().reference(withPath: FirebasePath.users.rawValue)
    static let favoriteHouses = Database.database().reference(withPath: FirebasePath.favoriteHouses.rawValue)
    static let pictures = Database.database().reference(withPath: FirebasePath.pictures.rawValue)
    
    static func getLists() -> Promise <[[String: Any]]> {
        return Promise { resolve in
            houses.observe(.value, with: { snapshot in
                let data = snapshot.value as? [String: Any] ?? [:]
                var houselistDictArray: [[String: Any]] = []
                for snData in data {
                    if let movieListData = snData.value as? [String: Any] {
                        houselistDictArray.append(movieListData)
                    }
                }
                resolve.fulfill(houselistDictArray)
            })
        }
    }
    
    static func setMovieWatched(movieId: String, watched: Bool) {
        guard let userId = AuthHandler.getCurrentAuth() else {
            return
        }
        
        let watchRef = houses.child(movieId)
            .child(FirebasePath.houses.rawValue)
            .child(userId)
            .child(FirebasePath.users.rawValue)
        
        if watched {
            watchRef.setValue(true)
        } else {
            watchRef.removeValue()
        }
    }
}
