//
//  ListViewController.swift
//  ios-listdata
//
//  Created by Cristian Rivera on 1/8/20.
//  Copyright © 2020 Cristian Rivera. All rights reserved.
//

import UIKit
import Kingfisher

class ListViewController: UIViewController {

    var dicData:[[String:Any]] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData () {
        
        let apiService = ApiService()
        apiService.getListData() { (result) in
            self.dicData = result
            print("dicData: \(self.dicData.description)")
            self.tableView.reloadData()
        }
    }
}

extension ListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return dicData.count
     }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
         let array = Array(dicData)
         let current = array[indexPath.row]
         let title = current["title"] as? String ?? ""
         let description = current["description"] as? String ?? ""
         
        
         print("title: \(title)")
        print("description: \(description)")
        
        
        let cell = Bundle.main.loadNibNamed("TableViewCellCustom", owner: self, options: nil)?.first as! TableViewCellCustom
        cell.titleLbl.text = title
        cell.descriptionLbl.text = description
        
        if let url = URL(string: current["image"] as! String) {
            
        cell.photoImg.kf.setImage(with: url, placeholder: UIImage(named: "noneImage"), options: nil, completionHandler: {
                            (image, error, cacheType, imageUrl) in
                if let imageData = image?.pngData() {
                    let bytes = imageData.count
                    if  bytes < 0 {
                        cell.photoImg.image = UIImage(named: "noneImage")
                    }
                    }else{
                        cell.photoImg.image = UIImage(named: "noneImage")
                    }
                })
        }
        return cell
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "segueDetail", sender: nil)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return 100
    }
    
}
