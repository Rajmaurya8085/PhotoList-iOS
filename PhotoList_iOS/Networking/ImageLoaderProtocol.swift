//
//  ImageLoaderProtocol.swift
// 
//
//  Created by Raj Maurya on 08/01/21.
//  Copyright © 2021 Raj. All rights reserved.
//


import Foundation
import UIKit.UIImage
import Combine

public protocol ImageLoaderServiceProtocol: AnyObject {
    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never>
}

