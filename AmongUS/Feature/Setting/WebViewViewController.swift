//
//  WebViewViewController.swift
//  AmongUS
//
//  Created by Quan Tran on 28/11/2020.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var url: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: url)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension WebViewViewController: WKUIDelegate {
}
