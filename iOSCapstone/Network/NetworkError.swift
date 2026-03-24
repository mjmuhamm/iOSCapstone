//
//  NetworkError.swift
//  iOSCapstone
//
//  Created by Malik Muhammad on 3/24/26.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case noData
    case invalidResponse
    case invalidResponseCode
    case parsingError
}

extension NetworkError: LocalizedError {
    var errorDescription : String? {
        switch self {
        case .invalidUrl:
            return "Wrong End Point"
        case .noData:
            return "Failed to get data from API"
        case .invalidResponse:
            return "We got undesired reponse from API"
        case .invalidResponseCode:
            return "We got failed status code from api"
        case .parsingError:
            return "Failed to parse JSON data from response "
        }
    }
}
