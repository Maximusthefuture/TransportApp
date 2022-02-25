//
//  DetailMapViewModel.swift
//  TransportApp
//
//  Created by Maximus on 24.02.2022.
//

import Foundation

protocol DetailMapViewModelProtocol {
    func getTransportStopDetailInfo()
    var transportStopLocation: ((_ lat: Double?, _ lon: Double?) -> Void)? { get set }
}

class DetailMapViewModel: DetailMapViewModelProtocol {
    
    fileprivate var transportStopId: String?
    fileprivate var mosgorNetwork: MosgorNetworkProtocol?
    fileprivate var mosgorClient: MosgorClientProtocol?
    var reload: (() -> Void)?
    var transportStopLocation: ((_ lat: Double?, _ lon: Double?) -> Void)?
    
    init(transportStopId: String?, mosgorNetwork: MosgorNetworkProtocol, mosgorClient: MosgorClientProtocol) {
        self.transportStopId = transportStopId
        self.mosgorNetwork = mosgorNetwork
        self.mosgorClient = mosgorClient
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
