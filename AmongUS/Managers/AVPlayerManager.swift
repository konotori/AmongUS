//
//  AVPlayerManager.swift
//  AmongUS
//
//  Created by Quan Tran on 27/11/2020.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation
import AVFoundation

class AVPlayerManager {
    static let shared = AVPlayerManager()
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(didPlayToEnd), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    private var player: AVPlayer!
    var soundList: [SoundModel] = []
    var currentIndex: Int = -1
    var isPlaying: Bool = false
    
    func initPlayer(sound: SoundModel) {
        if !sound.localUrl.isEmpty {
            var localURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            localURL.appendPathComponent(sound.localUrl)
            player = AVPlayer(url: localURL)
        } else if !sound.fileUrl.isEmpty {
            let item = AVPlayerItem(url: URL(string: baseSoundURL + sound.fileUrl)!)
            item.preferredPeakBitRate = 2
            player = AVPlayer(playerItem: item)
            APIClient.shared.download(sound: sound, completion: nil)
        }
        
        if soundList.contains(sound) {
            currentIndex = soundList.firstIndex(of: sound) ?? -1
        }
    }
    
    func play() {
        guard let player = player else {
            return
        }
        
        player.play()
        isPlaying = true
    }
    
    func pause() {
        guard let player = player else {
            return
        }
        
        player.pause()
        isPlaying = false
    }
    
    func next() {
        if currentIndex != -1 {
            if currentIndex < soundList.count - 1 {
                initPlayer(sound: soundList[currentIndex + 1])
                play()
            } else {
                initPlayer(sound: soundList[0])
                play()
            }
        }
    }
    
    func prev() {
        if currentIndex > 0 {
            initPlayer(sound: soundList[currentIndex - 1])
            play()
        }
    }
    
    @objc private func didPlayToEnd() {
        next()
    }
}
