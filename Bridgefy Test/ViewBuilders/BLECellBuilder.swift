//
//  BLECellBuilder.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 27/09/22.
//

import UIKit

final class BLECellBuilder {
    
    private var cell: BLECell!
    
    init(_ cell: BLECell) {
        self.cell = cell
    }
    
    func setContainerView() -> UIView  {
        let containerView = UIView()
        cell.contentView.addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = containerView.topAnchor
            .constraint(equalTo: cell.contentView.topAnchor)
        let leadingConstraint = containerView.leadingAnchor
            .constraint(equalTo: cell.contentView.leadingAnchor)
        let trailingConstraint = containerView.trailingAnchor
            .constraint(equalTo: cell.contentView.trailingAnchor)
        let bottomConstraint = containerView.bottomAnchor
            .constraint(equalTo: cell.contentView.bottomAnchor)
        
        cell.contentView.addConstraints([
            topConstraint,
            leadingConstraint,
            trailingConstraint,
            bottomConstraint
        ])
        
        cell.contentView.layoutIfNeeded()
        return containerView
    }
    
    func setTitleLabel() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        cell.containerView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = titleLabel.topAnchor
            .constraint(equalTo: cell.containerView.topAnchor,
                        constant: 5.0)
        let heightConstraint = titleLabel.heightAnchor
            .constraint(equalToConstant: 18.0)
        let leadingConstraint = titleLabel.leadingAnchor
            .constraint(equalTo: cell.containerView.leadingAnchor, constant: 16)
        let trailingConstraint = titleLabel.trailingAnchor
            .constraint(equalTo: cell.containerView.trailingAnchor)
        cell.containerView.addConstraints([
            topConstraint,
            heightConstraint,
            leadingConstraint,
            trailingConstraint
        ])
        
        cell.containerView.layoutIfNeeded()
        return titleLabel
    }
    
    func setSubtitleLabel() -> UILabel {
        let subtitleLabel = UILabel()
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.numberOfLines = 0
        cell.containerView.addSubview(subtitleLabel)
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = subtitleLabel.topAnchor
            .constraint(equalTo: cell.titleLabel.bottomAnchor, constant:4.0)
        let bottomConstraint = subtitleLabel.bottomAnchor
            .constraint(equalTo: cell.containerView.bottomAnchor, constant: -4.0)
        let leadingConstraint = subtitleLabel.leadingAnchor
            .constraint(equalTo: cell.containerView.leadingAnchor, constant: 16)
        let trailingConstraint = subtitleLabel.trailingAnchor
            .constraint(equalTo: cell.containerView.trailingAnchor)
        
        cell.containerView.addConstraints([
            topConstraint,
            bottomConstraint,
            leadingConstraint,
            trailingConstraint
        ])
        
        cell.containerView.layoutIfNeeded()
        return subtitleLabel
    }
}
