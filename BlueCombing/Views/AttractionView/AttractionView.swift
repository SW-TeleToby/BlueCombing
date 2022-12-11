//
//  AttractionView.swift
//  BlueCombing
//
//  Created by Jun.Mac on 2022/09/17.
//

import SwiftUI

struct AttractionView: View {
    var body: some View {
        CustomTabView()
            .navigationTitle("")
            .navigationBarHidden(true)
    }
}

var tabs = ["이벤트", "관광지", "레저"]

struct CustomTabView: View {
    @Namespace var namespace
    @State var selectedID = UUID()
    @State var selectedTab = "이벤트"
    @State var tourCourses = [
        Course(name: "호미곶 상생의 손", location: "경상북도 포항시 남구 호미곶면 해맞이로 136", background: "img_hand"),
        Course(name: "영일대 해상누각", location: "경상북도 포항시 북구 항구동, 두호동", background: "img_​​pavilion"),
        Course(name: "영일대 이순신 동상", location: "경상북도 포항시 북구 항구동, 두호동", background: "img_sunshin"),
        Course(name: "환호공원 스페이스워크", location: "경상북도 포항시 북구 두호동 산8", background: "img_skyline"),
    ]
    
    var body: some View {
        ZStack {
            Color(.white)
                .ignoresSafeArea(.container, edges: .top)
            
            VStack {
                HStack(spacing: 18) {
                    ForEach(tabs, id: \.self) { category in
                        TabButton(selectedTab: $selectedTab, category: category)
                    }
                    Spacer()
                }
                .padding()
                
                ScrollView {
                    TabView(selection: $selectedTab) {
                        
                        ScrollView {
                            events
                        }
                        .tag("이벤트")
                        
                        ScrollView {
                            cards
                        }
                        .tag("관광지")
                        
                        ScrollView {
                            leisures
                        }
                        .tag("레저")
                        
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .tabViewStyle(.page(indexDisplayMode: .never))
                }
                .coordinateSpace(name: "scroll")
            }
        }
    }
    
    var cards: some View {
        VStack {
            ForEach(tourCourses) { course in
                TourCourseItem(namespace: namespace, course: course)
            }
            Spacer(minLength: UIScreen.main.bounds.height * 0.25)
        }
    }
    
    var events: some View {
        VStack(spacing: 25) {
            Image("chilgokJazz")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(16)
            
            Image("oliveyoungEvent")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(16)
            
            Image("firework")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(16)
            
            Spacer(minLength: UIScreen.main.bounds.height * 0.25)
        }
        .padding(.trailing, 16)
        .padding(.horizontal, 16)
    }
    
    var leisures: some View {
        VStack(spacing: 25) {
            Image("leisure1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(16)
            
            Image("leisure2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(16)
            
            Image("leisure3")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(16)
            
            Image("leisure4")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(16)
            
            Image("leisure5")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(16)
            
            Spacer(minLength: UIScreen.main.bounds.height * 0.25)
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
    }
}

struct TabButton: View {
    
    @Binding var selectedTab: String
    var category: String
    
    var body: some View {
        Button {
            selectedTab = category
        } label: {
            Text(category)
                .font(.custom("Pretendard-Bold", size: 20))
                .foregroundColor(selectedTab == category ? .combingGray6 : .combingGray3)
                .overlay(
                    Rectangle()
                        .frame(height: selectedTab == category ? 3 : 0)
                        .offset(y: 10)
                        .foregroundColor(.combingBlue4)
                    ,
                    alignment: .bottom
                )
        }
    }
}

struct TourView_Previews: PreviewProvider {
    static var previews: some View {
        AttractionView()
    }
}
