//
//  BusStopsViewModel.swift
//  TransportApp
//
//  Created by Maximus on 24.02.2022.
//

import Foundation

protocol TransportStopsViewModelProtocol {
    var reload: (() -> Void)? { get set }
    var getError: ((Error?) -> Void)? { get set }
    var busStopsCount: Int { get }
    func busStopItem(at index: Int) -> TransportData
    func getTransportStopsList()
}

class TransportStopsViewModel: TransportStopsViewModelProtocol {
    
//    fileprivate var network: NetworkProtocol?
    fileprivate var mosgorNetwork: MosgorNetworkProtocol?
    fileprivate var mosgorClient: MosgorClientProtocol?
    fileprivate var busStopsArray = [TransportData]()
    var reload: (() -> Void)?
    var getError: ((Error?) -> Void)?
    
    var busStopsCount: Int {
        return busStopsArray.count
    }
    
    func busStopItem(at index: Int) -> TransportData {
        return busStopsArray[index]
    }
    
    init(mosgorNetwork: MosgorNetworkProtocol, mosgorClient: MosgorClientProtocol) {
//        self.network = network
        self.mosgorNetwork = mosgorNetwork
        self.mosgorClient = mosgorClient
    }
    
    func getTransportStopsList() {
        getStopListsFromClient()
    }
    
    fileprivate func getStopListsFromClient() {
        let url = URL(string:"https://api.mosgorpass.ru/v8.2/stop")
        guard let url = url else { return }
        mosgorClient?.getTransportStopsData(from: url) { busStops, error in
            if let error = error {
                self.getError?(error)
            }
            self.busStopsArray.append(contentsOf: busStops?.data ?? [])
            self.reload?()
        }
    }
}
