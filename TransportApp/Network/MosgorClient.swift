//
//  MosgorClient.swift
//  TransportApp
//
//  Created by Maximus on 24.02.2022.
//

import Foundation

protocol MosgorClientProtocol {
    func getTransportStopsData(from: URL, completion: @escaping (TransportStops?, Error?) -> Void)
    func getTransportStopDetailInfo(from: URL, completion: @escaping (TransportStopDetail?, Error?) -> Void)
}

class MosgorClient: MosgorClientProtocol {
    
    var network: MosgorNetworkProtocol?
    
    init(network: MosgorNetworkProtocol?) {
        self.network = network
    }
    
    func getTransportStopsData(from: URL, completion: @escaping (TransportStops?, Error?) -> Void) {
        network?.getTransportStops(from: from) { (data: TransportStops?, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            completion(data, nil)

        }
    }
    
    func getTransportStopDetailInfo(from: URL, completion: @escaping (TransportStopDetail?, Error?) -> Void) {
        network?.getTransportStopDetailInfo(from: from) { (data: TransportStopDetail?, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            completion(data, nil)
        }
    }
}
