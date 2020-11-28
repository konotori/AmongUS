//
//  SoundModel.swift
//  AmongUS
//
//  Created by Quan Tran on 27/11/2020.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

class SoundModel: NSObject, Codable {
    let id: String
    let categoryId: String
    let name: String
    let fileUrl: String
    var isFavorite: Bool
    var localUrl: String
    
    init(id: String, categoryId: String, name: String, fileUrl: String, isFavorite: Bool = false, localUrl: String = "") {
        self.id = id
        self.categoryId = categoryId
        self.name = name
        self.fileUrl = fileUrl
        self.isFavorite = isFavorite
        self.localUrl = localUrl
    }
}

struct SoundData: Codable {
    let id: String
    let categoryId: String
    let name: String
    let fileUrl: String
}

struct SoundResponseModel: Codable {
    let status: String
    let code: Int
    let data: [SoundData]
    let myPage: PageModel
}

struct PageModel: Codable {
    let size: Int
    let number: Int
    let totalElements: Int
    let totalPages: Int
}
