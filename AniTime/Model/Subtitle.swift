//
//  Subtitle.swift
//  AniTime
//
//  Created by Shirou on 2019/06/11.
//  Copyright © 2019 ShirouCo. All rights reserved.
//

import SwiftUI

struct Subtitle: Decodable, Hashable, Identifiable {
    
    let id: Int
    let creater: String
    let createTime: Date?
    let animeName: String
    let episode: Int?
    let urlLink: URL?
    private let _urlLink: String?
    
    init(from decoder: Decoder) throws {
        let fomatter = DateFormatter()
        fomatter.dateFormat = "yyyyMMddHHmmss"
        (decoder as? JSONDecoder)?.dateDecodingStrategy = .formatted(fomatter)
        
        let map = try decoder.container(keyedBy: CodingKeys.self)
        self.creater = try map.decode(String.self, forKey: .creater)
        self.animeName = (try? map.decode(String.self, forKey: .animeName)) ?? ""
        self.createTime = try? map.decode(Date.self, forKey: .createTime)
        self.episode = (try? map.decode(Int.self, forKey: .episode)) ?? 0
        self._urlLink = try? map.decode(String.self, forKey: .urlLink)
        
        //temp
        self.id = createTime?.timeIntervalSince1970.int ?? 0
        
        // MARK: Data Binding
        if let urlLink = _urlLink?.lowercased(),
            !urlLink.isEmpty {
            if urlLink.contains("http://") || urlLink.contains("https://") {
                self.urlLink = URL(string: urlLink)
            } else if let url = URL(string: "https://" + urlLink) {
                self.urlLink = url
            } else {
                self.urlLink = nil
            }
        } else {
            self.urlLink = nil
        }
    }
    
    init(sampleID: Int, animeTitle: String) {
        self.id = sampleID
        self.creater = "Tester"
        self.createTime = Date()
        self.animeName = animeTitle
        self.episode = 12
        self.urlLink = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bb/Anime_eye.svg/340px-Anime_eye.svg.png")
        
        self._urlLink = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case creater = "n"
        case createTime = "d"
        case animeName = "t"
        case episode = "s"
        case urlLink = "a"
    }
}
