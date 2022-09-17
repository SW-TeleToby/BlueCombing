//
//  MainTabView.swift
//  BlueCombing
//
//  Created by Inho Choi on 2022/09/16.
//

import SwiftUI

struct MainTabView: View {
    @State var currentTab: Tab = Tab.beachCombing
    @AppStorage("isFirstStart") var isFirstStart: Bool = true
    @State var showingOnboarding: Bool = true

    var body: some View {
        if isFirstStart {
            OnboardingView(isFirstStart: $isFirstStart)
        } else {
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
                .onAppear {
                    UITabBar.appearance().backgroundColor = UIColor.white
                }

            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
