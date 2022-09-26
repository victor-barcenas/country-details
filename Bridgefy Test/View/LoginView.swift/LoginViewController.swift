//
//  ViewController.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 23/09/22.
//

import UIKit

class LoginViewController: KeyboardController, ActivityIndicatable {
    
    weak var logoImageView: UIImageView!
    weak var emailField: PaddedTextField!
    weak var passwordField: PaddedTextField!
    weak var signinButton: UIButton!
    
    private var viewModel: LoginViewModel!
    
    init(_ viewmodel: LoginViewModel) {
        self.viewModel = viewmodel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInAction(_ sender: Any) {
        guard let username = emailField.text,
              let password = passwordField.text,
                username.count > 0,
                password.count > 0 else {
            showMessage("You must provide both, username and password",
                        title: "Error")
            return
        }
        let user = User(username: username, password: password)
        startLoading(with: "Signin in...")
        viewModel.login(user) { [weak self] response in
            self?.stopLoading()
            switch response {
            case .success(_):
                let tabViewBuilder = TabViewBuilder()
                self?.transition(to: tabViewBuilder.build())
            case .failure(let error):
                self?.showMessage(error.message, title: "Error")
            }
        }
    }
}

