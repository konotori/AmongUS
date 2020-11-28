//
//  AppDelegate.swift
//  AmongUS
//
//  Created by Tung Nguyen on 27/11/2020.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.rootViewController = TabBarViewController()
        getSounds()
        
        return true
    }
    
    private func getSounds() {
        guard let data = UserDefaults.standard.value(forKey: "savedList") as? Data, let savedList = try? JSONDecoder().decode([SoundModel].self, from: data) else {
            APIClient.shared.getAllSound(completion: { response in
                let converted = response.data.compactMap({ return SoundModel(id: $0.id, categoryId: $0.categoryId, name: $0.name, fileUrl: $0.fileUrl) })
                SoundManager.shared.filter(sounds: converted)
            }, errorHandler: nil)
            return
        }
        
        SoundManager.shared.filter(sounds: savedList)
    }
}

