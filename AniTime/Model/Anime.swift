//
//  Anime.swift
//  AniTime
//
//  Created by Shirou on 2019/06/10.
//  Copyright © 2019 ShirouCo. All rights reserved.
//

import SwiftUI

struct Anime: Decodable, Hashable, Identifiable {
    let id: Int
    let name: String
    let timeStr: String
    private let _time: String?
    let urlLink: URL?
    private let _urlLink: String?
    let startDate: Date?
    let endDate: Date?
    let episodeCount: Int?
    let previousID: Int?
    let previousEpisodeCount: Int?
    let thumbnailImage: URL?
    let animeNicknameList: [AnimeNickname]
    
    init(from decoder: Decoder) throws {
        let fomatter = DateFormatter()
        fomatter.dateFormat = "yyyyMMdd"
        (decoder as? JSONDecoder)?.dateDecodingStrategy = .formatted(fomatter)
        
        let map = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try map.decode(Int.self, forKey: .id)
        self.name = (try? map.decode(String.self, forKey: .name)) ?? ""
        self._time = try? map.decode(String.self, forKey: .time)
        self._urlLink = try? map.decode(String.self, forKey: .urlLink)
        self.startDate = try? map.decode(Date.self, forKey: .startDate)
        self.endDate = try? map.decode(Date.self, forKey: .endDate)
        self.episodeCount = try? map.decode(Int.self, forKey: .episodeCount)
        self.previousID = try? map.decode(Int.self, forKey: .previousID)
        self.previousEpisodeCount = try? map.decode(Int.self, forKey: .previousEpisodeCount)
        self.thumbnailImage = try? map.decode(URL.self, forKey: .thumbnailImage)
        self.animeNicknameList = (try? map.decode([AnimeNickname].self, forKey: .animeNicknameList)) ?? []
        
        
        // MARK: Data Binding
        if let time = self._time,
            !time.isEmpty {
            self.timeStr = "\(time.dropLast(2)):\(time.dropFirst(2))"
        } else {
            self.timeStr = ""
        }
        
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
    
    init(sampleID: Int, name: String) {
        self.id = sampleID
        self.name = name
        self.timeStr = "00:00"
        self.urlLink = URL(string: "https://en.wikipedia.org/wiki/Anime")
        self.startDate = Date()?.yesterday
        self.endDate = Date()
        self.episodeCount = 24
        self.previousID = 1
        self.previousEpisodeCount = 12
        self.thumbnailImage = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bb/Anime_eye.svg/340px-Anime_eye.svg.png")
        self.animeNicknameList = []
        
        self._time = nil
        self._urlLink = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "i"
        case name = "s"
        case time = "t"
        case urlLink = "l"
        case startDate = "sd"
        case endDate = "ed"
        case episodeCount = "e"
        case previousID = "b"
        case previousEpisodeCount = "a"
        case thumbnailImage = "img"
        case animeNicknameList = "n"
    }
}


struct AnimeNickname: Decodable, Hashable, Identifiable {
    let id: Int
    let nickname: String
    
    enum CodingKeys: String, CodingKey {
        case id = "i"
        case nickname = "s"
    }
}
