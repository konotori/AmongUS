//
//  SoundManager.swift
//  AmongUS
//
//  Created by Quan Tran on 27/11/2020.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

class SoundManager {
    static let shared = SoundManager()
    private init() {}
    
    var allSoundList: [SoundModel] = []
    var soundBoardList: [SoundModel] = []
    var soundTrackList: [SoundModel] = []
    var themeSongList: [SoundModel] = []
    var favoriteList: [SoundModel] {
        return allSoundList.filter({ $0.isFavorite })
    }
    
    private let soundBoardID = "c4e98931-c2ef-4037-b123-7a9356f1b043"
    private let soundTrackID = "14ea09e9-34d1-412a-93ed-448e0207f7e5"
    private let themeSongID = "f97eb36b-4615-4688-bad5-059f2f92b122"
    
    func filter(sounds: [SoundModel]) {
        allSoundList = sounds
        soundBoardList = sounds.filter({ $0.categoryId == soundBoardID })
        soundTrackList = sounds.filter({ $0.categoryId == soundTrackID })
        themeSongList = sounds.filter({ $0.categoryId == themeSongID })
        
        save()
    }
    
    func save() {
        DispatchQueue.global(qos: .background).async {
            guard let encodedData = try? JSONEncoder().encode(self.allSoundList) else {
                return
            }
            
            UserDefaults.standard.setValue(encodedData, forKey: "savedList")
        }
    }
}
