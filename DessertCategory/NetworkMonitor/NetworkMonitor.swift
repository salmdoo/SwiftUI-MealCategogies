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
    private let workerQueue = DispatchQueue(label: "NetworkMonitor")
    
    var isConnected = false
    
    private init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        
        networkMonitor.start(queue: workerQueue)
    }
}
