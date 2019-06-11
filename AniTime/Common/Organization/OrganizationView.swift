//
//  OrganizationView.swift
//  AniTime
//
//  Created by Shirou on 2019/06/10.
//  Copyright © 2019 ShirouCo. All rights reserved.
//

import SwiftUI

struct OrganizationView: View {
    @ObjectBinding var viewModel: OrganizationViewModel
    
    let segmentItemTitleList: [String] = ["일", "월", "화", "수", "목", "금", "토", "기타"]
    
    var body: some View {
        VStack {
            SegmentedControl(selection: $viewModel.selection) {
                ForEach(0..<segmentItemTitleList.count) { index in
                    Text(self.segmentItemTitleList[index])
                }
            }
            
            List(self.viewModel.animeList) { anime in
                NavigationButton(destination: OrganizationView(viewModel: .init())) {
                    OrganizationListRow(anime: anime)
                }
            }
        }
        .onAppear {
            self.viewModel.selection = (Date().weekday - 1)
        }
    }
}

#if DEBUG
struct OrganizationView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationView(viewModel: .init())
            .colorScheme(.dark)
    }
}
#endif
