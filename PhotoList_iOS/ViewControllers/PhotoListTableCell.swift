//
//  PhotoListTableCell.swift
//  PhotoList_iOS
//
//  Created by Raj Maurya on 10/01/21.
//  Copyright © 2021 Raj. All rights reserved.
//

import Foundation
import UIKit
import Combine

class PhotoListTableCell:UITableViewCell{
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var createDateLbl: UILabel!
    
    private var cancellable: AnyCancellable?
    override func awakeFromNib() {
        
    }
    
    func setPhoto(posterImage:AnyPublisher<UIImage?, Never>){
          cancellable = posterImage.sink { [unowned self] image in self.showImage(image: image) }

       }
         private func showImage(image: UIImage?) {
           cancelImageLoading()
           UIView.transition(with: self.photoImageView,
           duration: 0.3,
           options: [.curveEaseOut, .transitionCrossDissolve],
           animations: {
               self.photoImageView.image = image
           })
       }

    func setData(photo:Photo){
        nameLbl.text =  photo.name ?? ""
        priceLbl.text =  photo.price ?? ""
        createDateLbl.text =  photo.created_at ?? ""
    }
       private func cancelImageLoading() {
           photoImageView.image = nil
           cancellable?.cancel()
       }
    
    
    override func prepareForReuse() {
        photoImageView.image = nil
    }
}
