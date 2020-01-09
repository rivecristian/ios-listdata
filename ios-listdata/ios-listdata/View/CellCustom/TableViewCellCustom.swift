//
//  TableViewCellCustom.swift
//  ios-listdata
//
//  Created by Cristian Rivera on 1/8/20.
//  Copyright © 2020 Cristian Rivera. All rights reserved.
//

import UIKit

class TableViewCellCustom: UITableViewCell {
    
    @IBOutlet weak var photoImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
