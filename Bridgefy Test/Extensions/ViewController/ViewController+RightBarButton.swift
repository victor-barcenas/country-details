//
//  ViewController+RightBarButton.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 25/09/22.
//

import UIKit

extension UIViewController {
    func setRightBarButton(_ buttonTitle: String, selector: Selector) {
        let rightButton: UIButton = UIButton(type: .custom)
        let buttonTitleAttributed = NSMutableAttributedString(string: buttonTitle)
        let buttonTitleAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.baseOrange as Any
        ]
        buttonTitleAttributed.addAttributes(buttonTitleAttributes,
                                            range: NSRange(location: 0,
                                                           length: buttonTitle.count))
        rightButton.setAttributedTitle(buttonTitleAttributed, for: .normal)
        rightButton.addTarget(self,
                              action: selector,
                              for: .touchUpInside)
        rightButton.frame = CGRect(x: 6 , y: -5, width: 9.33, height: 33.67)
        let rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}
