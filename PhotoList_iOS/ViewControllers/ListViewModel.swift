//
//  ListViewModel.swift
//  PhotoList_iOS
//
//  Created by Raj Maurya on 08/01/21.
//  Copyright © 2021 Raj. All rights reserved.
//

import Foundation
import UIKit.UIImage
import Combine
import ImageCache

protocol updateDelegate:class {
    func didReceivedData()
}

protocol PhotoListProtocol {
    func getPhotos(searchString:String)
    func loadImage(for photo: Photo, size: ImageSize) -> AnyPublisher<UIImage?, Never>
    var photos:[Photo]{get set}
    var delegate:updateDelegate? { get set }
    
}

class PhotoListViewModel:PhotoListProtocol{
    @Inject private var photoService: PhotoServiceProtocol
    @Inject private  var imageLoaderService:ImageLoaderServiceProtocol
    private var sub : AnyCancellable?
    weak var delegate:updateDelegate?
    var pageNo :Int = 0
    var photos:[Photo] =  [Photo]()
    
    
    init() {
    
    }

    func getPhotos(searchString:String){
        let photoList = photoService.fetchPhotoList(searchQueury: searchString, pageNo:"1")

           parseJsonModel(data: photoList) {[weak self] (data) in
            self?.photos = data.results

                self?.delegate?.didReceivedData()
               }
           }
       
    func parseJsonModel<T:Codable>(data : AnyPublisher<T, Error>, callback :@escaping(T)->Void){
        sub =   data.sink(receiveCompletion: { (completionError) in
            switch completionError {
            case .failure(let error):
                print(error.localizedDescription)
            case .finished:
                break
            }
        }) { (data) in
            print(data)
            callback(data)
        }
    }
    
    func loadImage(for photo: Photo, size: ImageSize) -> AnyPublisher<UIImage?, Never> {
       
        return Deferred { return Just( photo.image_urls_thumbnails.first) }
            .flatMap({[unowned self] poster -> AnyPublisher<UIImage?, Never> in
                guard let thum = photo.image_urls_thumbnails.first, let image = photo.image_urls.first  , let url  =  URL(string: size ==  size ? thum : image) else { return .just(nil) }
                return self.imageLoaderService.loadImage(from: url)
            })
            .receive(on: DispatchQueue.main)
            .share()
            .eraseToAnyPublisher()
    }
}
