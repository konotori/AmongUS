//
//  SettingViewController.swift
//  Among Us Soundboard
//
//  Created by Quan Tran on 27/11/2020.
//

import UIKit
import StoreKit
import MessageUI

enum Setting {
    case about, feedback, policy, terms, rate, more
    
    var display: String {
        switch self {
        case .about:
            return "About app"
        case .feedback:
            return "Feedback"
        case .policy:
            return "Privacy Policy"
        case .terms:
            return "Terms of service"
        case .rate:
            return "Rate app"
        case .more:
            return "More App (Maybe you are interested)"
        }
    }
}

class SettingViewController: UIViewController {

    @IBOutlet weak var settingTable: UITableView!
    
    let cellID = "SettingTableViewCell"
    let settingList: [Setting] = [.about, .feedback, .policy, .terms, .rate, .more]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func setupTable() {
        settingTable.backgroundColor = UIColor(hexString: "DA0000")
        settingTable.delegate = self
        settingTable.dataSource = self
        settingTable.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        
        cell.reset()
        cell.separatorView.isHidden = indexPath.row == 4
        cell.settingLabel.text = settingList[indexPath.row].display
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = WebViewViewController()
        switch settingList[indexPath.row] {
        case .about:
            // TO-DO: Change url
            webVC.url = "https://www.google.com"
            present(webVC, animated: true, completion: nil)
        case .feedback:
            feedbackAction()
        case .policy:
            // TO-DO: Change url
            webVC.url = "https://www.google.com"
            present(webVC, animated: true, completion: nil)
        case .terms:
            // TO-DO: Change url
            webVC.url = "https://www.google.com"
            present(webVC, animated: true, completion: nil)
        case .rate:
            rateAction()
        case .more:
            // TO-DO: Change url
            webVC.url = "https://www.google.com"
            present(webVC, animated: true, completion: nil)
        }
    }
    
    private func rateAction() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
            // TO-DO: Change url app
        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "appId") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    private func feedbackAction() {
        if !MFMailComposeViewController.canSendMail() {
            return
        }
        
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = self
        mailVC.setToRecipients([])
        mailVC.setSubject("Subject for email")
        mailVC.setMessageBody("Email message string", isHTML: false)
        
        present(mailVC, animated: true, completion: nil)
    }
}

extension SettingViewController: MFMailComposeViewControllerDelegate {
    
}
