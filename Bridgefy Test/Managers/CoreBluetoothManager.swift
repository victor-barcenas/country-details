//
//  CoreBluetoothManager.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 27/09/22.
//

import CoreBluetooth

final class CoreBluetoothManager: NSObject {
    
    private var centralManager: CBCentralManager!
    private var delegate: BluetoothManagerDelegate?
    private var timer: Timer!
    private var elapsedTime: Int = 0
    private var _isScanning: Bool = false
    var isScanning: Bool {
        get {
            return _isScanning
        }
        set {
            _isScanning = newValue
        }
    }
    
    init(delegate: BluetoothManagerDelegate) {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: .main)
        self.delegate = delegate
    }
    
    func startScanning() {
        let options: [String: Any] = [CBCentralManagerScanOptionAllowDuplicatesKey:
                                      NSNumber(value: false)]
        centralManager.scanForPeripherals(withServices: nil,
                                          options: options)
        isScanning = true
    }
    
    func stopScanning() {
        isScanning = false
        centralManager.stopScan()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(updateElapsedTime),
                                         userInfo: nil, repeats: true)
    }
    
    private func stopTimer() {
        guard timer != nil else {
            return
        }
        timer.invalidate()
    }
    
    @objc private func updateElapsedTime() {
        elapsedTime += 1
        guard elapsedTime == 30 else { return }
        elapsedTime = 0
        stopScanning()
        stopTimer()
        delegate?.didFinishScan()
    }
}

extension CoreBluetoothManager: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            startScanning()
            startTimer()
        case .poweredOff, .resetting, .unsupported:
            guard isScanning else { return }
            stopScanning()
        case .unauthorized:
            delegate?.permissionDenied()
        default: break
        }
    }
    
    func centralManager(_ central: CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any],
                        rssi RSSI: NSNumber) {
        delegate?.didDiscoverPeripheral(peripheral,
                                        advertisementData: advertisementData,
                                        rssi: "\(RSSI)")
    }
}
