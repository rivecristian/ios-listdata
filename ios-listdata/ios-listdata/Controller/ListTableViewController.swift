//
//  ListTableViewController.swift
//  ios-listdata
//
//  Created by Cristian Rivera on 1/9/20.
//  Copyright © 2020 Cristian Rivera. All rights reserved.
//

import UIKit
import Toast_Swift


class ListTableViewController: UITableViewController {

    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    // MARK: - Function Custom

    func fetchData () {
        
        ApiService.shared.fetchListItem(success: { result in
            do {
                self.items = try JSONDecoder().decode(Array<Item>.self, from: result)
                print("items: \(self.items)")
                self.tableView.reloadData()
            }
            catch let error as NSError{
                print("Error -> : \(error)")
                self.view.makeToast("Problemas con los datos", duration: 3.0, position: .center)
                
            }
        })
        { (error) in
            print("Error -> : \(error)")
           self.view.makeToast("Conexión Fállida", duration: 3.0, position: .center)
        }
    }
    
    // MARK: - Action
    
    @IBAction func refresh_action(_ sender: Any) {
        fetchData()
        self.refreshControl?.endRefreshing()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let item = items[indexPath.row]
       let cell = Bundle.main.loadNibNamed("TableViewCellCustom", owner: self, options: nil)?.first as! TableViewCellCustom
        if let title = item.title as? String {
            cell.titleLbl.text = title
       }
        if let description = item.description as? String {
            cell.descriptionLbl.text = description
       }
       //Cargar imagen
       cell.photoImg.kf.indicatorType = .activity
       cell.photoImg.image = UIImage(named: "noneImage")
       cell.photoImg.kf.indicatorType = .activity
        
       DispatchQueue.main.async {
            if let url = URL(string: item.image) {
                 cell.photoImg.kf.setImage(with: url) { result in
                    switch result {
                    case .success(let value):
                        print("Image: \(value.image). Got from: \(value.cacheType)")
                    case .failure(let error):
                        print("Error: \(error)")
                        cell.photoImg.image = UIImage(named: "noneImage")
                    }
                }
            }
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
        let itemSelected = items[indexPath.row]
        //Paso el item seleccionado a la vista de detalle
        performSegue(withIdentifier: "segueDetail", sender: itemSelected)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is DetailViewController
        {
            if let itemSelected = sender as? Item {
                let detailVC = segue.destination as! DetailViewController
                detailVC.itemSelected = itemSelected
            }
        }
    }

}
