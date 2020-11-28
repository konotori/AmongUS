//
//  ItemCollectionViewCell.swift
//  AmongUS
//
//  Created by Quan Tran on 28/11/2020.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func reset() {
        itemImage.image = nil
        itemName.text = nil
    }
}
