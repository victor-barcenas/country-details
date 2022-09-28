//
//  BLECell.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 27/09/22.
//

import UIKit

class BLECell: UITableViewCell {
    
    static let identifier = String(describing: BLECell.self)
    
    weak var containerView: UIView!
    weak var titleLabel: UILabel!
    weak var advertisementLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let bleCellBuilder = BLECellBuilder(self)
        containerView = bleCellBuilder.setContainerView()
        titleLabel = bleCellBuilder.setTitleLabel()
        advertisementLabel = bleCellBuilder.setSubtitleLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with bleAdvertisement: BLEAdvertisement) {
        titleLabel.text = bleAdvertisement.name
        var advertisementText = ""
        for (key, value) in bleAdvertisement.advertisement {
            advertisementText = "\(key): \(value)\n"
        }
        advertisementText += "RSSI: \(bleAdvertisement.rssi)"
        advertisementLabel.text = advertisementText
    }
}
