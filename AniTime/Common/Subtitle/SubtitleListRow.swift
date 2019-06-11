//
//  SubtitleListRow.swift
//  AniTime
//
//  Created by Shirou on 2019/06/11.
//  Copyright © 2019 ShirouCo. All rights reserved.
//

import SwiftUI

struct SubtitleListRow : View {
    
    let subtitle: Subtitle
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 4) {
                
                if !subtitle.animeName.isEmpty {
                    Text(subtitle.animeName)
                        .lineLimit(nil)
                        .font(Font.system(.largeTitle, design: .rounded))
                }
                
                if subtitle.episode != nil {
                    Text("\(subtitle.episode?.string ?? "") 화")
                        .font(Font.system(.title, design: .rounded))
                        .bold()
                }
            }
            HStack(spacing: 4) {
                Text("by")
                Text(subtitle.creater)
                    .bold()
                Text("at")
                Text(subtitle.createTime?.string(withFormat: "yyyy/MM/dd HH:mm:ss ") ?? "")
            }
        }
    }
}

#if DEBUG
struct SubtitleListRow_Previews : PreviewProvider {
    static var previews: some View {
        SubtitleListRow(subtitle: Subtitle(sampleID: 1, animeTitle: "Test"))
    }
}
#endif
