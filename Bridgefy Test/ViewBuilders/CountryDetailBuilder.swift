//
//  CountryDetailBuilder.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 26/09/22.
//

import UIKit
import MapKit

final class CountryDetailBuilder {
    
    private var countryDetailView: CountryDetailView!
    private var country: CountryDetail!
    private var contentView: UIView!
    private var viewModel: CountryDetailViewModel!
    
    func build(with networkManager: NetworkManager, countryName: String,
               coreDataManager: CoreDataManager,
               _ completion: @escaping (CountryDetailView?) -> Void) {
        viewModel = CountryDetailViewModel(with: networkManager,
                                               coreDataManager: coreDataManager)
        
        let fetchResult = viewModel.fetch(countryName)
        
        switch fetchResult {
        case.success(let countryDetail):
            guard countryDetail != nil else {
                getCountryDetail(countryName, completion)
                return
            }
            country = countryDetail
            country.isStored = true
            configureCountryDetailView()
            completion(countryDetailView)
        case.failure(_):
            getCountryDetail(countryName, completion)
        }
    }
    
    private func getCountryDetail(_ name: String,
                      _ completion: @escaping (CountryDetailView?) -> Void) {
        viewModel.getCountryDetail(name) { [weak self] result in
            switch result{
            case .success(let countryDetail):
                guard let self = self else { return }
                self.country = countryDetail.first
                self.configureCountryDetailView()
                completion(self.countryDetailView)
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
    
    private func configureCountryDetailView() {
        countryDetailView = CountryDetailView(
            viewModel, countryDetail: country
        )
        configureViews()
        countryDetailView.borders = country.borders
    }
    
    private func configureViews() {
        countryDetailView.setRootView()
        countryDetailView.title = country.name
        countryDetailView.scrollView = setScrollView()
        countryDetailView.contentView = setContentView()
        countryDetailView.flagImage = setFlagImage()
        countryDetailView.countryNameLabel = setCountryName()
        countryDetailView.capitalNameLabel = setCapitalName()
        countryDetailView.mapContainer = setMapContainer()
        countryDetailView.populationContainer = setPopulationContainer()
        countryDetailView.timezoneContainer = setTimezoneContainer()
        countryDetailView.currencyContainer = setCurrencyContainer()
        countryDetailView.bordersContainer = setBordersContainer()
        countryDetailView.mapImage = setMapImage()
        countryDetailView.subRegionLabel = setSuRegionLabel()
        countryDetailView.areaLabel = setAreaLabel()
        countryDetailView.latLongLabel = setLatLongLabel()
        countryDetailView.populationImage = setPopulationImage()
        countryDetailView.populationLabel = setPopulationLabel()
        countryDetailView.languageImage = setLanguageImage()
        countryDetailView.languageLabel = setLanguageLabel()
        countryDetailView.areaCodeImage = setPhoneCodeImage()
        countryDetailView.areaCodeLabel = setPhoneCodeLabel()
        countryDetailView.timeZonesImage = setTimezoneImage()
        countryDetailView.timeZonesTextView = setTimezoneTextView()
        countryDetailView.currencyLabel = setCurrencyLabel()
        countryDetailView.currencyImage = setCurrencyImage()
        countryDetailView.borderLabel = setBordersLabel()
    }
    
    private func setScrollView() -> UIScrollView {
        guard let mainView = countryDetailView.view else {
            return UIScrollView()
        }
        let scrollView = UIScrollView()
        mainView.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let centerXConstraint = scrollView.centerXAnchor
            .constraint(equalTo: mainView.centerXAnchor)
        let widthConstraint = scrollView.widthAnchor
            .constraint(equalTo: mainView.widthAnchor)
        let topConstraint = scrollView.topAnchor
            .constraint(equalTo: mainView.topAnchor)
        let bottomConstraint = scrollView.bottomAnchor
            .constraint(equalTo: mainView.bottomAnchor)
        let heightConstraint = scrollView.heightAnchor
            .constraint(equalTo: mainView.heightAnchor)
        
        mainView.addConstraints([
            widthConstraint,
            centerXConstraint,
            topConstraint,
            bottomConstraint,
            heightConstraint
        ])
        mainView.layoutIfNeeded()
        return scrollView
    }
    
    private func setContentView() -> UIView {
        guard let scrollView = countryDetailView.scrollView else {
            return UIView()
        }
        contentView = UIView()
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false

        let centerXConstraint = contentView.centerXAnchor
            .constraint(equalTo: scrollView.centerXAnchor)
        let centerYConstraint = contentView.centerYAnchor
            .constraint(equalTo: scrollView.centerYAnchor)
        let widthConstraint = contentView.widthAnchor
            .constraint(equalTo: scrollView.widthAnchor)
        let heightConstraint = contentView.heightAnchor
            .constraint(equalTo: scrollView.heightAnchor)
        let bottomConstraint = scrollView.bottomAnchor
            .constraint(equalTo: contentView.bottomAnchor)
        let topConstraint = contentView.topAnchor
            .constraint(equalTo: scrollView.topAnchor)
        let leadingConstraint = contentView.leadingAnchor
            .constraint(equalTo: scrollView.leadingAnchor)
        let trailingConstraint = scrollView.trailingAnchor
            .constraint(equalTo: contentView.trailingAnchor)
        
        scrollView.addConstraints([
            heightConstraint,
            widthConstraint,
            topConstraint,
            bottomConstraint,
            centerXConstraint,
            centerYConstraint,
            leadingConstraint,
            trailingConstraint
        ])
        contentView.layoutIfNeeded()
        return contentView
    }
    
    private func setFlagImage() -> UIImageView {
        let flagImageView = UIImageView()
        flagImageView.load(from: country.flags.png) { image in
            flagImageView.image = image
        }
        contentView.addSubview(flagImageView)
        
        flagImageView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = flagImageView.centerXAnchor
            .constraint(equalTo: contentView.centerXAnchor)
        let topConstraint = flagImageView.topAnchor
            .constraint(equalTo: contentView.topAnchor,
                        constant: 24)
        let widthConstraint = flagImageView.widthAnchor
            .constraint(equalToConstant: contentView.frame.width/2)
        let heightConstraint = flagImageView.heightAnchor
            .constraint(equalToConstant: 108)
        contentView.addConstraints([
            horizontalConstraint,
            topConstraint,
            widthConstraint,
            heightConstraint])
        contentView.layoutIfNeeded()
        return flagImageView
    }
    
    private func setCountryName() -> UILabel {
        let countryNameLabel = UILabel()
        contentView.addSubview(countryNameLabel)
        countryNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        countryNameLabel.textAlignment = .center
        countryNameLabel.text = country.name
        
        countryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = countryNameLabel.centerXAnchor
            .constraint(equalTo: contentView.centerXAnchor)
        let topConstraint = countryNameLabel.topAnchor
            .constraint(equalTo: countryDetailView.flagImage.bottomAnchor,
                        constant: 16)
        let widthConstraint = countryNameLabel.widthAnchor
            .constraint(equalTo: contentView.widthAnchor, constant: -32)
        let heightConstraint = countryNameLabel.heightAnchor
            .constraint(equalToConstant: 21)
        contentView.addConstraints([
            horizontalConstraint,
            topConstraint,
            widthConstraint,
            heightConstraint])
        contentView.layoutIfNeeded()
        return countryNameLabel
    }
    
    private func setCapitalName() -> UILabel {
        let capitalNameLabel = UILabel()
        contentView.addSubview(capitalNameLabel)
        capitalNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        capitalNameLabel.textAlignment = .center
        capitalNameLabel.textColor = .lightGray
        capitalNameLabel.text = country.capital
        
        capitalNameLabel.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = capitalNameLabel.centerXAnchor
            .constraint(equalTo: contentView.centerXAnchor)
        let topConstraint = capitalNameLabel.topAnchor
            .constraint(equalTo: countryDetailView.countryNameLabel.bottomAnchor,
                        constant: 16)
        let widthConstraint = capitalNameLabel.widthAnchor
            .constraint(equalTo: contentView.widthAnchor, constant: -32)
        let heightConstraint = capitalNameLabel.heightAnchor
            .constraint(equalToConstant: 21)
        contentView.addConstraints([
            horizontalConstraint,
            topConstraint,
            widthConstraint,
            heightConstraint])
        contentView.layoutIfNeeded()
        return capitalNameLabel
    }
    
    private func setMapContainer() -> UIView {
        let mapContainer = UIView()
        mapContainer.backgroundColor = .white
        
        contentView.addSubview(mapContainer)
        
        mapContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = mapContainer.leadingAnchor
            .constraint(equalTo: contentView.leadingAnchor, constant: 16)
        let trailingConstraint = contentView.trailingAnchor
            .constraint(equalTo: mapContainer.trailingAnchor, constant: 16)
        let topConstraint = mapContainer.topAnchor
            .constraint(equalTo: countryDetailView.capitalNameLabel.bottomAnchor,
                        constant: 16)
        let heightConstraint = mapContainer.heightAnchor
            .constraint(equalToConstant: 180)
        
        contentView.addConstraints([
            leadingConstraint,
            trailingConstraint,
            topConstraint,
            heightConstraint
        ])
        contentView.layoutIfNeeded()
        mapContainer.setShadow()
        return mapContainer
    }
    
    private func setMapImage() -> UIImageView? {
        let mapImage = UIImageView()
        mapImage.image = UIImage(named: country.alpha3Code.uppercased())
        mapImage.setImageColor(color: .baseOrange)
        
        guard let mapContainer = countryDetailView.mapContainer else { return nil }
        countryDetailView.mapContainer.addSubview(mapImage)
        
        mapImage.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = mapImage.leadingAnchor
            .constraint(equalTo: mapContainer.leadingAnchor, constant: 16)
        let widthConstraint = mapImage.widthAnchor
            .constraint(equalToConstant: mapContainer.frame.width * 0.45)
        let heightConstraint = mapImage.heightAnchor
            .constraint(equalToConstant: 122)
        let centerYConstraint = mapImage.centerYAnchor
            .constraint(equalTo: mapContainer.centerYAnchor)
        
        mapContainer.addConstraints([
            leadingConstraint,
            widthConstraint,
            centerYConstraint,
            heightConstraint
        ])
        mapContainer.layoutIfNeeded()
        return mapImage
    }
    
    private func setSuRegionLabel() -> UILabel? {
        let subregionLabel = UILabel()
        format(label: subregionLabel)
        subregionLabel.text = country.subregion
        
        guard let mapContainer = countryDetailView.mapContainer else { return nil }
        mapContainer.addSubview(subregionLabel)
        
        subregionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = subregionLabel.leadingAnchor
            .constraint(equalTo: countryDetailView.mapImage.trailingAnchor,
                        constant: 16)
        let trailingConstraint = mapContainer.trailingAnchor
            .constraint(equalTo: subregionLabel.trailingAnchor, constant: 16)
        let heightConstraint = subregionLabel.heightAnchor
            .constraint(equalToConstant: 38.6)
        let topConstraint = subregionLabel.topAnchor
            .constraint(equalTo: mapContainer.topAnchor,
                        constant: 16)
        
        mapContainer.addConstraints([
            leadingConstraint,
            trailingConstraint,
            topConstraint,
            heightConstraint
        ])
        mapContainer.layoutIfNeeded()
        return subregionLabel
    }
    
    private func setAreaLabel() -> UILabel? {
        let areaLabel = UILabel()
        format(label: areaLabel)

        let df = MKDistanceFormatter()
        df.unitStyle = .abbreviated
        df.units = .metric
        let prettyString = df.string(fromDistance: (country.area ?? 0.0) * 1000)
        areaLabel.text = prettyString + "²"
        
        guard let mapContainer = countryDetailView.mapContainer else { return nil }
        mapContainer.addSubview(areaLabel)
        
        areaLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = areaLabel.leadingAnchor
            .constraint(equalTo: countryDetailView.mapImage.trailingAnchor,
                        constant: 16)
        let trailingConstraint = mapContainer.trailingAnchor
            .constraint(equalTo: areaLabel.trailingAnchor, constant: 16)
        let heightConstraint = areaLabel.heightAnchor
            .constraint(equalToConstant: 38.6)
        let topConstraint = areaLabel.topAnchor
            .constraint(equalTo: countryDetailView.subRegionLabel.bottomAnchor,
                        constant: 16)
        
        mapContainer.addConstraints([
            leadingConstraint,
            trailingConstraint,
            topConstraint,
            heightConstraint
        ])
        mapContainer.layoutIfNeeded()
        return areaLabel
    }
    
    private func setLatLongLabel() -> UILabel? {
        let latLongLabel = UILabel()
        format(label: latLongLabel)
        latLongLabel.text = "(\(country.latlng[0]), \(country.latlng[1]))"
        
        guard let mapContainer = countryDetailView.mapContainer else { return nil }
        mapContainer.addSubview(latLongLabel)
        
        latLongLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = latLongLabel.leadingAnchor
            .constraint(equalTo: countryDetailView.mapImage.trailingAnchor,
                        constant: 16)
        let trailingConstraint = mapContainer.trailingAnchor
            .constraint(equalTo: latLongLabel.trailingAnchor, constant: 16)
        let heightConstraint = latLongLabel.heightAnchor
            .constraint(equalToConstant: 38.6)
        let topConstraint = latLongLabel.topAnchor
            .constraint(equalTo: countryDetailView.areaLabel.bottomAnchor,
                        constant: 16)
        
        mapContainer.addConstraints([
            leadingConstraint,
            trailingConstraint,
            topConstraint,
            heightConstraint
        ])
        mapContainer.layoutIfNeeded()
        return latLongLabel
    }
    
    private func setPopulationContainer() -> UIView {
        let populationContainer = UIView()
        populationContainer.backgroundColor = .white

        contentView.addSubview(populationContainer)
        
        populationContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = populationContainer.leadingAnchor
            .constraint(equalTo: contentView.leadingAnchor, constant: 16)
        let widthConstraint = populationContainer.widthAnchor
            .constraint(equalToConstant: contentView.frame.width * 0.55)
        let topConstraint = populationContainer.topAnchor
            .constraint(equalTo: countryDetailView.mapContainer.bottomAnchor,
                        constant: 16)
        let heightConstraint = populationContainer.heightAnchor
            .constraint(equalToConstant: 170)
        
        contentView.addConstraints([
            leadingConstraint,
            widthConstraint,
            topConstraint,
            heightConstraint
        ])
        contentView.layoutIfNeeded()
        
        populationContainer.setShadow()
        return populationContainer
    }
    
    private func setPopulationImage() -> UIImageView {
        let populationImage = UIImageView()
        populationImage.image = UIImage(named: "population")
        populationImage.setImageColor(color: .baseOrange)
        
        guard let populationContainer = countryDetailView.populationContainer
        else { return UIImageView() }
        populationContainer.addSubview(populationImage)
        
        populationImage.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = populationImage.leadingAnchor
            .constraint(equalTo: populationContainer.leadingAnchor,
                        constant: 25)
        let widthConstraint = populationImage.widthAnchor
            .constraint(equalToConstant: 20)
        let heightConstraint = populationImage.heightAnchor
            .constraint(equalToConstant: 30)
        let topConstraint = populationImage.topAnchor
            .constraint(equalTo: populationContainer.topAnchor,
                        constant: 16)
        
        populationContainer.addConstraints([
            leadingConstraint,
            widthConstraint,
            topConstraint,
            heightConstraint
        ])
        populationContainer.layoutIfNeeded()
        return populationImage
    }
    
    private func setPopulationLabel() -> UILabel {
        let populationLabel = UILabel()
        format(label: populationLabel)
        let df = MKDistanceFormatter()
        df.unitStyle = .abbreviated
        df.units = .metric
        let prettyString = df.string(fromDistance: (Double(country.population) * 1000))
        populationLabel.text = prettyString.replacingOccurrences(of: "km", with: "")
        
        guard let populationContainer = countryDetailView.populationContainer
        else { return UILabel() }
        populationContainer.addSubview(populationLabel)
        
        populationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = populationLabel.leadingAnchor
            .constraint(equalTo: countryDetailView.populationImage.trailingAnchor,
                        constant: 21)
        let trailingConstraint = populationContainer.trailingAnchor
            .constraint(equalTo: populationLabel.trailingAnchor, constant: 8)
        let heightConstraint = populationLabel.heightAnchor
            .constraint(equalToConstant: 35.3)
        let centerYConstraint = countryDetailView.populationImage.centerYAnchor
            .constraint(equalTo: populationLabel.centerYAnchor)
        
        populationContainer.addConstraints([
            leadingConstraint,
            trailingConstraint,
            centerYConstraint,
            heightConstraint
        ])
        populationContainer.layoutIfNeeded()
        return populationLabel
    }
    
    private func setLanguageImage() -> UIImageView {
        let languageImage = UIImageView()
        languageImage.image = UIImage(named: "languages")
        languageImage.setImageColor(color: .baseOrange)
        
        guard let populationContainer = countryDetailView.populationContainer
        else { return UIImageView() }
        populationContainer.addSubview(languageImage)
        
        languageImage.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = languageImage.leadingAnchor
            .constraint(equalTo: populationContainer.leadingAnchor,
                        constant: 20)
        let widthConstraint = languageImage.widthAnchor
            .constraint(equalToConstant: 30)
        let heightConstraint = languageImage.heightAnchor
            .constraint(equalToConstant: 30)
        let topConstraint = languageImage.topAnchor
            .constraint(equalTo: countryDetailView.populationImage.bottomAnchor,
                        constant: 16)
        
        populationContainer.addConstraints([
            leadingConstraint,
            widthConstraint,
            topConstraint,
            heightConstraint
        ])
        populationContainer.layoutIfNeeded()
        return languageImage
    }
    
    private func setLanguageLabel() -> UILabel {
        let languageLabel = UILabel()
        format(label: languageLabel)
        languageLabel.text = country.languages.first?.name
        
        guard let populationContainer = countryDetailView.populationContainer
        else { return UILabel() }
        populationContainer.addSubview(languageLabel)
        
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = languageLabel.leadingAnchor
            .constraint(equalTo: countryDetailView.languageImage.trailingAnchor,
                        constant: 16)
        let trailingConstraint = populationContainer.trailingAnchor
            .constraint(equalTo: languageLabel.trailingAnchor, constant: 8)
        let heightConstraint = languageLabel.heightAnchor
            .constraint(equalToConstant: 35.3)
        let centerYConstraint = countryDetailView.languageImage.centerYAnchor
            .constraint(equalTo: languageLabel.centerYAnchor)
        
        populationContainer.addConstraints([
            leadingConstraint,
            trailingConstraint,
            centerYConstraint,
            heightConstraint
        ])
        populationContainer.layoutIfNeeded()
        return languageLabel
    }
    
    private func setPhoneCodeImage() -> UIImageView {
        let phoneCodeImage = UIImageView()
        phoneCodeImage.image = UIImage(named: "phoneCode")
        phoneCodeImage.setImageColor(color: .baseOrange)
        
        guard let populationContainer = countryDetailView.populationContainer
        else { return UIImageView() }
        populationContainer.addSubview(phoneCodeImage)
        
        phoneCodeImage.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = phoneCodeImage.leadingAnchor
            .constraint(equalTo: populationContainer.leadingAnchor,
                        constant: 20)
        let widthConstraint = phoneCodeImage.widthAnchor
            .constraint(equalToConstant: 30)
        let heightConstraint = phoneCodeImage.heightAnchor
            .constraint(equalToConstant: 30)
        let topConstraint = phoneCodeImage.topAnchor
            .constraint(equalTo: countryDetailView.languageImage.bottomAnchor,
                        constant: 16)
        
        populationContainer.addConstraints([
            leadingConstraint,
            widthConstraint,
            topConstraint,
            heightConstraint
        ])
        populationContainer.layoutIfNeeded()
        return phoneCodeImage
    }
    
    private func setPhoneCodeLabel() -> UILabel {
        let phoneCodeLabel = UILabel()
        format(label: phoneCodeLabel)
        phoneCodeLabel.text = country.callingCodes.first
        
        guard let populationContainer = countryDetailView.populationContainer
        else { return UILabel() }
        populationContainer.addSubview(phoneCodeLabel)
        
        phoneCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = phoneCodeLabel.leadingAnchor
            .constraint(equalTo: countryDetailView.areaCodeImage.trailingAnchor,
                        constant: 16)
        let trailingConstraint = populationContainer.trailingAnchor
            .constraint(equalTo: phoneCodeLabel.trailingAnchor, constant: 8)
        let heightConstraint = phoneCodeLabel.heightAnchor
            .constraint(equalToConstant: 35.3)
        let centerYConstraint = countryDetailView.areaCodeImage.centerYAnchor
            .constraint(equalTo: phoneCodeLabel.centerYAnchor)
        
        populationContainer.addConstraints([
            leadingConstraint,
            trailingConstraint,
            centerYConstraint,
            heightConstraint
        ])
        populationContainer.layoutIfNeeded()
        return phoneCodeLabel
    }
    
    private func setTimezoneContainer() -> UIView {
        let latLongContainer = UIView()
        latLongContainer.backgroundColor = .white
        contentView.addSubview(latLongContainer)
        
        latLongContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let trailingConstraint = contentView.trailingAnchor
            .constraint(equalTo: latLongContainer.trailingAnchor, constant: 16)
        let leadingConstraint = latLongContainer.leadingAnchor
            .constraint(equalTo: countryDetailView.populationContainer.trailingAnchor,
                        constant: 16)
        let topConstraint = latLongContainer.topAnchor
            .constraint(equalTo: countryDetailView.mapContainer.bottomAnchor,
                        constant: 16)
        let heightConstraint = latLongContainer.heightAnchor
            .constraint(equalToConstant: 170)
        
        contentView.addConstraints([
            leadingConstraint,
            trailingConstraint,
            topConstraint,
            heightConstraint
        ])
        contentView.layoutIfNeeded()
        latLongContainer.setShadow()
        return latLongContainer
    }
    
    private func setTimezoneImage() -> UIImageView {
        let timeZoneImage = UIImageView()
        timeZoneImage.image = UIImage(named: "timezone")
        timeZoneImage.setImageColor(color: .baseOrange)
        
        guard let timezoneContainer = countryDetailView.timezoneContainer
        else { return UIImageView() }
        timezoneContainer.addSubview(timeZoneImage)
        
        timeZoneImage.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = timeZoneImage.leadingAnchor
            .constraint(equalTo: timezoneContainer.leadingAnchor,
                        constant: 16)
        let widthConstraint = timeZoneImage.widthAnchor
            .constraint(equalToConstant: 30)
        let heightConstraint = timeZoneImage.heightAnchor
            .constraint(equalToConstant: 30)
        let centerYConstraint = timeZoneImage.centerYAnchor
            .constraint(equalTo: timezoneContainer.centerYAnchor)
        
        timezoneContainer.addConstraints([
            leadingConstraint,
            widthConstraint,
            centerYConstraint,
            heightConstraint
        ])
        timezoneContainer.layoutIfNeeded()
        return timeZoneImage
    }
    
    private func setTimezoneTextView() -> UITextView {
        let timezoneTextView = UITextView()
        timezoneTextView.textColor = .lightGray
        timezoneTextView.font = UIFont.systemFont(ofSize: 20)
        var timezones = ""
        _ = country.timezones.compactMap({
            timezones += $0.dropFirst(3) + "\n"
        })
        timezoneTextView.text = timezones
        timezoneTextView.isEditable = false
        timezoneTextView.isSelectable = false
        
        guard let timezoneContainer = countryDetailView.timezoneContainer
        else { return UITextView() }
        timezoneContainer.addSubview(timezoneTextView)
        
        timezoneTextView.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = timezoneTextView.leadingAnchor
            .constraint(equalTo: countryDetailView.timeZonesImage.trailingAnchor,
                        constant: 4)
        let trailingConstraint = timezoneContainer.trailingAnchor
            .constraint(equalTo: timezoneTextView.trailingAnchor, constant: 0)
        let topConstraint = timezoneTextView.topAnchor
            .constraint(equalTo: timezoneContainer.topAnchor, constant: 16)
        let bottomConstraint = timezoneContainer.bottomAnchor
            .constraint(equalTo: timezoneTextView.bottomAnchor, constant: 16)
        
        timezoneContainer.addConstraints([
            leadingConstraint,
            trailingConstraint,
            topConstraint,
            bottomConstraint
        ])
        timezoneContainer.layoutIfNeeded()
        return timezoneTextView
    }
    
    private func setCurrencyContainer() -> UIView {
        let currencyContainer = UIView()
        currencyContainer.backgroundColor = .white
        contentView.addSubview(currencyContainer)
        
        currencyContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = currencyContainer.leadingAnchor
            .constraint(equalTo: contentView.leadingAnchor, constant: 16)
        let trailingConstraint = contentView.trailingAnchor
            .constraint(equalTo: currencyContainer.trailingAnchor, constant: 16)
        let topConstraint = currencyContainer.topAnchor
            .constraint(equalTo: countryDetailView.populationContainer.bottomAnchor,
                        constant: 16)
        let heightConstraint = currencyContainer.heightAnchor
            .constraint(equalToConstant: 53)
        
        contentView.addConstraints([
            leadingConstraint,
            trailingConstraint,
            topConstraint,
            heightConstraint
        ])
        contentView.layoutIfNeeded()
        currencyContainer.setShadow()
        return currencyContainer
    }
    
    private func setCurrencyImage() -> UIImageView {
        let currencyImage = UIImageView()
        currencyImage.image = UIImage(named: "currency")
        currencyImage.setImageColor(color: .baseOrange)
        
        guard let currencyContainer = countryDetailView.currencyContainer
        else { return UIImageView() }
        currencyContainer.addSubview(currencyImage)
        
        currencyImage.translatesAutoresizingMaskIntoConstraints = false
        
        let trailingConstraint = countryDetailView.currencyLabel.leadingAnchor
            .constraint(equalTo: currencyImage.trailingAnchor,
                        constant: 16)
        let centerYConstraint = currencyContainer.centerYAnchor
            .constraint(equalTo: currencyImage.centerYAnchor)
        let widthConstraint = currencyImage.widthAnchor
            .constraint(equalToConstant: 35)
        let heightConstraint = currencyImage.heightAnchor
            .constraint(equalToConstant: 30)
        
        
        currencyContainer.addConstraints([
            centerYConstraint,
            trailingConstraint,
            widthConstraint,
            heightConstraint
        ])
        currencyContainer.layoutIfNeeded()
        return currencyImage
    }
    
    private func setCurrencyLabel() -> UILabel {
        let currencyLabel = UILabel()
        format(label: currencyLabel)
        currencyLabel.text = country.currencies?.first?.name
        
        guard let currencyContainer = countryDetailView.currencyContainer
        else { return UILabel() }
        currencyContainer.addSubview(currencyLabel)
        
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let centerXConstraint = currencyContainer.centerXAnchor
            .constraint(equalTo: currencyLabel.centerXAnchor, constant: -21)
        let centerYConstraint = currencyContainer.centerYAnchor
            .constraint(equalTo: currencyLabel.centerYAnchor)
        let heightConstraint = currencyLabel.heightAnchor
            .constraint(equalTo: currencyContainer.heightAnchor)
        
        currencyContainer.addConstraints([
            centerXConstraint,
            centerYConstraint,
            heightConstraint
        ])
        currencyContainer.layoutIfNeeded()
        return currencyLabel
    }
    
    private func setBordersContainer() -> UIView {
        let bordersContainer = UIView()
        bordersContainer.backgroundColor = .white
        contentView.addSubview(bordersContainer)
        
        bordersContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = bordersContainer.leadingAnchor
            .constraint(equalTo: contentView.leadingAnchor, constant: 16)
        let trailingConstraint = contentView.trailingAnchor
            .constraint(equalTo: bordersContainer.trailingAnchor, constant: 16)
        let topConstraint = bordersContainer.topAnchor
            .constraint(equalTo: countryDetailView.currencyContainer.bottomAnchor,
                        constant: 16)
        let heightConstraint = bordersContainer.heightAnchor
            .constraint(equalToConstant: 170)
        
        contentView.addConstraints([
            leadingConstraint,
            trailingConstraint,
            topConstraint,
            heightConstraint
        ])
        contentView.layoutIfNeeded()
        bordersContainer.setShadow()
        return bordersContainer
    }
    
    private func setBordersLabel() -> UILabel {
        let borderLabel = UILabel()
        format(label: borderLabel)
        borderLabel.text = "Borders"
        
        guard let borderContainer = countryDetailView.bordersContainer
        else { return UILabel() }
        borderContainer.addSubview(borderLabel)
        
        borderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let centerXConstraint = borderContainer.centerXAnchor
            .constraint(equalTo: borderLabel.centerXAnchor, constant: 0)
        let topConstraint = borderLabel.topAnchor
            .constraint(equalTo: borderContainer.topAnchor, constant: 16)
        let heightConstraint = borderLabel.heightAnchor
            .constraint(equalToConstant: 25)
        
        borderContainer.addConstraints([
            centerXConstraint,
            topConstraint,
            heightConstraint
        ])
        borderContainer.layoutIfNeeded()
        return borderLabel
    }
    
    private func format(label: UILabel) {
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 20)
    }
}


