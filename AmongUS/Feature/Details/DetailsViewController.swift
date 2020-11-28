//
//  DetailsViewController.swift
//  Among Us Soundboard
//
//  Created by Quan Tran on 27/11/2020.
//

import UIKit
import FSPagerView

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var pageView: FSPagerView!
    @IBOutlet weak var pageControl: FSPageControl!
    @IBOutlet weak var backButton: DesignableButton!
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var favButton: DesignableButton!
    
    let cellID = "PageCollectionViewCell"
    var soundList: [SoundModel] = []
    var isDetailsTab: Bool = true
    var shouldReloadAfterFav: Bool = false
    var headImg: UIImage?
    
    private var selectedSound: SoundModel? {
        didSet {
            setupFavButton()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupPageView()
        setupPageControl()
        setupSubviews()
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupFavButton()
        
        if isDetailsTab {
            soundList = SoundManager.shared.favoriteList
            pageView.reloadData()
        }
    }
    
    private func setupPageView() {
        pageView.dataSource = self
        pageView.delegate = self
        pageView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = soundList.count / 9 + (soundList.count % 9 != 0 ? 1 : 0)
    }
    
    private func setupSubviews() {
        backButton.isHidden = isDetailsTab
        headImage.image = headImg
    }
    
    private func setupFavButton() {
        let selectedColor = UIColor(hexString: "570000")
        guard let sound = selectedSound else {
            favButton.setTitleColor(.white, for: .normal)
            favButton.backgroundColor = selectedColor
            return
        }
        
        favButton.setTitleColor(sound.isFavorite ? .white : selectedColor, for: .normal)
        favButton.backgroundColor = sound.isFavorite ? selectedColor : UIColor.white
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func favAction(_ sender: UIButton) {
        guard let sound = selectedSound else {
            return
        }
        
        sound.isFavorite = !sound.isFavorite
        setupFavButton()
        SoundManager.shared.save()
        
        if shouldReloadAfterFav {
            soundList = SoundManager.shared.favoriteList
            pageView.reloadData()
            selectedSound = nil
        }
    }
    
    @IBAction func shuffleAction(_ sender: UIButton) {
    }
    
    @IBAction func playBack(_ sender: UIButton) {
        AVPlayerManager.shared.prev()
    }
    
    @IBAction func playerPause(_ sender: UIButton) {
        AVPlayerManager.shared.pause()
    }
    
    @IBAction func playerNext(_ sender: UIButton) {
        AVPlayerManager.shared.next()
    }
}

extension DetailsViewController: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return soundList.count / 9 + (soundList.count % 9 != 0 ? 1 : 0)
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        guard let cell = pagerView.dequeueReusableCell(withReuseIdentifier: cellID, at: index) as? PageCollectionViewCell else {
            return FSPagerViewCell()
        }
        
        let startIndex = index * 9
        let endIndex = ((index + 1) * 9 - 1) >= (soundList.count - 1) ? soundList.count - 1 : (index + 1) * 9 - 1
        cell.sounds = Array(soundList[startIndex...endIndex])
        cell.itemCollection.reloadData()
        cell.didSelectSoundCallback = { [weak self] sound in
            self?.selectedSound = sound
        }
        
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        pageControl.currentPage = pagerView.currentIndex
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return true
    }
}
