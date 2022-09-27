//
//  BorderItemCell.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 26/09/22.
//

import UIKit

class BorderItemCell: UICollectionViewCell {
    
    static let identifier = String(describing: CountryCell.self)
    
    weak var flagImage: UIImageView!
    weak var countryNameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let borderCellBuilder = BorderItemCellBuilder(self)
        flagImage = borderCellBuilder.setFlagImage()
        countryNameLabel = borderCellBuilder.setCountryNameLabel()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with country: Country) {
        countryNameLabel.text = country.name
        flagImage.load(from: country.flags.png) { [weak self] image in
            self?.flagImage.image = image
        }
    }
}
