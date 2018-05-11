//
//  ViewController.swift
//  houseApp
//
//  Created by Haydee Rodriguez on 4/24/18.
//  Copyright © 2018 Haydee Rodriguez. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBAction func loginFBButton(_ sender: UIButton) {
        AuthHandler.facebookLogin(loginVC: self)
    }
}

