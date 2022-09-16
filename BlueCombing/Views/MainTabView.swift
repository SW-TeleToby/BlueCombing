//
//  MainTabView.swift
//  BlueCombing
//
//  Created by Inho Choi on 2022/09/16.
//

import SwiftUI

struct MainTabView: View {
    @State var currentTab: Tab = Tab.beachCombing
    
    var body: some View {
        NavigationView {
            TabView(selection: $currentTab) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    tab.view.tabItem {
                        if currentTab == tab {
                            Image(tab.ImageName + "_on")
                        } else {
                            Image(tab.ImageName + "_off")
                        }
                        Text(tab.title)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
