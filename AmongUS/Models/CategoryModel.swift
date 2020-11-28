//
//  CategoryModel.swift
//  AmongUS
//
//  Created by Quan Tran on 27/11/2020.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

struct CategoryModel: Codable {
    let id: String
    let name: String
}

struct CategoryResponseModel: Codable {
    let status: String
    let code: Int
    let data: [CategoryModel]
    let myPage: PageModel
}
