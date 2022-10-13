//
//  LoginModal.swift
//  BlueCombing
//
//  Created by Inho Choi on 2022/10/12.
//

import SwiftUI

struct LoginModal: View {
    @Binding var currentModal: CustomModal
    @Binding var isSignIn: Bool
    @Binding var showingAlert: Bool
    @Binding var loginCancleAlertTrigger: Bool
    
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
                
                NavigationLink(destination: LoginHome(isSignIn: $isSignIn, loginMode: .beachCombing) {
                    if isSignIn {
                        currentModal = .cardMakingModal
                    } else {
                        currentModal = .loginModal
                        showingAlert = true
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
                .alert(isPresented: $showingAlert) {
                    let firstButton = Alert.Button.default(Text("확인")) {
                        withAnimation(.spring()) {
                            currentModal = .startModal
                        }
                    }
                    let secondButton = Alert.Button.cancel(Text("취소"))
                    return Alert(title: Text("로그인하지 않으면 비치코밍 기록을 남길 수 없습니다"), primaryButton: firstButton, secondaryButton: secondButton)
                }
                
                Spacer().frame(height: 16)
                
                Button(action: { loginCancleAlertTrigger.toggle() }) {
                    Text("카드를 안 만들래요")
                        .font(.Body3)
                        .foregroundColor(.combingGray2)
                }
            }
            .padding(.leading, 16)
        }
    } // loginModal
}
