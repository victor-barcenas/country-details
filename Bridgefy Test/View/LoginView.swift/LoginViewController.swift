//
//  ViewController.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 23/09/22.
//

import UIKit

class LoginViewController: KeyboardController {
    
    weak var logoImageView: UIImageView!
    weak var emailField: PaddedTextField!
    weak var passwordField: PaddedTextField!
    weak var signinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInAction(_ sender: Any) {
        print("signin tapped")
    }
}

