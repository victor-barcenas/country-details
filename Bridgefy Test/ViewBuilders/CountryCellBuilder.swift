//
//  CountryCellBuilder.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 25/09/22.
//

import UIKit

final class CountryCellBuilder {
    private var countryCell: CountryCell!
    
    init(_ cell: CountryCell) {
        countryCell = cell
        countryCell.accessoryType = .disclosureIndicator
    }
    
    func setFlagImage() -> UIImageView {
        let flagImageView = UIImageView()
        
        let contentView = countryCell.contentView
        countryCell.contentView.addSubview(flagImageView)
        flagImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = flagImageView.leadingAnchor
            .constraint(equalTo: contentView.leadingAnchor, constant: 16)
        let verticalConstraint = flagImageView.centerYAnchor
            .constraint(equalTo: contentView.centerYAnchor)
        let widthConstraint = flagImageView.widthAnchor
            .constraint(equalToConstant: 40)
        let heightConstraint = flagImageView.heightAnchor
            .constraint(equalToConstant: 30)
        contentView.addConstraints([
            leadingConstraint,
            verticalConstraint,
            widthConstraint,
            heightConstraint])
        contentView.layoutIfNeeded()
        return flagImageView
    }
    
    func setCountryNameLabel() -> UILabel {
        let countryNameLabel = UILabel()
        
        let contentView = countryCell.contentView
        countryCell.contentView.addSubview(countryNameLabel)
        countryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = countryNameLabel.leadingAnchor
            .constraint(equalTo: countryCell.flagImageView.trailingAnchor,
                        constant: 16)
        let topConstraint = countryNameLabel.topAnchor
            .constraint(equalTo: contentView.topAnchor,
                        constant: 8 )
        let heightConstraint = countryNameLabel.heightAnchor
            .constraint(equalToConstant: 21)
        contentView.addConstraints([
            leadingConstraint,
            topConstraint,
            heightConstraint])
        contentView.layoutIfNeeded()
        return countryNameLabel
    }
    
    func setAlphaCodeLabel() -> UILabel {
        let alphaCodeLabel = UILabel()
        alphaCodeLabel.textColor = .placeholderText
        
        let contentView = countryCell.contentView
        countryCell.contentView.addSubview(alphaCodeLabel)
        alphaCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = alphaCodeLabel.leadingAnchor
            .constraint(equalTo: countryCell.flagImageView.trailingAnchor,
                        constant: 16)
        let topConstraint = alphaCodeLabel.topAnchor
            .constraint(equalTo: countryCell.countryNameLabel.bottomAnchor,
                        constant: 8 )
        let heightConstraint = alphaCodeLabel.heightAnchor
            .constraint(equalToConstant: 21)
        contentView.addConstraints([
            leadingConstraint,
            topConstraint,
            heightConstraint])
        contentView.layoutIfNeeded()
        return alphaCodeLabel
    }
}
