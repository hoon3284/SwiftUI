//
//  URLSession+Combine.swift
//  GitHubSearchWithSwiftUI
//
//  Created by wickedRun on 2021/05/26.
//

import Foundation
import Combine

extension URLSession: CombineCompatible {}

extension CombineExtension where Base == URLSession {
    
    func send(request: URLRequest) -> AnyPublisher<Data, URLSessionError> {
        base.dataTaskPublisher(for: request)
            .mapError { URLSessionError.urlError($0) }
            .flatMap { data, response -> AnyPublisher<Data, URLSessionError> in
                guard let response = response as? HTTPURLResponse else {
                    return .fail(.invalidResponse)
                }
                
                guard 200..<300 ~= response.statusCode else {
                    return .fail(.serverErrorMessage(statusCode: response.statusCode, data: data))
                }
                
                return .just(data)
            }
            .eraseToAnyPublisher()
    }
}

enum URLSessionError: Error {
    case invalidResponse
    case serverErrorMessage(statusCode: Int, data: Data)
    case urlError(URLError)
}
