//
//  MainContainerView.swift
//  AniTime
//
//  Created by Shirou on 2019/06/10.
//  Copyright © 2019 ShirouCo. All rights reserved.
//

import SwiftUI

struct MainContainerView: View {
    @State private var selection = 0
    
    let tabItemTitle: [Int: String] = [0: "편성표", 1: "완결 애니 목록", 2: "북마크", 3: "최신 자막 목록"]
    
    var body: some View {
        NavigationView {
            TabbedView(selection: $selection) {
                OrganizationView(viewModel: .init())
                    .font(.title)
                    .tabItemLabel(Text(tabItemTitle[0] ?? ""))
                    .tag(0)
                Text("완결 애니 목록")
                    .font(.title)
                    .tabItemLabel(Text(tabItemTitle[1] ?? ""))
                    .tag(1)
                Text("북마크")
                    .font(.title)
                    .tabItemLabel(Text(tabItemTitle[2] ?? ""))
                    .tag(2)
                Text("최신 자막 목록")
                    .font(.title)
                    .tabItemLabel(Text(tabItemTitle[3] ?? ""))
                    .tag(3)
            }
            .navigationBarTitle(Text(tabItemTitle[$selection.value] ?? ""))
        }
    }
}

#if DEBUG
struct MainContainerView_Previews: PreviewProvider {
    static var previews: some View {
        MainContainerView()
            .colorScheme(.dark)
    }
}
#endif

