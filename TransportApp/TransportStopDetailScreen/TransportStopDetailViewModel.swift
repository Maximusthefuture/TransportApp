//
//  TransportStopDetailViewModel.swift
//  TransportApp
//
//  Created by Maximus on 25.02.2022.
//

import Foundation


protocol TransportStopDetailViewModelProtocol {
    var transportArray: [RoutePath] { get set }
    func getData()
    var transportStopName: String { get }
}

class TransportStopDetailViewModel: TransportStopDetailViewModelProtocol {

    fileprivate var transportStopDetail: TransportStopDetail?
    var transportArray: [RoutePath] = []
    
    var transportStopName: String {
        return transportStopDetail?.name ?? ""
    }
    
    init(transportStopDetail: TransportStopDetail?) {
        self.transportStopDetail = transportStopDetail
    }
    
    func getData() {
        transportArray.append(contentsOf: transportStopDetail?.routePath ?? [])
    }
}


enum TransportType: String {
    case bus = "bus"
    case train = "train"
}
