//
//  HomeTableViewCell.swift
//  AmongUS
//
//  Created by Tung Nguyen on 27/11/2020.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        categoryTitle.textColor = UIColor.white
    }
}
