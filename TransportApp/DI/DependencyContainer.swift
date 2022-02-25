//
//  DependencyContainer.swift
//  TransportApp
//
//  Created by Maximus on 25.02.2022.
//

import Foundation

final class DependencyContainer {
    
    private var network: NetworkProtocol?
    private var mosgorNetwork: MosgorNetworkProtocol!
    private var mosgorClient: MosgorClientProtocol!
    
    fileprivate init() {
        self.network = Network()
        self.mosgorNetwork = MosgorNetwork(network: network)
        self.mosgorClient = MosgorClient(network: mosgorNetwork)
    }
    
    fileprivate static var sharedDIContainer: DependencyContainer {
        let dependencyContainer = DependencyContainer()
        return dependencyContainer
    }
    
    class func shared() -> DependencyContainer {
        return sharedDIContainer
    }
}

extension DependencyContainer: ViewControllerFactory {
 
    func makeTransportStopDetailVC(transportStopDetail: TransportStopDetail?) -> TransportStopDetailVC {
        return TransportStopDetailVC(initialHeight: 300, viewModel: makeTransportStopDetailViewModel(transportStopDetail: transportStopDetail))
    }
    

    
    func makeDetailMapViewController(transportStopId: String?) -> DetailMapViewController {
        return DetailMapViewController(viewModel: makeDetailMapViewModel(transportStopId: transportStopId))
    }
    
    func makeTransportStopListVC() -> TransportStopListVC {
        return TransportStopListVC(viewModel: makeTransportStopsViewModel())
    }
}

extension DependencyContainer: ViewModelFactory {
    func makeTransportStopDetailViewModel(transportStopDetail: TransportStopDetail?) -> TransportStopDetailViewModelProtocol {
        return TransportStopDetailViewModel(transportStopDetail: transportStopDetail)
    }
    
    func makeTransportStopsViewModel() -> TransportStopsViewModelProtocol {
        return TransportStopsViewModel(mosgorNetwork: mosgorNetwork, mosgorClient: mosgorClient)
    }
    
    func makeDetailMapViewModel(transportStopId: String?) -> DetailMapViewModelProtocol {
        return DetailMapViewModel(transportStopId: transportStopId, mosgorNetwork: mosgorNetwork, mosgorClient: mosgorClient)
    }
}

