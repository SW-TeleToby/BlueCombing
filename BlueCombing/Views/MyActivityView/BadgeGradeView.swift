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
    @State var myBadges : [String] = []
    
    var badgeGradeViewNavbar: some View {
        HStack{
            Image(systemName: "chevron.backward")
                .font(.Body2)
                .onTapGesture {
                    dismiss()
                }
            Spacer()
            Text("비치코밍 등급")
                .font(.Body3)
            Spacer()
            Spacer().frame(width: 20)
        }.padding(.vertical, 15)
    }
    
    var badgesView: some View {
        ScrollView {
            if let user = user {
                ForEach (0..<myBadges.count, id:\.self) { i in
                    if myBadges[i] == user.representBadge {
                        VStack {
                            BadgeInfoView(presentBadge: myBadges[i])
                        }.frame(height: 120)
                            .background(Color.combingBlue2)
                    }
                    else {
                        VStack {
                            BadgeInfoView(presentBadge: myBadges[i])
                        }.frame(height: 120)
                    }
                }
                ForEach (0..<lockBadges, id:\.self) { i in
                    VStack() {
                        HStack{
                            Image("img_badge_lock")
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
            
        }
        .navigationBarHidden(true)
    }
    
    
    var body: some View {
        VStack {
            VStack {
                badgeGradeViewNavbar
                badgesView
                    .onAppear{
                        if let user = user {
                            let presentBadge:BadgeDescription = user.representBadge.translateBadge()
                            myBadges = presentBadge.myBadges
                            lockBadges = 8 - myBadges.count
                        }
                    }
            }.frame(width: containerWidth)
        }
    }
}

struct BadgeInfoView : View {
    @StateObject var badgeVM = BadgeViewModel()
    var presentBadge: String
    
    var body: some View {
        HStack{
            Image(uiImage: badgeVM.badgeImage)
                .resizable()
                .frame(width: 100, height: 100)
            Spacer()
                .frame(width: 20)
            VStack (alignment:.leading){
                Text(presentBadge)
                    .font(.Heading3)
                Spacer()
                    .frame(height: 4)
                Text(badgeVM.description)
                    .font(.Body4)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(3)
                    .foregroundColor(.combingBlue5_2)
            }
            Spacer()
        }.onAppear {
            badgeVM.changeDescription(presentBadge: presentBadge)
        }.padding(.horizontal,20)
    }
}