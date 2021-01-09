//
//  Inject.swift
//  PhotoList_iOS
//
//  Created by Raj Maurya on 08/01/21.
//  Copyright © 2021 Raj. All rights reserved.
//

import Foundation

@propertyWrapper
struct Inject<T> {
    private var service: T?
    
    init(){}
    
    var wrappedValue: T {
        mutating get {
        service ?? {
            service =  Dependencies.main.get(type: T.self)
                return service!
                }()
        }
        
    }
}
