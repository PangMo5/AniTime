//
//  OrganizationView.swift
//  AniTime
//
//  Created by Shirou on 2019/06/10.
//  Copyright © 2019 ShirouCo. All rights reserved.
//

import SwiftUI

struct ScheduleView: View {
    
    @ObjectBinding var viewModel: ScheduleViewModel
    
    var body: some View {
        VStack {
            SegmentedControl(selection: $viewModel.selection) {
                ForEach(0..<viewModel.segmentItemTitleList.count) { index in
                    Text(self.viewModel.segmentItemTitleList[index])
                }
            }
            
            AnimeListView(animeList: viewModel.animeList, dayName: self.viewModel.segmentItemTitleList[self.viewModel.selection])
        }
        .onAppear {
            self.viewModel.selection = (Date().weekday - 1)
        }
    }
}

#if DEBUG
struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(viewModel: .init())
            .colorScheme(.dark)
    }
}
#endif
