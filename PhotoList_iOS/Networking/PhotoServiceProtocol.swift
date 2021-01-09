//
//  PhotoServiceProtocol.swift
//  PhotoList_iOS
//
//  Created by Raj Maurya on 08/01/21.
//  Copyright © 2021 Raj. All rights reserved.
//

import Foundation
import Combine

// You are free to change the method signature
protocol PhotoServiceProtocol {
    func fetchPhotoList(searchQueury:String, pageNo:String)->AnyPublisher<PhotoList , Error>
   
}

