//
//  LoginBuilder.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 23/09/22.
//

import UIKit

final class LoginBuilder {
    private let loginViewController = LoginViewController()
    
    func build() -> LoginViewController {
        loginViewController.setRootView()
        loginViewController.logoImageView =  configureLogo()
        loginViewController.signinButton = configureSigninButton()
        loginViewController.passwordField = configurePasswordField()
        loginViewController.emailField = configureEmailField()
        return loginViewController
    }
    
    private func configureLogo() -> UIImageView {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "logo")
        logoImageView.setImageColor(color: .baseOrange)
        loginViewController.view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = logoImageView.centerXAnchor
            .constraint(equalTo: loginViewController.view.centerXAnchor)
        let verticalConstraint = logoImageView.centerYAnchor
            .constraint(equalTo: loginViewController.view.centerYAnchor,
                        constant: -112)
        let widthConstraint = logoImageView.widthAnchor
            .constraint(equalToConstant: 80)
        let heightConstraint = logoImageView.heightAnchor
            .constraint(equalToConstant: 80)
        loginViewController.view.addConstraints([
            horizontalConstraint,
            verticalConstraint,
            widthConstraint,
            heightConstraint])
        layoutIfNeeded()
        return logoImageView
    }
    
    private func configureSigninButton() -> UIButton {
        let signinButton = UIButton()
        signinButton.backgroundColor = .baseOrange
        signinButton.roundCorners(with: 6)
        signinButton.setTitle("Login", for: .normal)
        signinButton.setTitleColor(.white, for: .normal)
        signinButton.addTarget(loginViewController,
                               action: #selector(loginViewController.signInAction(_:)),
                               for: .touchUpInside)
        loginViewController.view.addSubview(signinButton)
        signinButton.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = signinButton.leadingAnchor
            .constraint(equalTo: loginViewController.view.leadingAnchor,
                        constant: 16)
        let trailingConstraint = loginViewController.view.trailingAnchor
            .constraint(equalTo: signinButton.trailingAnchor,
                        constant: 16)
        let bottomConstraint = loginViewController.view.bottomAnchor
            .constraint(equalTo: signinButton.bottomAnchor,
                        constant: 48)
        let heightConstraint = signinButton.heightAnchor
            .constraint(equalToConstant: 45)
        loginViewController.view.addConstraints([
            leadingConstraint,
            trailingConstraint,
            bottomConstraint,
            heightConstraint])
        layoutIfNeeded()
        return signinButton
    }
    
    private func configureEmailField() -> PaddedTextField {
        let emailField = PaddedTextField()
        emailField.placeholder = "Email"
        loginViewController.view.addSubview(emailField)
        emailField.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = emailField.leadingAnchor
            .constraint(equalTo: loginViewController.view.leadingAnchor,
                        constant: 16)
        let trailingConstraint = loginViewController.view.trailingAnchor
            .constraint(equalTo: emailField.trailingAnchor,
                        constant: 16)
        let bottomConstraint = loginViewController.passwordField.topAnchor
            .constraint(equalTo: emailField.bottomAnchor,
                        constant: 16)
        let heightConstraint = emailField.heightAnchor
            .constraint(equalToConstant: 35)
        loginViewController.view.addConstraints([
            leadingConstraint,
            trailingConstraint,
            bottomConstraint,
            heightConstraint])
        layoutIfNeeded()
        emailField.addBottomLine()
        return emailField
    }
    
    private func configurePasswordField() -> PaddedTextField {
        let passwordField = PaddedTextField()
        passwordField.placeholder = "Password"
        loginViewController.view.addSubview(passwordField)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = passwordField.leadingAnchor
            .constraint(equalTo: loginViewController.view.leadingAnchor,
                        constant: 16)
        let trailingConstraint = loginViewController.view.trailingAnchor
            .constraint(equalTo: passwordField.trailingAnchor,
                        constant: 16)
        let bottomConstraint = loginViewController.signinButton.topAnchor
            .constraint(equalTo: passwordField.bottomAnchor,
                        constant: 48)
        let heightConstraint = passwordField.heightAnchor
            .constraint(equalToConstant: 35)
        loginViewController.view.addConstraints([
            leadingConstraint,
            trailingConstraint,
            bottomConstraint,
            heightConstraint])
        layoutIfNeeded()
        passwordField.addBottomLine()
        return passwordField
    }
    
    private func layoutIfNeeded() {
        loginViewController.view.layoutIfNeeded()
    }
}
