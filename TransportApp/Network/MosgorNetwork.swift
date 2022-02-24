//
//  MosgorNetwork.swift
//  TransportApp
//
//  Created by Maximus on 24.02.2022.
//

import Foundation


protocol MosgorNetworkProtocol: AnyObject {
    func getTransportStops<T:Codable>(from: URL, completion: @escaping (T?, Error?) -> Void)
    func getTransportStopDetailInfo<T: Codable>(from: URL, completion: @escaping (T?, Error?) -> Void)
}


class MosgorNetwork: MosgorNetworkProtocol {
   
    var network: NetworkProtocol?
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getTransportStops<T: Codable>(from: URL, completion: @escaping (T?, Error?) -> Void) {
        network?.sendRequest(to: from, params: [:], completion: { (result: Result<T, Error>) in
            switch result {
            case .failure(let error):
                completion(nil, error)
            case .success(let success):
                completion(success, nil)
            }
        })
    }
    
    func getTransportStopDetailInfo<T: Codable>(from: URL, completion: @escaping (T?, Error?) -> Void) {
        network?.sendRequest(to: from, params: [:], completion: { (result: Result<T, Error>) in
            switch result {
            case .failure(let error):
                completion(nil, error)
            case .success(let success):
                completion(success, nil)
            }
        })
    }
    
    
    
}
