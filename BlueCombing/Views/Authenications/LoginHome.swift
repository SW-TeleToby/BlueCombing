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
    
    var body: some View {
        
        VStack(spacing: 12) {
            Spacer()
            Image("LoginLogo")
            Text("카드를 만들기 위해선\n로그인이 필요해요!")
                .font(.system(size: 24, weight: .semibold))
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
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 21)
        }
    }
    
    func appleLogin() {
        appleLoginCoordinator = AppleAuthCoordinator(window: window) {
            presentationMode.wrappedValue.dismiss()
            isSignIn = true
        }
        appleLoginCoordinator?.startSignInWithAppleFlow()
    }
}

struct LoginHome_Previews: PreviewProvider {
    static var previews: some View {
        LoginHome(isSignIn: .constant(false))
    }
}
