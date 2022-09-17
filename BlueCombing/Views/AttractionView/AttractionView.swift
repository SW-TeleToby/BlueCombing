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
    @State var show = false
    @State var showStatusBar = true
    @State var selectedID = UUID()
    @State var selectedTab = "이벤트"
    @State var tourCourses = [
        Course(name: "호미곶 상생의 손", location: "경상북도 포항시 남구 호미곶면 해맞이로 136", text: "블라블라", background: "img_hand"),
        Course(name: "영일대 해상누각", location: "경상북도 포항시 남구 호미곶면 해맞이로 136", text: "블라블라", background: "img_​​pavilion"),
        Course(name: "영일대 이순신 동상", location: "경상북도 포항시 남구 호미곶면 해맞이로 136", text: "블라블라", background: "img_sunshin"),
        Course(name: "영일대 스카이 라인", location: "경상북도 포항시 남구 호미곶면 해맞이로 136", text: "블라블라", background: "img_skyline"),
    ]


    var body: some View {
        ZStack {
            Color(.white)
                .ignoresSafeArea(.container, edges: .top)

            VStack {
                if !show {
                    HStack(spacing: 18) {
                        ForEach(tabs, id: \.self) { category in
                            TabButton(selectedTab: $selectedTab, category: category)
                        }
                        Spacer()
                    }
                        .padding()
                }

                ScrollView {
                    if !show {
                        TabView(selection: $selectedTab) {

                            Folder()
                                .tag("이벤트")
                            ScrollView {
                                cards
                            }
                                .tag("관광지")

                            Settings()
                                .tag("레저")

                        }
//                            .navigationBarHidden(true)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                            .tabViewStyle(.page(indexDisplayMode: .never))


                    } else {
                        ForEach(tourCourses) { course in
                            Rectangle()
                                .fill(.white)
                                .frame(height: 300)
                                .cornerRadius(30)
                                .shadow(color: Color("Shadow"), radius: 20, x: 0, y: 10)
                                .opacity(0.3)
                                .padding(.horizontal, 30)
                        }
                    }
                }
                    .coordinateSpace(name: "scroll")
            }

            if show {
                detail
            }
        }
            .statusBar(hidden: !showStatusBar)
            .onChange(of: show) { newValue in
            withAnimation(.closeCard) {
                if newValue {
                    showStatusBar = false
                } else {
                    showStatusBar = true
                }
            }
        }
    }

    var cards: some View {
        VStack {
            ForEach(tourCourses) { course in
                TourCourseItem(namespace: namespace, course: course, show: $show)
                    .onTapGesture {
                    withAnimation(.openCard) {
                        show.toggle()
                        showStatusBar = false
                        selectedID = course.id
                    }
                }
            }
        }
    }

    var detail: some View {
        ForEach(tourCourses) { course in
            if course.id == selectedID {
                TourCourseView(namespace: namespace, course: course, show: $show)
                    .zIndex(1)
                    .transition(.asymmetric(
                    insertion: .opacity.animation(.easeInOut(duration: 0.1)),
                    removal: .opacity.animation(.easeInOut(duration: 0.3).delay(0.2))))
            }
        }
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

struct Folder: View {

    var body: some View {

        VStack {

            Text("Folder")
        }
    }
}

struct Settings: View {

    var body: some View {

        VStack {

            Text("Settings")
        }
    }
}

struct TourView_Previews: PreviewProvider {
    static var previews: some View {
        AttractionView()
    }
}
