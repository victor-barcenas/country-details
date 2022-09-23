//
//  ViewController+AlertController.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 23/09/22.
//

import UIKit

extension UIViewController {
    
    func showMessage(_ message: String?,
                     title: String?,
                     style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: style)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in 
            alertController.dismiss(animated: true)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
