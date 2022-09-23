//
//  ViewController+RootView.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 23/09/22.
//

import UIKit

extension UIViewController {
    func setRootView() {
        let rootView = UIView(frame: UIScreen.main.bounds)
        rootView.backgroundColor = .white
        view = rootView
    }
}
