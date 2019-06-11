//
//  OrganizationListRow.swift
//  AniTime
//
//  Created by Shirou on 2019/06/11.
//  Copyright © 2019 ShirouCo. All rights reserved.
//

import SwiftUI

struct AnimeListRow : View {
    
    let anime: Anime
    
    var body: some View {
        HStack(spacing: 16) {
            NetworkImage(imageURL: anime.thumbnailImage)
                .frame(width: 104, height: 104)
                .cornerRadius(8)
            
            
            VStack(alignment: .leading, spacing: 16) {
                Text(anime.name)
                    .lineLimit(nil)
                    .font(Font.system(.headline))
                
                if !anime.timeStr.isEmpty {
                    Text("\(anime.timeStr) ~")
                        .color(.gray)
                        .font(Font.system(.subheadline))
                }
            }
        }
        .frame(height: 120)
    }
}

#if DEBUG
struct AnimeListRow_Previews : PreviewProvider {
    static var previews: some View {
        AnimeListRow(anime: Anime(sampleID: 1, name: "test"))
            .colorScheme(.dark)
    }
}
#endif

