//
//  ExUIViewController.swift
//  UrPlan
//
//  Created by Quan Tran on 8/5/20.
//  Copyright © 2020 Caro. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    static func instantiateFromStoryboard<T: UIViewController>(storyboardIdentifier: String, storyboardName: String, bundle: Bundle?) -> T   {
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        let viewController = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! T
        return viewController
    }
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
    
    /// Hide keyboard if user taps outside
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
