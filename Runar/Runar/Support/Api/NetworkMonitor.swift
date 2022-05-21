//
//  NetworkMonitor.swift
//  Runar
//
//  Created by Георгий Ступаков on 2/21/22.
//

//TODO: No Internet
//import UIKit
//import Network
//
//class NetworkMonitor {
//    static let shared = NetworkMonitor()
//
//    private let queue = DispatchQueue.global()
//    private let monitor: NWPathMonitor
//
//    public private(set) var isConnected: Bool = false
//
//    private init() {
//        monitor = NWPathMonitor()
//    }
//
//    public func startMonitoring() {
//        monitor.start(queue: queue)
//        monitor.pathUpdateHandler = { [weak self] path in
//            self?.isConnected = path.status == .satisfied
//        }
//    }
//
//    public func stopMonitoring() {
//        monitor.cancel()
//    }
//}
