//
//  AnimeListView.swift
//  AniTime
//
//  Created by Shirou on 2019/06/11.
//  Copyright © 2019 ShirouCo. All rights reserved.
//

import SwiftUI

struct AnimeListView : View {
    
    var animeList = [Anime]()
    var dayName: String?
    
    var body: some View {
        List(animeList) { anime in
            NavigationButton(destination: AnimeDetailView(viewModel: .init(), anime: anime, dayName: self.dayName)) {
                AnimeListRow(anime: anime)
            }
        }
    }
}

#if DEBUG
struct AnimeListView_Previews : PreviewProvider {
    static var previews: some View {
        AnimeListView()
            .colorScheme(.dark)
    }
}
#endif
