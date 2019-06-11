//
//  AnimeListRequest.swift
//  AniTime
//
//  Created by Shirou on 2019/06/10.
//  Copyright © 2019 ShirouCo. All rights reserved.
//

import Foundation

struct AnimeListRequest: APIRequestType {
    typealias Response = [Anime]
    
    var path: String { return "/anitime/list" }
}
