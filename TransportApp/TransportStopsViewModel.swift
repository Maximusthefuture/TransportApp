//
//  BusStopsViewModel.swift
//  TransportApp
//
//  Created by Maximus on 24.02.2022.
//

import Foundation

protocol TransportStopsViewModelProtocol {
    
}


class TransportStopsViewModel: TransportStopsViewModelProtocol {
    
    //MARK: FACTORY, DI???
    
    fileprivate var network: NetworkProtocol?
    fileprivate var mosgorNetwork: MosgorNetwork?
    fileprivate var mosgorClient: MosgorClient?
    fileprivate var busStopsArray = [TransportData]()
    var reload: (() -> Void)?
    var getError: ((Error?) -> Void)?
    
    
    var busStopsCount: Int {
        return busStopsArray.count
    }
    
    func busStopItem(at index: Int) -> TransportData {
        return busStopsArray[index]
    }
    
    init(network: NetworkProtocol) {
        self.network = network
        mosgorNetwork = MosgorNetwork(network: network)
        mosgorClient = MosgorClient(network: mosgorNetwork)
    }
    
    func getTransportStopsList() {
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
