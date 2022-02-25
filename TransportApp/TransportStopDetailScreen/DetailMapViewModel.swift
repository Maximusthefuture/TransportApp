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
    var getTransportStopData: ((TransportStopDetail?) -> Void)? { get set }
    func saveLocationToUserDefaults()
}

class DetailMapViewModel: DetailMapViewModelProtocol {
    
    var getTransportStopData: ((TransportStopDetail?) -> Void)?
    
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
        let url = URL(string: "https://api.mosgorpass.ru/v8.2/stop/\(transportStopId ?? "00000000")")
        guard let url = url else {
            print("Wrong url", url)
            return
        }
        mosgorClient?.getTransportStopDetailInfo(from: url, completion: { stopDetail, error in
            self.transportStopLocation?(stopDetail?.lat, stopDetail?.lon)
            self.getTransportStopData?(stopDetail)
        })
        
    }
    
    func saveLocationToUserDefaults() {
        UserDefaults.standard.set(transportStopId, forKey: "transportStopId")
    }
}

