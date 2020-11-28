//
//  SettingTableViewCell.swift
//  Among Us Soundboard
//
//  Created by Quan Tran on 27/11/2020.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var settingLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func reset() {
        settingLabel.text = nil
        separatorView.isHidden = false
    }
}
