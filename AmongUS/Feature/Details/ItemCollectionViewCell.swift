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
    @IBOutlet weak var favButton: UIButton!
    
    var sound: SoundModel!
    var favCompletion: ((SoundModel) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func reset() {
        sound = nil
        itemImage.image = nil
        itemName.text = nil
        favButton.setImage(UIImage(named: "ic_fav"), for: .normal)
    }
    
    @IBAction func favAction(_ sender: UIButton) {
        sound.isFavorite = !sound.isFavorite
        favButton.setImage(UIImage(named: sound.isFavorite ? "ic_faved" : "ic_fav"), for: .normal)
        favCompletion?(sound)
    }
}
