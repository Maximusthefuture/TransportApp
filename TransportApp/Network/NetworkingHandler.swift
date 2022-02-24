//
//  NetworkingHandler.swift
//  TransportApp
//
//  Created by Maximus on 24.02.2022.
//

import Foundation

class NetworkingHandler: NSObject, URLSessionTaskDelegate {
    
    func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask) {
        print("waiting")
    }
}
