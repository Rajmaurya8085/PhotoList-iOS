//
//  PhotoListViewController.swift
//  PhotoList_iOS
//
//  Created by Raj Maurya on 08/01/21.
//  Copyright © 2021 Raj. All rights reserved.
//

import UIKit
import Combine
import ImageCache
class PhotoListViewController: UIViewController {
 
    @IBOutlet weak var tableView: UITableView!
    var viewModel: PhotoListProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel = PhotoListViewModel()
        viewModel.delegate = self
        viewModel.getPhotos(searchString: "")
    }

    private func configureUI() {
           title = NSLocalizedString("Photo", comment: "Photo")
       }
}

extension PhotoListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photoCell  =  tableView.dequeueReusableCell(withIdentifier: "PhotoListTableCell", for: indexPath) as? PhotoListTableCell
        
        photoCell?.selectionStyle = .none
        let image  =  viewModel.loadImage(for: viewModel.photos[indexPath.row], size: .small)
        photoCell?.setPhoto(posterImage: image)
            photoCell?.setData(photo: viewModel.photos[indexPath.row])
        return photoCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let controller  =   UIStoryboard.loadViewController(storyBoardName:"Main", identifierVC: "PreviewViewController", type: PreviewViewController.self)
            controller.viewModel = self.viewModel
            controller.photo =  viewModel.photos[indexPath.row]
            self.navigationController?.pushViewController(controller, animated: true)
    
     tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension PhotoListViewController:updateDelegate{
    func didReceivedData() {
        tableView.reloadData()
    }
}

