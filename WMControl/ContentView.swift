//
//  ContentView.swift
//  WMControl
//
//  Created by Shin Inaba on 2022/08/28.
//

import SwiftUI

struct ContentView: View {
    @StateObject var wmcontrolmodel: WMControlModel = WMControlModel.shared
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear() {
            self.wmcontrolmodel.startBluetoothService()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
