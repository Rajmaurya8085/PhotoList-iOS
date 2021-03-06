//
//  PhotoService.swift
//  PhotoList_iOS
//
//  Created by Raj Maurya on 08/01/21.
//  Copyright © 2021 Xebia. All rights reserved.
//

import Foundation
import Combine

 class PhotoService: PhotoServiceProtocol {
    
    static let agent  =  NetworkingAgent()
    var sub : AnyCancellable?
    
    func fetchPhotoList(searchQueury:String, pageNo:String)->AnyPublisher<PhotoList , Error>{
        guard let url = makeNowplayingURlComponents(searchString: searchQueury, pageNo:pageNo).url else{
                 fatalError("")}
        let urlRequest =  URLRequest(url: url)
        return PhotoService.getPhotoList(urlRequest:urlRequest)
    }
    

    static func getPhotoList(urlRequest:URLRequest) -> AnyPublisher<PhotoList, Error>{
           return repos(urlRequest: urlRequest)
       }
    static func repos<T:Decodable>(urlRequest:URLRequest) -> AnyPublisher<T, Error> {
           return agent.execute(for:urlRequest)
               .map(\.value)
               .eraseToAnyPublisher()
       }
    
}


