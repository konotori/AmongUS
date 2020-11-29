//
//  RateManager.swift
//  AmongUS
//
//  Created by Quan Tran on 29/11/2020.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation
import StoreKit

class RateManager {
    static let shared = RateManager()
    private init() {}
    
    var didShowFirstTimeRate: Bool = UserDefaults.standard.bool(forKey: "firstRate")
    var playRateTimes: Int = 0
    
    func countRate() {
        playRateTimes += 1
        if playRateTimes == 3 {
            rateAction()
            playRateTimes = 0
        }
    }
    
    func rateAction() {
        let urlStr = "https://apps.apple.com/us/app/id1542486065"
        // "itms-apps://itunes.apple.com/app/" + "1542486065"
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
            // TO-DO: Change url app
        } else if let url = URL(string: urlStr) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
