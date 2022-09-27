//
//  CountryDetailView.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 26/09/22.
//

import UIKit

class CountryDetailView: UIViewController, ActivityIndicatable {
    
    private var viewModel: CountryDetailViewModel!
    private var countryName: String!
    weak var scrollView: UIScrollView!
    weak var contentView: UIView!
    weak var mapContainer: UIView!
    weak var populationContainer: UIView!
    weak var timezoneContainer: UIView!
    weak var currencyContainer: UIView!
    weak var bordersContainer: UIView!
    weak var flagImage: UIImageView!
    weak var countryNameLabel: UILabel!
    weak var capitalNameLabel: UILabel!
    weak var mapImage: UIImageView!
    weak var subRegionLabel: UILabel!
    weak var areaLabel: UILabel!
    weak var latLongLabel: UILabel!
    weak var populationLabel: UILabel!
    weak var populationImage: UIImageView!
    weak var languageLabel: UILabel!
    weak var languageImage: UIImageView!
    weak var areaCodeLabel: UILabel!
    weak var areaCodeImage: UIImageView!
    weak var timeZonesTextView: UITextView!
    weak var timeZonesImage: UIImageView!
    weak var currencyLabel: UILabel!
    weak var currencyImage: UIImageView!
    weak var borderLabel: UILabel!
    var borderCollectionView: UICollectionView!
    var countryBorders: [Country]!
    var borders: [String]!
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let f = UICollectionViewFlowLayout()
        f.scrollDirection = .horizontal
        f.itemSize = CGSize(width: 120, height: 113)
        return f
    }()
    
    init(_ viewModel: CountryDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        mapContainer.setShadow()
        configureCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard timeZonesTextView != nil else { return }
        timeZonesTextView.centerTextVertically()
    }
    
    private func configureCollectionView() {
        borderCollectionView = UICollectionView(frame: .zero,
                                                collectionViewLayout: flowLayout)
        borderCollectionView.dataSource = self
        borderCollectionView.delegate = self
        borderCollectionView.register(BorderItemCell.self,
                                      forCellWithReuseIdentifier: BorderItemCell.identifier)
        bordersContainer.addSubview(borderCollectionView)
        
        borderCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let centerXConstraint = bordersContainer.centerXAnchor
            .constraint(equalTo: borderCollectionView.centerXAnchor, constant: 0)
        let topConstraint = borderCollectionView.topAnchor
            .constraint(equalTo: borderLabel.bottomAnchor, constant: 16)
        let heightConstraint = borderCollectionView.heightAnchor
            .constraint(equalToConstant: 113)
        let widthConstraint = bordersContainer.widthAnchor
            .constraint(equalTo: borderCollectionView.widthAnchor)
        
        bordersContainer.addConstraints([
            centerXConstraint,
            topConstraint,
            heightConstraint,
            widthConstraint
        ])
        bordersContainer.layoutIfNeeded()
    }
}

extension CountryDetailView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return borders.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BorderItemCell.identifier, for: indexPath
        ) as? BorderItemCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: countryBorders[indexPath.row])
        return cell
    }
}

extension CountryDetailView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 113)
    }
}

