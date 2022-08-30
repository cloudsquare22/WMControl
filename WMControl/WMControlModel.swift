//
//  WMControlModel.swift
//  WMControl
//
//  Created by Shin Inaba on 2022/08/30.
//

import Foundation
import SwiftUI

final class WMControlModel: ObservableObject {
    static let shared = WMControlModel()
    let bluetoothService = BluetoothService()
    
    func startBluetoothService() {
        self.bluetoothService.start()
    }
}

