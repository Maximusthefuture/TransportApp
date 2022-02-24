//
//  DataResponseError.swift
//  TransportApp
//
//  Created by Maximus on 24.02.2022.
//

import Foundation

enum DataResponseError: Error {
    case network
    case decoding
    
    var reason: String {
      switch self {
      case .network:
        return "An error occurred while fetching data ".localizedString
      case .decoding:
        return "An error occurred while decoding data".localizedString
      }
    }
}

extension String {
    var localizedString: String {
        return NSLocalizedString(self, comment: "")
    }
}
