//
//  LoginHome.swift
//  BlueCombing
//
//  Created by Wonhyuk Choi on 2022/09/11.
//

import SwiftUI

struct LoginHome: View {
    @Environment(\.window) var window: UIWindow?
    @Environment(\.presentationMode) var presentationMode
    @State private var appleLoginCoordinator: AppleAuthCoordinator?
    @Binding var isSignIn: Bool
    
    let dismissAction: () -> Void
    
    var body: some View {
        ZStack {
            Color.combingBlue1
                .ignoresSafeArea()
            VStack(spacing: 12) {
                Spacer()
                Image("img_login")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 30)
                Text("카드를 만들기 위해선\n로그인이 필요해요!")
                    .font(.custom("Pretendard-SemiBold", size: 24))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                Spacer()
                AppleLoginButtom {
                    appleLogin()
                }
                .padding(.horizontal)
                FaceBookLoginButton {
                    presentationMode.wrappedValue.dismiss()
                    isSignIn = true
                }
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 56)
                .padding(.horizontal)
                .padding(.bottom, 4)
                Button {
                    
                } label: {
                    Text("로그인하지 않을래요")
                        .font(.custom("Pretendard-SemiBold", size: 16))
                        .foregroundColor(.combingGray4)
                }
                .padding(.bottom, 21)
            }
        }
        .onDisappear {
            self.dismissAction()
        }
    }
    
    func appleLogin() {
        appleLoginCoordinator = AppleAuthCoordinator(window: window) {
            isSignIn = true
            presentationMode.wrappedValue.dismiss()
        }
        appleLoginCoordinator?.startSignInWithAppleFlow()
    }
}

struct LoginHome_Previews: PreviewProvider {
    static var previews: some View {
        LoginHome(isSignIn: .constant(false)) {
            
        }
    }
}
