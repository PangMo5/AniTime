//
//  OrganizationListRow.swift
//  AniTime
//
//  Created by Shirou on 2019/06/11.
//  Copyright © 2019 ShirouCo. All rights reserved.
//

import SwiftUI

struct OrganizationListRow : View {
    
    let anime: Anime
    
    var body: some View {
        HStack(spacing: 16) {
            NetworkImage(imageURL: anime.thumbnailImage, placeholderImage: (UIImage(systemName: "star")?.filled(withColor: .gray))!)
                .frame(width: 104, height: 104)
                .cornerRadius(8)
            
            
            VStack(alignment: .leading, spacing: 16) {
                Text(anime.name)
                    .lineLimit(nil)
                    .font(Font.system(size: 20))
                
                Text("\(anime.timeStr) ~")
                    .color(.gray)
                    .font(Font.system(size: 16))
            }
        }
        .frame(height: 120)
    }
}
