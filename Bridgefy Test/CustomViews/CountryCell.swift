//
//  CountryCell.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 25/09/22.
//

import UIKit

class CountryCell: UITableViewCell {
    
    static let identifier = String(describing: CountryCell.self)
    
    var flagImageView: UIImageView!
    var countryNameLabel: UILabel!
    var alphaCodeLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let countryCellBuilder = CountryCellBuilder(self)
        flagImageView = countryCellBuilder.setFlagImage()
        countryNameLabel = countryCellBuilder.setCountryNameLabel()
        alphaCodeLabel = countryCellBuilder.setAlphaCodeLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with country: Country) {
        countryNameLabel.text = country.name
        alphaCodeLabel.text = "\(country.alpha2Code)/\(country.alpha3Code)"
        flagImageView.load(from: country.flags.png) { [weak self] image in
            self?.flagImageView.image = image
        }
    }
}
