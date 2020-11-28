//
//  PageCollectionViewCell.swift
//  AmongUS
//
//  Created by Quan Tran on 28/11/2020.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import UIKit
import FSPagerView

class PageCollectionViewCell: FSPagerViewCell {

    @IBOutlet weak var itemCollection: UICollectionView!
    
    var sounds: [SoundModel] = []
    var didSelectSoundCallback: ((SoundModel) -> ())?
    let cellID = "ItemCollectionViewCell"
    var didFavCompletion: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCollection()
    }

    private func setupCollection() {
        itemCollection.delegate = self
        itemCollection.dataSource = self
        itemCollection.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
    }
}

extension PageCollectionViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sounds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? ItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let sound = sounds[indexPath.row]
        cell.reset()
        cell.sound = sound
        cell.itemName.text = sound.name
        cell.itemImage.image = setupItemImage(name: sound.name)
        cell.favButton.setImage(UIImage(named: sound.isFavorite ? "ic_faved" : "ic_fav"), for: .normal)
        cell.favCompletion = { [weak self] favSound in
            if sound == favSound {
                self?.didFavCompletion?()
            }
        }
        
        return cell
    }
    
    private func setupItemImage(name: String) -> UIImage? {
        if name.lowercased().contains(" kill ") {
            return UIImage(named: "kill")
        } else if name.lowercased().contains(" vent ") {
            return UIImage(named: "vent")
        } else if name.lowercased().contains("reporting") {
            return UIImage(named: "report")
        } else if name.lowercased().contains("sabotage") {
            return UIImage(named: "sabotage")
        } else {
            return UIImage(named: "button")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (itemCollection.bounds.width - 40) / 3
        return CGSize(width: width, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        AVPlayerManager.shared.initPlayer(sound: sounds[indexPath.row])
        AVPlayerManager.shared.play()
        didSelectSoundCallback?(sounds[indexPath.row])
    }
}
