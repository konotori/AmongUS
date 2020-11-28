//
//  TabBarViewController.swift
//  UrPlan
//
//  Created by Quan Tran on 11/2/20.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupShareButton()
        setUpTabBar()
        createTabbarControllers()
    }
    
    private func setUpTabBar() {
        tabBar.barTintColor = UIColor(hexString: "151515")
        tabBar.tintColor = .white
        tabBar.isTranslucent = false
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 3
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.1
    }
    
    private func setupShareButton() {
        let shareHeight = tabBar.frame.height
        let shareWidth = view.frame.width / 4
        let shareY = view.frame.minY + view.frame.height - shareHeight - (UIDevice().haveTopNotch ? 34 : 0)
        let button = UIButton(frame: CGRect(x: shareWidth * 2, y: shareY, width: shareWidth, height: shareHeight))
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(shareApp), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc private func shareApp() {
        // TO-DO: Change url app
        if let urlStr = URL(string: "google.com") {
            let objectsToShare = [urlStr]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

            if UIDevice.current.userInterfaceIdiom == .pad {
                if let popup = activityVC.popoverPresentationController {
                    popup.sourceView = self.view
                    popup.sourceRect = CGRect(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 4, width: 0, height: 0)
                }
            }

            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    private func createTabbarControllers() {
        let systemTags: [TabBarItem] = [.home, .fav, .like, .setting]
        let mappedViewControllers = systemTags.compactMap { self.createViewController(for: $0) }
        
        viewControllers = mappedViewControllers
    }
    
    private func createViewController(for item: TabBarItem) -> UIViewController? {
        switch item {
        case .home:
            let homeNav = UINavigationController()
            homeNav.viewControllers = [HomeViewController.instantiateFromStoryboard(storyboardIdentifier: "HomeViewController", storyboardName: "Main", bundle: nil)]
            homeNav.navigationBar.isHidden = true
            homeNav.tabBarItem = item.item
            return homeNav
        case .fav:
            let favNav = UINavigationController()
            favNav.tabBarItem = item.item
            let detailsVC = DetailsViewController.loadFromNib()
            detailsVC.shouldReloadAfterFav = true
            detailsVC.headImg = UIImage(named: "home_header")
            detailsVC.soundList = SoundManager.shared.favoriteList
            favNav.viewControllers = [detailsVC]
            favNav.tabBarItem = item.item
            favNav.navigationBar.isHidden = true
            return favNav
        case .like:
            let bankNavi = UINavigationController()
            bankNavi.tabBarItem = item.item
            return bankNavi
        case .setting:
            let settingNav = UINavigationController()
            settingNav.viewControllers = [SettingViewController.loadFromNib()]
            settingNav.navigationBar.isHidden = true
            settingNav.tabBarItem = item.item
            return settingNav
        }
    }
}

extension UIDevice {
    var haveTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            // with home indicator: 34.0 on iPhone X, XS, XS Max, XR.
            // with home indicator: 20.0 on iPad Pro 12.9" 3rd generation.
            return UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0 > 0
        }
        return false
    }
}
