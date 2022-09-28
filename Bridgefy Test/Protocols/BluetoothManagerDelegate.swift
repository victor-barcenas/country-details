//
//  BluetoothManagerDelegate.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 27/09/22.
//

import CoreBluetooth

protocol BluetoothManagerDelegate {
    func didDiscoverPeripheral(_ peripheral: CBPeripheral,
                               advertisementData: [String : Any],
                               rssi: String)
    func didFinishScan()
    func permissionDenied()
}
