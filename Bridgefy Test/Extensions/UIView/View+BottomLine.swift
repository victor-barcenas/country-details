//
//  View+BottomLine.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 23/09/22.
//

import Foundation
import UIKit

extension UITextField {
    
    func addBottomLine(with color: UIColor = .lightGray) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0,
                                  y: frame.height - 1,
                                  width: frame.width,
                                  height: 1.0)
        bottomLine.backgroundColor = color.cgColor
        bottomLine.opacity = 0.5
        borderStyle = UITextField.BorderStyle.none
        layer.addSublayer(bottomLine)
    }
}
