//
//  Network.swift
//  task-ios
//
//  Created by Vladislav Kobyakov on 28.11.23.
//

import Foundation

class Network {
    static let shared = Network()
    
    let server = "bitsfabrik.com"
    let https = "https://"
    let apiBaseUri = "/projekte/imaginary/api"
    lazy var baseUrlString = "\(https)\(server)\(apiBaseUri)"
    
    enum TourifyError: Error, Equatable {
        case invalidJSON(description: String)
        case invalidResponse(responseStatusCode: Int)
        case unknownError(description: String)
        
        case cannotLoadTours(description: String)
        case cannotLoadTourDetails(description: String)
    }
    
    enum HttpMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
}

///Mark: Network helper functions
extension Network {
    func encodeParams(params: [String : Any]) -> String {
        var data = [String]()
        for(key, value) in params {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    func configureGeneralRequest(uriPath: String, httpMethod: Network.HttpMethod, params: [String : Any]? = nil, putParamsInUrl: Bool = false) -> (session: URLSession, request: URLRequest)? {
                
        var url: URL?
        
        if putParamsInUrl {
            if let params = params {
                url = URL(string: Network.shared.baseUrlString + uriPath + "?" + encodeParams(params: params))
            }
        } else {
            url = URL(string: Network.shared.baseUrlString + uriPath)
        }
        
        guard let url = url else { return nil }
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        let session = URLSession(configuration: config)
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if let params = params, !putParamsInUrl {
            let postBodyString = encodeParams(params: params)
            request.httpBody = postBodyString.data(using: .utf8)
        }
        
        return (session, request)
    }
}
