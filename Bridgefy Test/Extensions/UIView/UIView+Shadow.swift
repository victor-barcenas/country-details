//
//  UIView+Shadow.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 26/09/22.
//

import UIKit

extension UIView {
    func setShadow() {
        let shadowLayer = CAShapeLayer()
        layer.cornerRadius = 10
        shadowLayer.path = UIBezierPath(roundedRect: bounds,
                                        cornerRadius: layer.cornerRadius).cgPath
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.fillColor = backgroundColor?.cgColor
        shadowLayer.shadowColor = UIColor.darkGray.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
        shadowLayer.shadowOpacity = 0.4
        shadowLayer.shadowRadius = 3.0
        layer.insertSublayer(shadowLayer, at: 0)
    }
}
