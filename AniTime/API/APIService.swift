//
//  APIService.swift
//  SwiftUI-MVVM
//
//  Created by Yusuke Kita on 6/6/19.
//  Copyright © 2019 Yusuke Kita. All rights reserved.
//

import Foundation
import Combine

protocol APIRequestType {
    associatedtype Response: Decodable
    
    var path: String { get }
}

protocol APIServiceType {
    func response<Request>(from request: Request, querys: [String: String]?) -> AnyPublisher<Request.Response, APIServiceError> where Request: APIRequestType
}

final class APIService: APIServiceType {
    
    private let baseURL: URL
    init(baseURL: URL = URL(string: "https://ohli.moe")!) {
        self.baseURL = baseURL
    }

    func response<Request>(from request: Request, querys: [String: String]?) -> AnyPublisher<Request.Response, APIServiceError> where Request: APIRequestType {
    
    let pathURL = URL(string: request.path, relativeTo: baseURL)!
    
    var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = querys?.map { dict in
            return URLQueryItem(name: dict.key, value: dict.value)
        }
        
    var request = URLRequest(url: urlComponents.url!)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
    let decorder = JSONDecoder()
    return URLSession.shared.send(request: request)
        .flatMap { data in
            Publishers.Just(data)
                .decode(type: Request.Response.self, decoder: decorder)
                .mapError(APIServiceError.parseError)
        }
        .eraseToAnyPublisher()
    }
}
