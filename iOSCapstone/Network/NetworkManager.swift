//
//  NetworkManager.swift
//  iOSCapstone
//
//  Created by Malik Muhammad on 3/24/26.
//

import Foundation
import Combine

protocol Network {
    func getInfo<T: Decodable>(urlString: String, modelType: T.Type) -> AnyPublisher<T, any Error>
}

struct NetworkManager {
    let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
}

extension NetworkManager: Network {
    func getInfo<T>(urlString: String, modelType: T.Type) -> AnyPublisher<T, any Error> where T : Decodable {
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
        
        return self.urlSession.dataTaskPublisher(for: url)
            .tryMap { (data, response) in
                guard let response = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                guard(200...299).contains(response.statusCode) else {
                    throw NetworkError.invalidResponseCode
                }
                
                return data
            }.decode(type: modelType.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
    }
    
    
}
