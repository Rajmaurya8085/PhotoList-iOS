//
//  Service.swift
//  PhotoList_iOS
//
//  Created by Raj Maurya on 08/01/21.
//  Copyright © 2021 Raj. All rights reserved.
//

import Foundation

struct Service {
  
    enum LifeCycle  {
        case single
        case new
    }
    
    // Life cycle for the current service
    var lifeCycle: LifeCycle
    
    // Unique Identifier
    let name: ObjectIdentifier
    var instance: Any?
    
    private let resolve: (Dependencies) -> Any
    
    func createInstance(d: Dependencies) -> Any {
        return resolve(d)
    }
    
    init<Service>(_ lifeCycle: LifeCycle = .new, resolve: @escaping (Dependencies) -> Service) {
        self.name = ObjectIdentifier(Service.self)
        self.lifeCycle = lifeCycle
        self.resolve = resolve
    }
}
