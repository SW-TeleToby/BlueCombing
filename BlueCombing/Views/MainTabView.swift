//
//  MainTabView.swift
//  BlueCombing
//
//  Created by Inho Choi on 2022/09/16.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        NavigationView {
            TabView {
                ForEach(Tab.allCases, id: \.self) { tab in
                    tab.view.tabItem {
                        Image(systemName: tab.systemImageName)
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
