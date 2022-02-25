//
//  DependencyContainer.swift
//  TransportApp
//
//  Created by Maximus on 25.02.2022.
//

import Foundation


class DependencyContainer {
    
    static let shared = DependencyContainer()
    let network = Network()
    
}

extension DependencyContainer: ViewControllerFactory {
   
   
    func makeTransportStopDetailVC() -> TransportStopDetailVC {
        return TransportStopDetailVC(initialHeight: 300)
    }
    
    func makeDetailMapViewController(transportStopId: String?) -> DetailMapViewController {
        return DetailMapViewController(viewModel: makeDetailMapViewModel(transportStopId: transportStopId))
    }
    
    func makeTransportStopListVC() -> TransportStopListVC {
        return TransportStopListVC()
    }
}

extension DependencyContainer: ViewModelFactory {
    func makeTransportStopsViewModel() -> TransportStopsViewModelProtocol {
        return TransportStopsViewModel(network: network)
    }
    
    func makeDetailMapViewModel(transportStopId: String?) -> DetailMapViewModelProtocol {
        return DetailMapViewModel(transportStopId: transportStopId, network: network)
    }
    
    
}
