//
//  NetworkMonitor.swift
//  DessertCategory
//
//  Created by Salmdo on 11/9/23.
//

import Foundation

import Network

class NetworkMonitor {
    static let instance = NetworkMonitor()
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    
    var isConnected: Bool {
        didSet {
            print("Network status changed: \(isConnected ? "Connected" : "Disconnected") - \(isConnected)")
        }
    }
    
    private init() {
        isConnected = false
        
        networkMonitor.start(queue: workerQueue)
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        
    }
}
