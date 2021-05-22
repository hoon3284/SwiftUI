//
//  FoundationExtensions.swift
//  SwiftUI-Combine-Example
//
//  Created by wickedRun on 2021/05/22.
//

import SwiftUI
import Combine

enum URLSessionError: Error {
    case invalidResponse
    case serverErrorMessage(statusCode: Int, data: Data)
    case urlError(URLError)
}

extension URLSession {
    func send(requset: URLRequest) -> AnyPublisher<Data, URLSessionError> {
        
        dataTaskPublisher(for: requset)
            .mapError { URLSessionError.urlError($0) }
            .flatMap { data, response -> AnyPublisher<Data, URLSessionError> in
                guard let response = response as? HTTPURLResponse else {
                    return .fail(.invalidResponse)
                }
                
                guard 200..<300 ~= response.statusCode else {
                    return .fail(.serverErrorMessage(statusCode: response.statusCode,
                                                     data: data))
                }
                
                return .just(data)
            }.eraseToAnyPublisher()
    }
}

//extension JSONDecoder: TopLevelDecoder {}

//extension Publisher {
//    /// - seealso: https://twitter.com/peres/status/1136132104020881408
////    func flatMapLatest<T: Publisher>
//}

extension Publisher {
    static func empty() -> AnyPublisher<Output, Failure> {
        return empty()
            .eraseToAnyPublisher()
    }

    static func just(_ output: Output) -> AnyPublisher<Output, Failure> {
        return Just(output)
            .catch { _ in AnyPublisher<Output, Failure>.empty() }
            .eraseToAnyPublisher()
    }
    
    static func fail(_ error: Failure) -> AnyPublisher<Output, Failure> {
        return Fail(error: error)
            .eraseToAnyPublisher()
    }
}
