//
//  HomeViewController.swift
//  AmongUS
//
//  Created by Tung Nguyen on 27/11/2020.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import UIKit

enum CategoryType: Int {
    case soundBoard
    case themeSong
    case soundTrack
     
    func title() -> String {
        switch self {
        case .soundBoard:
            return "Sound Board"
        case .themeSong:
            return "Theme Song"
        case .soundTrack:
            return "Sound Track"
        }
    }
    
    func image() -> UIImage {
        switch self {
            case .soundBoard:
                return UIImage(named: "sound_board")!
            case .themeSong:
                return UIImage(named: "theme_song")!
            case .soundTrack:
                return UIImage(named: "sound_track")!
        }
    }
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let rows: [CategoryType] = [.soundBoard, .themeSong, .soundTrack]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTable()
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !RateManager.shared.didShowFirstTimeRate {
            RateManager.shared.rateAction()
            RateManager.shared.didShowFirstTimeRate = true
            UserDefaults.standard.setValue(true, forKey: "firstRate")
        }
    }
    
    func setupTable() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "kHomeTableViewCell")
        tableView.backgroundColor = .clear
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "kHomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.categoryTitle.text = rows[indexPath.row].title()
        cell.categoryImageView.image = rows[indexPath.row].image()
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController.loadFromNib()
        let row = rows[indexPath.row]
        switch row {
        case .soundBoard:
            AVPlayerManager.shared.soundList = SoundManager.shared.soundBoardList
        case .themeSong:
            AVPlayerManager.shared.soundList = SoundManager.shared.themeSongList
        case .soundTrack:
            AVPlayerManager.shared.soundList = SoundManager.shared.soundTrackList
        }
        detailsVC.soundList = AVPlayerManager.shared.soundList
        detailsVC.headImg = row.image()
        detailsVC.isDetailsTab = false
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
