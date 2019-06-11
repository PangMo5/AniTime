//
//  AnimeDetailView.swift
//  AniTime
//
//  Created by Shirou on 2019/06/11.
//  Copyright © 2019 ShirouCo. All rights reserved.
//

import SwiftUI

struct AnimeDetailView : View {
    
    @ObjectBinding var viewModel: AnimeDetailViewModel
    
    let anime: Anime
    let dayName: String?
    
    var body: some View {
        List {
            AnimeHeaderView(anime: anime, dayName: dayName)
            ForEach(self.viewModel.subtitleList) { subtitle in
                NavigationButton(destination: WebView(request: URLRequest(url: subtitle.urlLink!))) {
                    SubtitleListRow(subtitle: subtitle)
                }
            }
        }
        .padding([.top, .bottom, .leading, .trailing], 0)
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            self.viewModel.id = self.anime.id
        }
    }
}

#if DEBUG
struct AnimeDetailView_Previews : PreviewProvider {
    static var previews: some View {
        AnimeDetailView(viewModel: .init(), anime: Anime(sampleID: 1, name: "Test"), dayName: "수")
            .colorScheme(.dark)
    }
}
#endif

struct AnimeHeaderView : View {

    let anime: Anime
    let dayName: String?
    
    var body: some View {
        
        let timeText = (anime.startDate?.string(withFormat: "yyyy/MM/dd") ?? "") + " ~ " + (anime.endDate?.string(withFormat: "yyyy/MM/dd") ?? "")
        let thumbnailImage: NetworkImage = NetworkImage(imageURL: anime.thumbnailImage, contentMode: .fill)
        
        return ZStack(alignment: .bottomLeading) {
        
            thumbnailImage
                .padding([.top, .leading, .trailing], 0)
                .frame(height: 240)
                .blur(radius: 16)
                .clipped(antialiased: true)
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text(anime.name)
                        .font(Font.system(.largeTitle, design: .rounded))
                        .bold()
                        .lineLimit(nil)
                        .shadow(color: .black, radius: 8)
                    
                    Text("\(dayName == nil ? "" : "\(dayName!) ~")\(anime.timeStr)")
                        .font(Font.system(.headline, design: .rounded))
                        .shadow(color: .black, radius: 8)
                    
                    if timeText != " ~ " {
                        Text(timeText)
                            .font(Font.system(.subheadline, design: .rounded))
                            .shadow(color: .black, radius: 8)
                    }
                }
                Spacer()
                thumbnailImage
                    .cornerRadius(8)
                    .overlay((
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 2)
                    ))
                    .frame(width: 100, height: 100)
            }
            .padding(.bottom, 8)
            .padding([.leading, .trailing], 16)
        }
        .listRowInsets(EdgeInsets())
    }
}
