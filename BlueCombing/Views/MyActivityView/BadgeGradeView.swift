//
//  BadgeGradeView.swift
//  BlueCombing
//
//  Created by ryu hyunsun on 2022/09/17.
//

import SwiftUI

struct BadgeGradeView: View {
    @Environment(\.dismiss) var dismiss
    var user: User?
    @State var lockBadges = 8
    var body: some View {

        VStack {
            BadgeGradeViewNavbar()
            ScrollView {
                if let user = user {
                    ForEach (0..<user.myBadges.count, id:\.self) { i in
                        if user.myBadges[i] == user.representBadge {
                            VStack() {
                                BadgeInfoView(tempBadge: user.myBadges[i])
                                    .frame(width: deviceWidth)
                            }.frame(width: deviceWidth,height: 120)
                                .background(Color.combingBlue2)
                                
                        }
                        else {
                            VStack() {
                                BadgeInfoView(tempBadge: user.myBadges[i])
                                    .frame(width: deviceWidth)
                            }.frame(width: deviceWidth,height: 120)
                                
                        }
                        
                    }
                    ForEach (0..<lockBadges, id:\.self) { i in
                        VStack() {
                            HStack{
                                Image("img_badge_turtle")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                Spacer()
                                    .frame(width: 20)
                                VStack (alignment:.leading){
                                    Text("아직 등급을 확인할 수 없어요")
                                        .font(.Body4)
                                        .foregroundColor(.combingBlue5_2)
                                }
                                Spacer()
                            }.padding(.horizontal,20)
                        }.frame(width: deviceWidth)
                    }
                }
                
            }.navigationBarHidden(true)
                .onAppear{
                    if let user = user {
                        lockBadges = 8 - user.myBadges.count
                    }
                    
                }
               
        }
        
    }
    
    
}

struct BadgeInfoView : View {
    var tempBadge: String
    @State var description: String = "산호초"
    @State var BadgeTitle: String = "img_badge_coral"
    
    var body: some View {
        HStack{
        
            Image(BadgeTitle)
                .resizable()
                .frame(width: 100, height: 100)
            Spacer()
                .frame(width: 20)
            VStack (alignment:.leading){
                Text(tempBadge)
                    .font(.Heading3)
                Spacer()
                    .frame(height: 4)
                Text(description)
                    .font(.Body4)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(3)
                    .foregroundColor(.combingBlue5_2)
            }
            Spacer()
        }.onAppear {
            switch tempBadge {
            case "산호초":
                description = "당신은 산호초처럼\n파릇파릇한 바다지킴이네요"
                BadgeTitle = "img_badge_coral"
            case "조개":
                description = "오늘도 바다를 꾸준히 지킨\n당신은 바다의 조개같은 존재예요!"
                BadgeTitle = "img_badge_clam"
            case "해마":
                description = "이젠 바다를 지키는게\n익숙한 당신은 바다의 해마에요"
                BadgeTitle = "img_badge_hippocampus"
            case "해파리":
                description = "바다 주변을 끊임없이 둘러보는\n당신은 바다의 해파리 같아요"
                BadgeTitle = "img_badge_jellyfish"
            case "돌고래":
                description = "멋진 돌고래 같은 당신!\n덕분에 오늘도 바다가 깨끗해요"
                BadgeTitle = "img_badge_dolphin"
            case "거북이":
                description = "오늘도 장로 거북이처럼\n노련하게 바다를 지키고 계시는군요!"
                BadgeTitle = "img_badge_turtle"
            case "물고기 떼":
                description = "작은 노력을 모아 바다를 돌보는\n당신은 거대한 물고기 떼 같아요"
                BadgeTitle = "img_badge_fishs"
            case "고래":
                description = "항상 변함없이 바다를 지키는\n당신은 바다의 주인인 고래 같아요"
                BadgeTitle = "img_badge_clam"
            default:
                description = ""
                BadgeTitle = "img_badge_clam"
            }
        }.padding(.horizontal,20)
        
    }
    
}

//struct BadgeGradeView_Previews: PreviewProvider {
//    static var previews: some View {
//        BadgeGradeView()
//    }
//}
