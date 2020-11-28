//
//  TabBarItem.swift
//
//  Created by Quan Tran on 11/2/20.
//

import Foundation
import UIKit

enum TabBarItem {
    case home, fav, like, setting
    
    var item: UITabBarItem {
        let item = UITabBarItem(title: nil, image: nil, selectedImage: nil)
        
        switch self {
        case .home:
            item.image = UIImage(named: "ic_home")
            item.selectedImage = UIImage(named: "ic_home")
            item.title = "Home"
        case .fav:
            item.image = UIImage(named: "ic_fav")
            item.selectedImage = UIImage(named: "ic_fav")
            item.title = "Favorite"
        case .like:
            item.image = UIImage(named: "ic_like")
            item.selectedImage = UIImage(named: "ic_like")
            item.title = "Share"
        case .setting:
            item.image = UIImage(named: "ic_setting")
            item.selectedImage = UIImage(named: "ic_setting")
            item.title = "Setting"
        }
        
        return item
    }
}
