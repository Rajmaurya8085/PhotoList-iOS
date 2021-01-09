//
//  NetworkingAgent.swift
//  PhotoList_iOS
//
//  Created by Raj Maurya on 08/01/21.
//  Copyright © 2021 Raj. All rights reserved.
//


import Foundation
import Combine

struct NetworkingAgent :NetworkServiceType {
    
    
    func execute<T>(for request: URLRequest, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> where T: Decodable {
        return URLSession.shared.dataTaskPublisher(for: request)
        .tryMap { result -> Response<T> in
            let value = try decoder.decode(T.self, from: result.data)
            return Response(value: value, response: result.response)
        }
        .mapError { $0 }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
            
    }
}

struct Response<T> {
    let value: T
    let response: URLResponse
}



protocol NetworkServiceType {
     func execute<T>(for request: URLRequest, decoder: JSONDecoder) -> AnyPublisher<Response<T>, Error> where T: Decodable
}
