//
//  LoginModal.swift
//  BlueCombing
//
//  Created by Inho Choi on 2022/10/12.
//

import SwiftUI

struct LoginModal: View {
    @EnvironmentObject var authSession: SessionStore
    
    @Binding var currentModal: CustomModal
    @Binding var showDeleteActivityDataAlert: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.combingBlue5_2)
                .cornerRadius(24, corners: [.topLeft, .topRight])
            
            VStack {
                HStack {
                    Text("쓰레기 봉투를 버리고 로그인을 하여")
                        .foregroundColor(.white)
                        .font(.Body2)
                    Spacer()
                }
                HStack {
                    Text("비치코밍 인증 카드를 만들어보세요.")
                        .foregroundColor(.white)
                        .font(.Body2)
                    Spacer()
                }
                
                Spacer().frame(height: 18)
                
                NavigationLink(destination: LoginHome(loginMode: .cardMaking) {
                    if authSession.isSignIn {
                        currentModal = .cardMakingModal
                    } else {
                        currentModal = .loginModal
                        showDeleteActivityDataAlert.toggle()
                    }
                }) {
                    ZStack {
                        Rectangle()
                            .cornerRadius(16)
                            .foregroundColor(.combingBlue4)
                        Text("로그인하러 가기")
                            .foregroundColor(.white)
                            .font(.Button1)
                    }
                }
                .frame(height: 56)
                
                Spacer().frame(height: 16)
                
                Button(action: { showDeleteActivityDataAlert.toggle() }) {
                    Text("카드를 안 만들래요")
                        .font(.Body3)
                        .foregroundColor(.combingGray2)
                }
            }
            .padding(.leading, 16)
        }
        .frame(height: currentModal.modalHeight)
    } // body
}
