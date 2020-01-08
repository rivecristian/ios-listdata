//
//  ListViewController.swift
//  ios-listdata
//
//  Created by Cristian Rivera on 1/8/20.
//  Copyright © 2020 Cristian Rivera. All rights reserved.
//

import UIKit

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
            
            //print ("resultado : \(result)")
            
            self.dicData = result
            
            print("dicData: \(self.dicData.description)")
            
//            result.forEach {
//
//                let title = $0["title"] as? String ?? ""
//                let description = $0["description"] as? String ?? ""
//                let image = $0["image"] as? String ?? ""
//
//                print("title: \(title)")
//                print("description: \(description)")
//                print("url image: \(image)")
//
//            }
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
        
         print("title: \(title)")
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
         cell.textLabel!.text = title
         return cell
        
     }
    
}
