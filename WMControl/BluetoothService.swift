//
//  BluetoothService.swift
//  WMControl
//
//  Created by Shin Inaba on 2022/08/30.
//

import Foundation
import CoreBluetooth

class BluetoothService: NSObject {
    var peripheralManager: CBPeripheralManager! = nil
    
    func start() {
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
    }
    
    func startAdvertising() {
        let serviceUUIDs = [CBUUID(string: "0000110E-0000-1000-8000-00805F9B34FB")]
        let advertisementData: Dictionary = [CBAdvertisementDataLocalNameKey: "WMControl",
                                          CBAdvertisementDataServiceUUIDsKey: serviceUUIDs] as [String : Any]
        self.peripheralManager.startAdvertising(advertisementData)
    }
    
    func startService() {
        let serviceUUID = CBUUID(string: "0000110E-0000-1000-8000-00805F9B34FB")
        let service = CBMutableService(type: serviceUUID, primary: true)

        // キャラクタリスティックを作成
        let characteristicUUID = CBUUID(string: "0001")
        let characteristic = CBMutableCharacteristic(
            type: characteristicUUID,
            properties: .read,
            value: nil,
            permissions: .readable)

        // キャラクタリスティックをサービスにセット
        service.characteristics = [characteristic]

        // サービスを追加
        self.peripheralManager.add(service)
    }
    
}

extension BluetoothService: CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        print("State: \(peripheral.state)")
        if peripheral.state == .poweredOn {
            self.startService()
        }
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if error == nil {
            print("Advertising start")
        }
        else {
            print("Error:\(error!.localizedDescription)")
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        if error == nil {
            print("Service start")
            self.startAdvertising()
        }
        else {
            print("Error:\(error!.localizedDescription)")
        }
    }
}
