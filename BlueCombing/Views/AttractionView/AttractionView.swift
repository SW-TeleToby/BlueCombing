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
        Course(name: "호미곶 상생의 손", location: "경상북도 포항시 남구 호미곶면 해맞이로 136", text: "상생의 손은 포항시 호미곶에 있는 해맞이 광장에 위치한 기념물로 인류가 화합하고 화해하며 더불어 사는 사회를 만들어가자는 의미로 만들어진 조각물이다. 바다에는 오른손이, 육지에는 왼손이 있다. \n1999년에 조각가 영남대학교 김승국 교수를 제작되었으며, 이어령 대한민국 새천년준비위원회 위원장, 대구은행 협찬 당시에 붙인 이름이다.\n하지만 상생의 손 조각의 원본이라 할 수 있는 작품은 서울예술대학(구 서울예술전문대) 사진과 1997년 졸업 작품집에 먼저 등장했다.", background: "img_hand"),
        Course(name: "영일대 해상누각", location: "경상북도 포항시 북구 항구동, 두호동", text: "영일대해수욕장(Yeongildae Beach, 迎日臺海水浴場)은 경상북도 포항시 북구 항구동, 두호동에 위치한 백사장 길이 1,750m, 너비 40~70m, 면적 38만m2에 달하는 해수욕장이다. POSCO와 영일만이 보이며, 백사장의 모래가 고와 가족단위 피서지로 적합하다. 샤워장, 탈의장, 무료 주차장 등의 편의시설이 갖추어져 있다. 주요 시설물로는 영일대 해상누각, 고사분수, 바다시청 등이 있다.\n매년 포항국제불빛축제와 포항바다국제공연예술제를 개최하며, 이 외에도 수많은 행사가 열려 여름 개장기간 중 수많은 인파가 몰린다.\n영일대 해수욕장은 7월과 8월 사이에 개장한다.\n해안 수영경계선 외측 10m 지점까지를 수상레저활동 금지구역으로 지정하고 있다.", background: "img_​​pavilion"),
        Course(name: "영일대 이순신 동상", location: "경상북도 포항시 북구 항구동, 두호동", text: "영일대 앞 광장 ‘이순신 장군 동상’은 조형물과 시각적 언어로 국내외 주요 현안에 대한 공익적 메시지를 던지고 있는 ‘바른 역사의식이 나라를 지킨다'는 주제로 이제석 광고연구소가 제작해 포항시에 기증한 동상으로 기존 이순신 장군 동상을 패러디해 손에 칼 대신 붓과 역사책을 쥐고 있다.\n또한 국토 수호에는 바른 역사교육과 역사의식보다 중요한 것이 없음을 상징적으로 표현하고, 울릉도와 독도로 가는 길목이며 호미곶을 비롯해 멀리 독도가 바라보이는 포항 영일대 앞에 이순신 장군이 서 있다는 데 큰 의미를 두고 있는 것으로 알려졌다.", background: "img_sunshin"),
        Course(name: "환호공원 스페이스워크", location: "경상북도 포항시 북구 두호동 산8", text: "포스코가 2021년 제작한 포항시 환호공원에 위치한 체험형 구조물이다.\n모양은 롤러코스터를 연상하는 디자인이지만, 레일 대신 계단이 있어 직접 올라갈 수 있다는 점이 특징이다. 사진의 360도로 도는 계단은 안전상의 이유로 직접 올라갈 수 없다.", background: "img_skyline"),
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
            Spacer(minLength: UIScreen.main.bounds.height * 0.25)
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
