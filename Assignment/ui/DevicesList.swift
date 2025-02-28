//
//  ComputerList.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI

struct DevicesList: View {
    let devices: [DeviceData]
    let onSelect: (DeviceData) -> Void // Callback for item selection
    
    @State private var searchText: String = ""
    
    private var filteredDevices: [DeviceData] {
        if searchText.isEmpty {
            return devices
        }
        return devices.filter { _deviceData in
            _deviceData.name.lowercased().contains(searchText.lowercased())
        }
    }


    var body: some View {
        List(filteredDevices) { device in
            Button {
                onSelect(device)
            } label: {
                VStack(alignment: .leading) {

                    AssignmentText(text: device.name)
                        .fontWeight(.bold)
                    AssignmentText(text: "Color: \(device.data?.color ?? "NA")")
                        .fontWeight(.regular)
                    AssignmentText(text: "Capacity: \(device.data?.capacity ?? "NA")")
                        .fontWeight(.regular)
                    
                }
                .foregroundStyle(.black)
            }
        }
        .listStyle(.plain)
        .searchable(text: $searchText)
    }
}
