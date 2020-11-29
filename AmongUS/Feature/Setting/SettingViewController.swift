//
//  SettingViewController.swift
//  Among Us Soundboard
//
//  Created by Quan Tran on 27/11/2020.
//

import UIKit
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
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        
        cell.reset()
        cell.separatorView.isHidden = indexPath.row == 5
        cell.settingLabel.text = settingList[indexPath.row].display
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = WebViewViewController()
        switch settingList[indexPath.row] {
        case .about:
            let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            let alert = UIAlertController(title: "About app", message: "Version: \(version ?? "1.0")", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        case .feedback:
            feedbackAction()
        case .policy:
            // TO-DO: Change url
            webVC.url = "https://hthmobile.github.io/among_us_soundboard/policy.html"
            present(webVC, animated: true, completion: nil)
        case .terms:
            // TO-DO: Change url
            webVC.url = "https://hthmobile.github.io/among_us_soundboard/terms_of_use.html"
            present(webVC, animated: true, completion: nil)
        case .rate:
            RateManager.shared.rateAction()
        case .more:
            // TO-DO: Change url
            webVC.url = "https://apps.apple.com/us/developer/thao-nguyen/id930075717"
            present(webVC, animated: true, completion: nil)
        }
    }
    
    private func feedbackAction() {
        if !MFMailComposeViewController.canSendMail() {
            return
        }
        
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as AnyObject
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as AnyObject
        let mailVC = MFMailComposeViewController()
        
        let appName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
        let title = "Feedback\(" \(appName ?? "")")"
        var messeageBody = String()
        messeageBody.append("\n\n\n--------------------\n")
        messeageBody.append("System version: \(UIDevice.current.systemVersion)\n")
        messeageBody.append("Model name: \(UIDevice.current.model)\n")
        messeageBody.append("App version: \(version).\(build)\n")
        
        mailVC.setToRecipients(["hthmobilesoft@gmail.com"])
        mailVC.setSubject(title)
        mailVC.setMessageBody(messeageBody, isHTML: false)
        
        present(mailVC, animated: true, completion: nil)
    }
}
