//
//  CardMakingModal.swift
//  BlueCombing
//
//  Created by Inho Choi on 2022/10/12.
//

import SwiftUI

struct CardMakingModal: View {
    @Binding var currentModal: CustomModal
    @Binding var isRecordEnd: Bool
    @Binding var routeImage: Image
    @Binding var movingDistance: Double
    @Binding var movingTime: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.combingBlue5_2)
                .cornerRadius(24, corners: [.topLeft, .topRight])
            
            VStack(alignment: .leading) {
                HStack {
                    Text("쓰래기봉투를 버리고")
                        .font(.Body2)
                        .foregroundColor(.white)
                    Spacer()
                }
                HStack {
                    Text("비치코밍 인증 카드를 직접 만들어보세요.")
                        .font(.Body2)
                        .foregroundColor(.white)
                }
                
                Spacer().frame(height: 16)
                
                NavigationLink {
                    MakeCardView(isCustom: true, movingDistance: movingDistance, movingTime: movingTime, routeImage: routeImage)
                        .onAppear {
                            currentModal = .startModal
                        }
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.combingBlue4)
                            .cornerRadius(16)
                        Text("직접 만들러가기")
                            .font(.Button1)
                            .foregroundColor(.white)
                    }
                }
                .frame(height: 56)
                
                Spacer().frame(height: 16)
                
                NavigationLink {
                    MakeCardView(isCustom: false, movingDistance: movingDistance, movingTime: movingTime, routeImage: routeImage)
                        .onAppear {
                            currentModal = .startModal
                        }
                } label: {
                    HStack {
                        Spacer()
                        Text("기본 카드 사용하기")
                            .font(.Body3)
                            .foregroundColor(.combingGray2)
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}
