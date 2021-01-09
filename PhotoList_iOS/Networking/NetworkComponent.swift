//
//  NetworkComponent.swift
//  PhotoList_iOS
//
//  Created by Raj Maurya on 08/01/21.
//  Copyright © 2021 Raj. All rights reserved.
//

import Foundation

extension PhotoService {
struct PhotoAPI {
  static let scheme = "https"
  static let host = "ey3f2y0nre.execute-api.us-east-1.amazonaws.com"
  static let path = "/default/dynamodb-writer"
}
    func makeNowplayingURlComponents(searchString:String , pageNo: String
) -> URLComponents {
  var components = URLComponents()
  components.scheme = PhotoAPI.scheme
  components.host = PhotoAPI.host
  components.path = PhotoAPI.path
  return components
}

}
