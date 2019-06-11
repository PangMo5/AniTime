//
//  SubtitleListRequset.swift
//  AniTime
//
//  Created by Shirou on 2019/06/11.
//  Copyright © 2019 ShirouCo. All rights reserved.
//

import Foundation

struct SubtitleListRequest: APIRequestType {
    typealias Response = [Subtitle]
    
    var path: String { return "/timetable/cap" }
}
