//
//  ListTableViewController.swift
//  ios-listdata
//
//  Created by Cristian Rivera on 1/9/20.
//  Copyright © 2020 Cristian Rivera. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    var dicData:[[String:Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
    }
    
    // MARK: - Function Custom
    
    func fetchData () {
           ApiService.shared.fetchListItem() { (result) in
               self.dicData = result
               print("dicData: \(self.dicData.description)")
                self.tableView.reloadData()
           }
       }
    
    // MARK: - Action
    
    @IBAction func refresh_action(_ sender: Any) {
        fetchData()
        self.refreshControl?.endRefreshing()
    }
    
  
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dicData.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
       
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueDetail", sender: nil)
    }

}
