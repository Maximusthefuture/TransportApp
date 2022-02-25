//
//  Factories.swift
//  TransportApp
//
//  Created by Maximus on 25.02.2022.
//

import Foundation


protocol ViewControllerFactory {
    func makeTransportStopListVC() -> TransportStopListVC
    func makeTransportStopDetailVC() -> TransportStopDetailVC
    func makeDetailMapViewController(transportStopId: String?) -> DetailMapViewController
}


protocol ViewModelFactory {
    func makeTransportStopsViewModel() -> TransportStopsViewModelProtocol
    func makeDetailMapViewModel(transportStopId: String?) -> DetailMapViewModelProtocol
//    func makeTransportStopDetailViewModel() -> TransportStopDetailVMProtocol
}
