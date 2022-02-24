//
//  Network.swift
//  TransportApp
//
//  Created by Maximus on 24.02.2022.
//

import Foundation


protocol NetworkProtocol: AnyObject {
    func sendRequest<T: Codable>(to: URL, params: [String: String], completion: @escaping (Result<T, Error>) -> Void)
}

class Network: NetworkProtocol {
    
    var session = URLSession.shared
    func sendRequest<T: Codable>(to: URL, params: [String : String], completion: @escaping (Result<T, Error>) -> Void) {
        
        session.dataTask(with: to) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data
            else {
                completion(Result.failure(DataResponseError.network))
                return
            }
            
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            completion(Result.success(decodedResponse))
            
        }.resume()
    }
}
