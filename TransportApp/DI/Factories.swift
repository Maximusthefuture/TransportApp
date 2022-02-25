//
//  Factories.swift
//  TransportApp
//
//  Created by Maximus on 25.02.2022.
//

import Foundation


protocol ViewControllerFactory {
    func makeTransportStopListVC() -> TransportStopListVC
    func makeDetailMapViewController(transportStopId: String?) -> DetailMapViewController
    func makeTransportStopDetailVC(transportStopDetail: TransportStopDetail?) -> TransportStopDetailVC
}


protocol ViewModelFactory {
    func makeTransportStopsViewModel() -> TransportStopsViewModelProtocol
    func makeDetailMapViewModel(transportStopId: String?) -> DetailMapViewModelProtocol
    func makeTransportStopDetailViewModel(transportStopDetail: TransportStopDetail?) -> TransportStopDetailViewModelProtocol
}
