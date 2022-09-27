//
//  BorderItemCellBuilder.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 26/09/22.
//

import UIKit

final class BorderItemCellBuilder {
    private var borderCell: BorderItemCell!
    
    init(_ cell: BorderItemCell) {
        borderCell = cell
    }
    
    func setFlagImage() -> UIImageView {
        let flagImageView = UIImageView()
        
        let contentView = borderCell.contentView
        borderCell.contentView.addSubview(flagImageView)
        flagImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let centerXConstraint = flagImageView.centerXAnchor
            .constraint(equalTo: contentView.centerXAnchor)
        let topConstraint = flagImageView.topAnchor
            .constraint(equalTo: contentView.topAnchor)
        let widthConstraint = flagImageView.widthAnchor
            .constraint(equalToConstant: 40)
        let heightConstraint = flagImageView.heightAnchor
            .constraint(equalToConstant: 30)
        contentView.addConstraints([
            centerXConstraint,
            topConstraint,
            widthConstraint,
            heightConstraint])
        contentView.layoutIfNeeded()
        return flagImageView
    }
    
    func setCountryNameLabel() -> UILabel {
        let countryNameLabel = UILabel()
        countryNameLabel.numberOfLines = 0
        countryNameLabel.textAlignment = .center
        
        let contentView = borderCell.contentView
        borderCell.contentView.addSubview(countryNameLabel)
        countryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = countryNameLabel.leadingAnchor
            .constraint(equalTo: contentView.leadingAnchor,
                        constant: 8)
        let trailingConstraint = contentView.trailingAnchor
            .constraint(equalTo: countryNameLabel.trailingAnchor,
                        constant: 8)
        let topConstraint = countryNameLabel.topAnchor
            .constraint(equalTo: borderCell.flagImage.bottomAnchor,
                        constant: 8 )
        let heightConstraint = countryNameLabel.heightAnchor
            .constraint(equalToConstant: 42)
        contentView.addConstraints([
            leadingConstraint,
            topConstraint,
            heightConstraint,
            trailingConstraint
        ])
        contentView.layoutIfNeeded()
        return countryNameLabel
    }
}
