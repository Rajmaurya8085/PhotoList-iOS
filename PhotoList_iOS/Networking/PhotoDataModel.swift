//
//  PhotoDataModel.swift
//  PhotoList_iOS
//
//  Created by Raj Maurya on 08/01/21.
//  Copyright © 2021 Raj. All rights reserved.
//

import Foundation

struct PhotoList:Codable {
    var results:[Photo]
}

struct Photo:Codable {
    let created_at:String?
       let price:String?
       let name:String?
       let uid:String?
       let image_ids:[String]
       let image_urls:[String]
    let image_urls_thumbnails:[String]
}
