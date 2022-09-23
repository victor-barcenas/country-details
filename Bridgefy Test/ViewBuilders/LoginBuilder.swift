//
//  LoginBuilder.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 23/09/22.
//

import UIKit

final class LoginBuilder {
    private let loginViewController = LoginViewController()
    private var scrollContentView: UIView!
    
    func build() -> LoginViewController {
        loginViewController.setRootView()
        loginViewController.scrollView = configureScrollView()
        loginViewController.contentView = configureContentView()
        scrollContentView = loginViewController.contentView
        loginViewController.logoImageView =  configureLogo()
        loginViewController.signinButton = configureSigninButton()
        loginViewController.passwordField = configurePasswordField()
        loginViewController.emailField = configureEmailField()
        return loginViewController
    }
    
    private func configureScrollView() -> UIScrollView {
        guard let mainView = loginViewController.view else {
            return UIScrollView()
        }
        let scrollView = UIScrollView()
        mainView.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let centerXConstraint = scrollView.centerXAnchor
            .constraint(equalTo: mainView.centerXAnchor)
        let widthConstraint = scrollView.widthAnchor
            .constraint(equalTo: mainView.widthAnchor)
        let topConstraint = scrollView.topAnchor
            .constraint(equalTo: mainView.topAnchor)
        let bottomConstraint = scrollView.bottomAnchor
            .constraint(equalTo: mainView.bottomAnchor)
        let heightConstraint = scrollView.heightAnchor
            .constraint(equalTo: mainView.heightAnchor)
        
        mainView.addConstraints([
            widthConstraint,
            centerXConstraint,
            topConstraint,
            bottomConstraint,
            heightConstraint
        ])
        mainView.layoutIfNeeded()
        return scrollView
    }
    
    private func configureContentView() -> UIView {
        guard let scrollView = loginViewController.scrollView else {
            return UIView()
        }
        let contentView = UIView()
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false

        let centerXConstraint = contentView.centerXAnchor
            .constraint(equalTo: scrollView.centerXAnchor)
        let centerYConstraint = contentView.centerYAnchor
            .constraint(equalTo: scrollView.centerYAnchor)
        let widthConstraint = contentView.widthAnchor
            .constraint(equalTo: scrollView.widthAnchor)
        let heightConstraint = contentView.heightAnchor
            .constraint(equalTo: scrollView.heightAnchor)
        let bottomConstraint = scrollView.bottomAnchor
            .constraint(equalTo: contentView.bottomAnchor)
        let topConstraint = contentView.topAnchor
            .constraint(equalTo: scrollView.topAnchor)
        let leadingConstraint = contentView.leadingAnchor
            .constraint(equalTo: scrollView.leadingAnchor)
        let trailingConstraint = scrollView.trailingAnchor
            .constraint(equalTo: contentView.trailingAnchor)
        
        scrollView.addConstraints([
            heightConstraint,
            widthConstraint,
            topConstraint,
            bottomConstraint,
            centerXConstraint,
            centerYConstraint,
            leadingConstraint,
            trailingConstraint
        ])
        contentView.layoutIfNeeded()
        return contentView
    }
    
    private func configureLogo() -> UIImageView {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "logo")
        logoImageView.setImageColor(color: .baseOrange)
        scrollContentView.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = logoImageView.centerXAnchor
            .constraint(equalTo: scrollContentView.centerXAnchor)
        let verticalConstraint = logoImageView.centerYAnchor
            .constraint(equalTo: scrollContentView.centerYAnchor,
                        constant: -112)
        let widthConstraint = logoImageView.widthAnchor
            .constraint(equalToConstant: 80)
        let heightConstraint = logoImageView.heightAnchor
            .constraint(equalToConstant: 80)
        scrollContentView.addConstraints([
            horizontalConstraint,
            verticalConstraint,
            widthConstraint,
            heightConstraint])
        scrollContentView.layoutIfNeeded()
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
        scrollContentView.addSubview(signinButton)
        signinButton.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = signinButton.leadingAnchor
            .constraint(equalTo: scrollContentView.leadingAnchor,
                        constant: 16)
        let trailingConstraint = scrollContentView.trailingAnchor
            .constraint(equalTo: signinButton.trailingAnchor,
                        constant: 16)
        let bottomConstraint = scrollContentView.bottomAnchor
            .constraint(equalTo: signinButton.bottomAnchor,
                        constant: 48)
        let heightConstraint = signinButton.heightAnchor
            .constraint(equalToConstant: 45)
        scrollContentView.addConstraints([
            leadingConstraint,
            trailingConstraint,
            bottomConstraint,
            heightConstraint])
        scrollContentView.layoutIfNeeded()
        return signinButton
    }
    
    private func configureEmailField() -> PaddedTextField {
        let emailField = PaddedTextField()
        emailField.placeholder = "Email"
        scrollContentView.addSubview(emailField)
        emailField.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = emailField.leadingAnchor
            .constraint(equalTo: scrollContentView.leadingAnchor,
                        constant: 16)
        let trailingConstraint = scrollContentView.trailingAnchor
            .constraint(equalTo: emailField.trailingAnchor,
                        constant: 16)
        let bottomConstraint = loginViewController.passwordField.topAnchor
            .constraint(equalTo: emailField.bottomAnchor,
                        constant: 16)
        let heightConstraint = emailField.heightAnchor
            .constraint(equalToConstant: 35)
        scrollContentView.addConstraints([
            leadingConstraint,
            trailingConstraint,
            bottomConstraint,
            heightConstraint])
        scrollContentView.layoutIfNeeded()
        emailField.addBottomLine()
        emailField.delegate = loginViewController
        return emailField
    }
    
    private func configurePasswordField() -> PaddedTextField {
        let passwordField = PaddedTextField()
        passwordField.placeholder = "Password"
        scrollContentView.addSubview(passwordField)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = passwordField.leadingAnchor
            .constraint(equalTo: scrollContentView.leadingAnchor,
                        constant: 16)
        let trailingConstraint = scrollContentView.trailingAnchor
            .constraint(equalTo: passwordField.trailingAnchor,
                        constant: 16)
        let bottomConstraint = loginViewController.signinButton.topAnchor
            .constraint(equalTo: passwordField.bottomAnchor,
                        constant: 48)
        let heightConstraint = passwordField.heightAnchor
            .constraint(equalToConstant: 35)
        scrollContentView.addConstraints([
            leadingConstraint,
            trailingConstraint,
            bottomConstraint,
            heightConstraint])
        scrollContentView.layoutIfNeeded()
        passwordField.addBottomLine()
        passwordField.delegate = loginViewController
        return passwordField
    }
}
