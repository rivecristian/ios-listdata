//
//  DetailViewController.swift
//  ios-listdata
//
//  Created by Cristian Rivera on 1/8/20.
//  Copyright © 2020 Cristian Rivera. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet weak var photoImg: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var scrollView: UIScrollView!
    var itemSelected:Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let description = itemSelected?.description {
           self.descriptionTextView.text = description
        }
        
        if let url = itemSelected?.image {
            loadPhoto(urlImage: url)
         }
    }
    
    func loadPhoto (urlImage:String) {
        
        photoImg.kf.indicatorType = .activity
        photoImg.image = UIImage(named: "noneImage")
        photoImg.kf.indicatorType = .activity
         
        if let url = URL(string: urlImage) {
            photoImg.kf.setImage(with: url) { result in
                 switch result {
                 case .success(let value):
                     print("Image: \(value.image). Got from: \(value.cacheType)")
                 case .failure(let error):
                     print("Error: \(error)")
                     self.photoImg.image = UIImage(named: "noneImage")
                 }
             }
        }
        
    }

}
