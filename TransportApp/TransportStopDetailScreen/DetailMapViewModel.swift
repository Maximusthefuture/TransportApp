//
//  DetailMapViewModel.swift
//  TransportApp
//
//  Created by Maximus on 24.02.2022.
//

import Foundation

protocol DetailMapViewModelProtocol {
    
}

class DetailMapViewModel {
    
    var transportStopId: String?
    fileprivate let network: NetworkProtocol?
    fileprivate var mosgorNetwork: MosgorNetwork?
    fileprivate var mosgorClient: MosgorClient?
    var reload: (() -> Void)?
    var transportStopLocation: ((_ lat: Double?, _ lon: Double?) -> Void)?
    
    init(transportStopId: String, network: NetworkProtocol?) {
        self.transportStopId = transportStopId
        self.network = network
        mosgorNetwork = MosgorNetwork(network: network!)
        mosgorClient = MosgorClient(network: mosgorNetwork)
        
    }
    
    func getTransportStopDetailInfo() {
        let url = URL(string: "https://api.mosgorpass.ru/v8.2/stop/\(transportStopId ?? "")")
        guard let url = url else {
            print("Wrong url", url)
            return
        }
        mosgorClient?.getTransportStopDetailInfo(from: url, completion: { stopDetail, error in
            self.transportStopLocation?(stopDetail?.lat, stopDetail?.lon)
        })
        
    }
    
    func getDataFromMapSDK() {
        
    }
}
