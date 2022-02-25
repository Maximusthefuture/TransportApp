//
//  TransportStopDetailViewModel.swift
//  TransportApp
//
//  Created by Maximus on 25.02.2022.
//

import Foundation


protocol TransportStopDetailViewModelProtocol {
    var transportArray: [String] { get set }
}


class TransportStopDetailViewModel: TransportStopDetailViewModelProtocol {
    
    var transportArray: [String] = ["One", "Two", "Three", "Four", "Five"]
    
    
}
