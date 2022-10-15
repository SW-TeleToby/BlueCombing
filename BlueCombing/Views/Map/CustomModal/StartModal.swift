//
//  StartModal.swift
//  BlueCombing
//
//  Created by Inho Choi on 2022/10/12.
//

import SwiftUI

struct StartModal: View {
    @Binding var currentModal: CustomModal
    @Binding var isRecordStart: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                Rectangle()
                    .foregroundColor(.combingBlue5_2)
                    .cornerRadius(24, corners: [.topLeft, .topRight])
                
                VStack(alignment: .leading) {
                    
                    Text("비치코밍을 하기 전에 주변에서")
                        .foregroundColor(.combingGray1)
                        .font(.Body2)
                        .padding(.top, 24)
                        .padding(.leading, 16)
                    
                    Text("집게와 쓰레기 봉투를 받아가세요!")
                        .foregroundColor(.combingGray1)
                        .font(.Body2)
                        .padding(.leading, 16)
                    
                    Button(action: {
                        withAnimation(.spring()) {
                            currentModal = .none
                            isRecordStart = true
                        }
                    }) {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .background {
                                    Color.combingGradient1
                                }
                                .cornerRadius(16)
                            Text("비치코밍 시작하기")
                                .font(.Button1)
                                .foregroundColor(.white)
                        }
                    }
                    .frame(height: 56)
                    .padding(16)
                } // VStack
            } // Zstack
        } // VStack
        .frame(height: currentModal.modalHeight)
    } // body
}
