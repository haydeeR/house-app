//
//  AuthHandler.swift
//  houseApp
//
//  Created by Haydee Rodriguez on 4/24/18.
//  Copyright © 2018 Haydee Rodriguez. All rights reserved.
//

import Foundation
import Firebase
import FacebookCore
import FacebookLogin
import UIKit

struct AuthHandler {
    
    static func facebookLogin(loginVC: LoginViewController) {
        let fbLoginManager = LoginManager()
        fbLoginManager.logIn(readPermissions: [.publicProfile, .email], viewController: loginVC) { (loginResult) in
            switch loginResult {
            case .failed:
                print("Hay un error")
            case .cancelled:
                print("fue cancelado")
            case .success(grantedPermissions: _, _, let token):
                successLogin(loginVC: loginVC, token: token.authenticationToken)
            }
        }
    }
    
    static func successLogin(loginVC: LoginViewController, token: String) {
        let credential = FacebookAuthProvider.credential(withAccessToken: token)
        Auth.auth().signIn(with: credential) { (_, error) in
            if let error = error {
                print(error)
            }
         //   loginVC.changeView(with: StoryboardPath.main.rawValue, viewControllerName: ViewControllerPath.homeViewController.rawValue)
        }
    }
    
    static func getCurrentAuth() -> String? {
        if let currentUser = Auth.auth().currentUser {
            return currentUser.uid
        } else {
            return nil
        }
    }
    
    static func getUserInfo(onSuccess: @escaping ([String: Any]?) -> Void, onFailure: @escaping (Error) -> Void) {
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "me", parameters: ["fields": "id, first_name, last_name"],accessToken: AccessToken.current, httpMethod: .GET, apiVersion: .defaultVersion)) { _, result in
                                        switch result {
                                        case .success(let response):
                                            onSuccess(response.dictionaryValue)
                                        case .failed(let error):
                                            onFailure(error)
                                        }
        }
        connection.start()
    }
    
    static func getProviderId(for provider: String) -> String? {
        guard let providerData = Auth.auth().currentUser?.providerData else {
            return nil
        }
        for providerInfo in providerData where providerInfo.providerID == provider {
            return providerInfo.uid
        }
        return nil
    }
    
    static func getUrlImageProfile() -> URL? {
        if let fbId = getProviderId(for: "facebook.com") {
            return URL(string: "https://graph.facebook.com/\(fbId)/picture?type=large")!
        } else {
            return nil
        }
    }
}
