//
//  PhotoList_iOSTests.swift
//  PhotoList_iOSTests
//
//  Created by Raj Maurya on 10/01/21.
//  Copyright © 2021 Xebia. All rights reserved.
//

import XCTest

 @testable import PhotoList_iOS

class PhotoList_iOSTests: XCTestCase {

  lazy var service =  PhotoService()
     lazy var viewModel = PhotoListViewModel()

    
     lazy var dummyModel = Photo(created_at: "2019-02-23 11:40:26.022080", price: "AED 600", name: "acoustic guitar", uid: "130f46715a20423896606703bb783eda", image_ids:  [
        "920ccd0ccd664699aed8b4e09ea55096"
      ], image_urls:  [
        "https://image.tmdb.org/t/p/w185/wxPhn4ef1EAo5njxwBkAEVrlJJG.jpg"
      ], image_urls_thumbnails: [
     "https://image.tmdb.org/t/p/w185/wxPhn4ef1EAo5njxwBkAEVrlJJG.jpg"
   ])

     func testPhotoRequestUrl() {
         let urlRequest = service.makeNowplayingURlComponents(searchString: "", pageNo: "1")
      
        XCTAssert(urlRequest.url?.scheme ==  "https", "Url Request Schema Wrong")
        XCTAssert(urlRequest.url?.path ==  "/default/dynamodb-writer", "Url Request path Wrong")
        XCTAssert(urlRequest.url?.host ==  "ey3f2y0nre.execute-api.us-east-1.amazonaws.com", "Url Request host Wrong")
         
     }
     
     func testPhotoApiCall(){
         let paynow =  service.fetchPhotoList(searchQueury: "india", pageNo: "1")
        let expectation = XCTestExpectation(description: "Download photo home page")
         
         let data  =  paynow.sink(receiveCompletion: { (completionError) in
         switch completionError {
         case .failure( _):
                 XCTAssertNil(completionError, " error during fetching Now photo data .")
                   case .finished:
                      expectation.fulfill()
                       break
                   }
                }) { (data) in
                 print(data)
                 XCTAssertNotNil(data, "No  not able to fetch Photos .")
                 expectation.fulfill()
                }
         
         wait(for: [expectation], timeout: 10.0)
              
     }
     func testImageDownload(){
         let expectation = XCTestExpectation(description: "Download image home page"
             )
             let posterImage  =  viewModel.loadImage(for: dummyModel, size:.original)
               .sink {  image in
              XCTAssertNotNil(image, "No  not able to fetch Photo .")
              expectation.fulfill()

            }
       wait(for: [expectation], timeout: 20.0)
        }
     
     

  

}
