//
//  NetworkMonitor.swift
//  Assignment
//
//  Created by Venkatesham Boddula on 28/02/25.
//

import Foundation
import Network

class NetworkMonitor: ObservableObject {
    
    @Published var isConnected: Bool = true
    private var monitor: NWPathMonitor = NWPathMonitor()
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        let dispatchQueue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: dispatchQueue)
    }
    
}
