//
//  APIClient.swift
//  AmongUS
//
//  Created by Quan Tran on 27/11/2020.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation
import Alamofire

let baseURL = "http://topxmedia.club/sound-among/"
let baseSoundURL = "topxmedia.club/file-sound-among/"

class APIClient {
    static let shared = APIClient()
    private init() {}
    
    let headers = ["Upgrade": "h2,h2c", "Content-Type": "application/x-www-form-urlencoded"]
    
    private func getRequest<T: Codable>(endpoint: String, completion: @escaping (T) -> Void, errorHandler: (() -> Void)?) {
        Alamofire.request(baseURL + endpoint).responseJSON(completionHandler: { response in
            guard response.result.isSuccess else {
                errorHandler?()
                return
            }

            let decoder = JSONDecoder()
            guard let data = response.data, let decodedResponse = try? decoder.decode(T.self, from: data) else {
                errorHandler?()
                return
            }
            
            completion(decodedResponse)
        })
    }
    
    func download(sound: SoundModel, completion: ((String) -> ())?) {
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            documentsURL.appendPathComponent("\(sound.name).mp3")
            print("documents: --------\n\(documentsURL)")
            return (documentsURL, [.removePreviousFile])
        }
        
        Alamofire.download(baseSoundURL + sound.fileUrl, encoding: JSONEncoding.default, headers: headers, to: destination).responseData(completionHandler: { response in
            if response.result.isSuccess {
                if let urlDes = response.destinationURL, !urlDes.absoluteString.isEmpty {
                    let url = urlDes.absoluteString
                    let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    let newUrl = url.replacingOccurrences(of: docDir.absoluteString, with: "")
                    completion?(newUrl)
                }
            }
        })
    }
    
    func getAllSound(completion: @escaping (SoundResponseModel) -> (), errorHandler: (() -> ())?) {
        let endpoint = "sound/search?filter=id==%22**%22&pageIndex=0&pageSize=80&sort=id"
        getRequest(endpoint: endpoint, completion: completion, errorHandler: errorHandler)
    }
    
    func getAllCategories(id: String, completion: @escaping (SoundResponseModel) -> (), errorHandler: (() -> ())?) {
        let endpoint = "sound/search?filter=categoryId==\"*\(id)*\"&pageIndex=0&pageSize=80&sort=id"
        getRequest(endpoint: endpoint, completion: completion, errorHandler: errorHandler)
    }
    
    func getAllSoundBy(id: String, completion: @escaping (SoundResponseModel) -> (), errorHandler: (() -> ())?) {
        let endpoint = "sound/search?filter=categoryId==\"*\(id)*\"&pageIndex=0&pageSize=80&sort=id"
        getRequest(endpoint: endpoint, completion: completion, errorHandler: errorHandler)
    }
}
