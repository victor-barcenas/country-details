//
//  BLEView.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 24/09/22.
//

import UIKit
import CoreBluetooth

class BLEView: UIViewController {
    
    private var coreBluetoothManager: CoreBluetoothManager!
    private var peripherals: [BLEAdvertisement] = [] {
        didSet {
            DispatchQueue.main.async { [ weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    private var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setRightBarButton("Scan", selector: #selector(startScaningBLE))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureTableView()
    }
    
    @objc func startScaningBLE() {
        navigationItem.rightBarButtonItem?.isEnabled = false
        peripherals = []
        coreBluetoothManager = CoreBluetoothManager(delegate: self)
    }
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let centerXConstraint = tableView.centerXAnchor
            .constraint(equalTo: view.centerXAnchor)
        let widthConstraint = tableView.widthAnchor
            .constraint(equalTo: view.widthAnchor)
        let topConstraint = tableView.topAnchor
            .constraint(equalTo: view.topAnchor)
        let bottomConstraint = tableView.bottomAnchor
            .constraint(equalTo: view.bottomAnchor)
        let heightConstraint = tableView.heightAnchor
            .constraint(equalTo: view.heightAnchor)
        
        view.addConstraints([
            widthConstraint,
            centerXConstraint,
            topConstraint,
            bottomConstraint,
            heightConstraint
        ])
        tableView.register(BLECell.self,
                           forCellReuseIdentifier: BLECell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        view.layoutIfNeeded()
    }
}

extension BLEView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let countryCell = tableView.dequeueReusableCell(withIdentifier: BLECell.identifier,
                                                              for: indexPath) as? BLECell else {
            return UITableViewCell()
        }
        let peripheral = peripherals[indexPath.row]
        countryCell.configure(with: peripheral)
        return countryCell
    }
}

extension BLEView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension BLEView: BluetoothManagerDelegate {
    func didDiscoverPeripheral(_ peripheral: CBPeripheral,
                               advertisementData: [String : Any],
                               rssi: String) {
        guard let peripheralName = peripheral.name else { return }
        let bleAdvertisement = BLEAdvertisement(name: peripheralName,
                                                advertisement: advertisementData,
                                                rssi: rssi)
        guard !peripherals.contains(where: { $0.name == peripheralName }) else { return }
        peripherals.append(bleAdvertisement)
    }
    
    func didFinishScan() {
        navigationItem.rightBarButtonItem?.isEnabled = true
        showMessage("BLE Scan finished", title: nil)
    }
    
    func permissionDenied() {
        print("permission denied")
    }
}
