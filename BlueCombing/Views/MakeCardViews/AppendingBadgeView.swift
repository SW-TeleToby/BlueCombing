//
//  AppendingBadgeView.swift
//  BlueCombing
//
//  Created by ryu hyunsun on 2022/09/16.
//

import SwiftUI

struct AppendingBadgeView: View {
    @Binding var page: Int
    @StateObject var cardViewModel = CardViewModel()
    @State var isPresentShareView = false
    var body: some View {
        
        VStack(spacing:0){
            MakeCardViewNavbar(page: $page).padding(.vertical,20)
            ZStack{
                CardView(card: $cardViewModel.newCard)
                    .frame(width: containerWidth, height: imageHeight)
                VStack {
                    HStack {
                        ForEach(0..<cardViewModel.checkBadges.count, id: \.self) { i in
                            Image("testBadge\(cardViewModel.checkBadges[i])")
                                .resizable()
                                .frame(width: 56, height: 56)
                        }
                        ForEach(0..<5-cardViewModel.checkBadges.count, id:\.self) {i in
                            Image("testBadgeframe")
                                .frame(width: 56, height: 56)
                        }
                        Spacer()
                    }.padding(.leading,12)
                        .padding(.top, 12)
                    Spacer()
                    
                }
            }.frame(width: containerWidth, height: imageHeight)
            
            Spacer()
            // 여기 뱃지 리스트 들어가야함.
            ScrollView(.horizontal) {
                HStack (spacing:0){
                    
                    // 체크박스 올리는 로직인데, 비효율적인듯. 잘 돌아가긴 함.
                    ForEach(0..<cardViewModel.myBadges.count, id: \.self) { i in
                        if cardViewModel.checkBadges.contains(cardViewModel.myBadges[i]){
                            ZStack {
                                Image("testBadge\(cardViewModel.myBadges[i])")
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(Color(red: 0.046, green: 0.128, blue: 0.446,opacity: 0.5))
                                    .frame(width: 96, height: 96)
                                Image("testCheckmark")
                            }
                            .onTapGesture {
                                if cardViewModel.checkBadges.count < 5 {
                                    if cardViewModel.checkBadges.contains(cardViewModel.myBadges[i]) {
                                        if let index = cardViewModel.checkBadges.firstIndex(of: cardViewModel.myBadges[i]) {
                                            cardViewModel.checkBadges.remove(at: index)
                                        }
                                    }
                                    else {
                                        cardViewModel.checkBadges.append( cardViewModel.myBadges[i])
                                        print(cardViewModel.checkBadges)
                                    }
                                }
                            }
                        }
                        else {
                            Image("testBadge\(cardViewModel.myBadges[i])")
                                .onTapGesture {
                                    if cardViewModel.checkBadges.count < 5 {
                                        if cardViewModel.checkBadges.contains(cardViewModel.myBadges[i]) {
                                            if let index = cardViewModel.checkBadges.firstIndex(of: cardViewModel.myBadges[i]) {
                                                cardViewModel.checkBadges.remove(at: index)
                                            }
                                            print(cardViewModel.checkBadges)
                                        }
                                        else {
                                            cardViewModel.checkBadges.append( cardViewModel.myBadges[i])
                                            print(cardViewModel.checkBadges)
                                        }
                                    }
                                }
                        }
                        
                    }
                }.padding()
            }
            Spacer()
            Button(action: {
                // 비치코밍 인증하기 뷰로 넘어가기.
                
                isPresentShareView.toggle()
                for i in 0..<cardViewModel.checkBadges.count {
                    cardViewModel.newCard.badges.append(cardViewModel.checkBadges[i])
                }
                cardViewModel.checkBadges = []
            }){
                ZStack {
                    Rectangle()
                        .fill(Color(red: 0.046, green: 0.128, blue: 0.446))
                        .frame(width: containerWidth, height: 56)
                        .cornerRadius(16)
                    Text("완료")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                }
            }
            
            
            
        }
        
    }
}

struct AppendingBadgeView_Previews: PreviewProvider {
    static var previews: some View {
        AppendingBadgeView(page: .constant(1))
    }
}
